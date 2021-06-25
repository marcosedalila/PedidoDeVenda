unit uDmPedidoVenda;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Datasnap.DBClient, Data.DB,
  Data.SqlExpr, Datasnap.Provider, Data.DBXMySQL, FireDAC.Stan.Intf,
  FireDAC.Phys, FireDAC.Phys.MySQL, uClienteModelo, uProdutoModelo,
  uPedidoModelo, ItensPedidoModelo, Vcl.StdCtrls;

type
  TdmPedidoVenda = class(TDataModule)
    dspPesqCliente: TDataSetProvider;
    sqlPesqCliente: TSQLDataSet;
    cdsPesqCliente: TClientDataSet;
    sqlConexao: TSQLConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    sqlPesqClienteNome: TStringField;
    cdsPesqClienteNome: TStringField;
    dspPesqProduto: TDataSetProvider;
    sqlPesqProduto: TSQLDataSet;
    cdsPesqProduto: TClientDataSet;
    sqlPesqProdutoDescricao: TStringField;
    cdsPesqProdutoDescricao: TStringField;
    sqlPesqProdutoPco_Venda: TSingleField;
    cdsPesqProdutoPco_Venda: TSingleField;
    dspPedido: TDataSetProvider;
    sqlPedido: TSQLDataSet;
    cdsPedido: TClientDataSet;
    cdsDadosPedido: TClientDataSet;
    cdsDadosPedidoChave: TIntegerField;
    cdsDadosPedidoCodigo: TIntegerField;
    cdsDadosPedidoProduto: TStringField;
    cdsDadosPedidoQtd: TIntegerField;
    cdsDadosPedidoValorUnit: TSingleField;
    cdsDadosPedidoValorTotal: TSingleField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsDadosPedidoQtdChange(Sender: TField);
    procedure cdsDadosPedidoValorUnitChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    sQuery : TStringList;
    function BuscaNomeCliente(oCliente: TCliente; iCodigo: integer) : string;
    function BuscaDadosProduto(oProduto: TProduto; iCodigo: integer) : string;
    function Gravar(oPedido: TPedido; out sMensagem: string; out iCodigoPedido: integer): Boolean;
    function GravarItens(oItensPedido: TItensPedido; out sMensagem: string; var iCodigoPedido: integer): Boolean;
    function BuscaCodigoPedidoInserido() : integer;
    function BuscaPedidoVenda(edCliente, lblTotal: TObject; iCodigoPedido: integer): Boolean;
    function ExcluirPedidoVenda(iCodigoPedido: integer; out sMensagem: string): Boolean;
    procedure RecalculaCampos();
    //function AdicionarPedido();
  end;

var
  dmPedidoVenda: TdmPedidoVenda;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmPedidoVenda }

function TdmPedidoVenda.BuscaNomeCliente(oCliente: TCliente; iCodigo: integer): string;
begin
  try
    sQuery := TStringList.Create();
    sQuery.Text := 'SELECT C.Nome';
    sQuery.Text := sQuery.Text + 'FROM Clientes C';
    sQuery.Text := sQuery.Text + 'WHERE C.Codigo = :pCodigo';

    sqlPesqCliente.Close;
    sqlPesqCliente.CommandText := sQuery.Text;
    sqlPesqCliente.Params[0].AsInteger := iCodigo;
    sqlPesqCliente.Open;

    oCliente.Nome := sqlPesqCliente.FieldByName('Nome').AsString;
  finally
    FreeAndNil(sQuery);
  end;
end;

function TdmPedidoVenda.BuscaPedidoVenda(edCliente, lblTotal: TObject; iCodigoPedido: integer): Boolean;
var
  SQLQuery : TSQLQuery;
  dTotal : double;
begin

  try
    dTotal := 0;
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := sqlConexao;
    SQLQuery.Close;
    SQLQuery.SQL.Add('SELECT P.Cliente, IP.Produto, PR.Descricao, IP.Qtd, IP.Valor_Unit, IP.Valor_Total');
    SQLQuery.SQL.Add('FROM Pedidos P');
    SQLQuery.SQL.Add('JOIN Itens_Pedido IP ON P.Pedido = IP.Codigo_Pedido');
    SQLQuery.SQL.Add('JOIN Produtos PR ON IP.Produto = PR.Codigo');
    SQLQuery.SQL.Add('WHERE P.Pedido = :pCodigoPedido');

    SQLQuery.Params[0].AsInteger := iCodigoPedido;

    SQLQuery.Open;

    if not (SQLQuery.IsEmpty) then
    begin
      SQLQuery.First;

      if (edCliente is TEdit) then
      begin
        TEdit(edCliente).Text := SQLQuery.FieldByName('Cliente').AsString;
      end;

      while not (SQLQuery.Eof) do
      begin
        cdsDadosPedido.Append;
        cdsDadosPedido.FieldByName('Codigo').AsInteger := SQLQuery.FieldByName('Produto').AsInteger;
        cdsDadosPedido.FieldByName('Produto').AsString := SQLQuery.FieldByName('Descricao').AsString;
        cdsDadosPedido.FieldByName('Qtd').AsInteger := SQLQuery.FieldByName('Qtd').AsInteger;
        cdsDadosPedido.FieldByName('ValorUnit').AsFloat := SQLQuery.FieldByName('Valor_Unit').AsFloat;
        cdsDadosPedido.FieldByName('ValorTotal').AsFloat := SQLQuery.FieldByName('Valor_Total').AsFloat;
        dTotal := dTotal + SQLQuery.FieldByName('Valor_Total').AsFloat;
        cdsDadosPedido.Post;
        cdsDadosPedido.Next;
        SQLQuery.Next;
      end;
      Result := true;

      if (lblTotal is TLabel) then
      begin
        TLabel(lblTotal).Caption := FormatFloat('#,##0.00', dTotal);
      end;
    end
    else
    begin
      Result := false;
    end;

  finally
    FreeAndNil(SQLQuery);
  end;

end;

procedure TdmPedidoVenda.cdsDadosPedidoQtdChange(Sender: TField);
begin
  RecalculaCampos();
end;

procedure TdmPedidoVenda.cdsDadosPedidoValorUnitChange(Sender: TField);
begin
  RecalculaCampos();
end;

procedure TdmPedidoVenda.DataModuleCreate(Sender: TObject);
begin
  cdsDadosPedido.CreateDataSet;
  cdsDadosPedido.Open;
end;

function TdmPedidoVenda.ExcluirPedidoVenda(iCodigoPedido: integer; out sMensagem: string): Boolean;
var
  SQLQuery : TSQLQuery;
begin
  try

    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := sqlConexao;
    SQLQuery.Close;
    SQLQuery.SQL.Add('DELETE FROM Itens_Pedido');
    SQLQuery.SQL.Add('WHERE Codigo_Pedido = :pCodigoPedido');

    SQLQuery.Params[0].AsInteger := iCodigoPedido;
    SQLQuery.ExecSQL;

    SQLQuery.SQL.Clear;
    SQLQuery.Close;
    SQLQuery.SQL.Add('DELETE FROM Pedidos');
    SQLQuery.SQL.Add('WHERE Pedido = :pCodigoPedido');

    SQLQuery.Params[0].AsInteger := iCodigoPedido;
    SQLQuery.ExecSQL;

    Result := true
  except on
    e: exception do
    begin
      FreeAndNil(sQuery);
      sMensagem := 'Ocorreu o seguinte erro ao excluir pedido: ' + e.Message;
      Result := false;
    end;
  end;
end;

function TdmPedidoVenda.BuscaCodigoPedidoInserido: integer;
var
  SQLQuery : TSQLQuery;
begin

  try
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := sqlConexao;
    SQLQuery.Close;
    SQLQuery.SQL.Add('SELECT MAX(Pedido) AS Pedido FROM Pedidos');
    SQLQuery.Open;

    Result := SQLQuery.FieldByName('Pedido').AsInteger;

  finally
    FreeAndNil(SQLQuery);
  end;

end;

function TdmPedidoVenda.BuscaDadosProduto(oProduto: TProduto; iCodigo: integer): string;
begin
  try
    sQuery := TStringList.Create();
    sQuery.Text := 'SELECT P.Descricao, P.Pco_Venda';
    sQuery.Text := sQuery.Text + 'FROM Produtos P';
    sQuery.Text := sQuery.Text + 'WHERE P.Codigo = :pCodigo';

    sqlPesqProduto.Close;
    sqlPesqProduto.CommandText := sQuery.Text;
    sqlPesqProduto.Params[0].AsInteger := iCodigo;
    sqlPesqProduto.Open;

    oProduto.Descricao := sqlPesqProduto.FieldByName('Descricao').AsString;
    oProduto.PcoVenda := sqlPesqProduto.FieldByName('Pco_Venda').AsFloat;
  finally
    FreeAndNil(sQuery);
  end;
end;

function TdmPedidoVenda.Gravar(oPedido: TPedido; out sMensagem: string; out iCodigoPedido: integer): Boolean;
begin
  try
    sQuery := TStringList.Create();
    sQuery.Text := 'INSERT INTO PEDIDOS(Data_Emissao, Valor_Total, Cliente)';
    sQuery.Text := sQuery.Text + 'VALUES(:pDataEmissao, :pValorTotal, :pCliente)';

    dmPedidoVenda.sqlPedido.Close;
    dmPedidoVenda.sqlPedido.CommandText := sQuery.Text;
    dmPedidoVenda.sqlPedido.Params[0].AsDateTime := oPedido.DataEmissao;
    dmPedidoVenda.sqlPedido.Params[1].AsFloat := oPedido.ValorTotal;
    dmPedidoVenda.sqlPedido.Params[2].AsInteger := oPedido.Cliente;
    dmPedidoVenda.sqlPedido.ExecSQL;

    iCodigoPedido := BuscaCodigoPedidoInserido();

    FreeAndNil(sQuery);
    Result := true;

  except on
    e: exception do
    begin
      FreeAndNil(sQuery);
      sMensagem := 'Ocorreu o seguinte erro ao inserir o pedido: ' + e.Message;
      Result := false;
    end;
  end;
end;

function TdmPedidoVenda.GravarItens(oItensPedido: TItensPedido;
  out sMensagem: string; var iCodigoPedido: integer): Boolean;
begin
  try
    sQuery := TStringList.Create();
    sQuery.Text := 'INSERT INTO ITENS_PEDIDO(Produto, Qtd, Valor_Unit, Valor_Total, Codigo_Pedido)';
    sQuery.Text := sQuery.Text + 'VALUES(:pProduto, :pQtd, :pValorUnit, :pValorTotal, :pCodigoPedido)';

    dmPedidoVenda.sqlPedido.Close;
    dmPedidoVenda.sqlPedido.CommandText := sQuery.Text;
    dmPedidoVenda.sqlPedido.Params[0].AsInteger := oItensPedido.Produto;
    dmPedidoVenda.sqlPedido.Params[1].AsInteger := oItensPedido.Qtd;
    dmPedidoVenda.sqlPedido.Params[2].AsFloat := oItensPedido.ValorUnit;
    dmPedidoVenda.sqlPedido.Params[3].AsFloat := oItensPedido.ValorTotal;
    dmPedidoVenda.sqlPedido.Params[4].AsInteger := iCodigoPedido;
    dmPedidoVenda.sqlPedido.ExecSQL;

    FreeAndNil(sQuery);
    Result := true;

  except on
    e: exception do
    begin
      FreeAndNil(sQuery);
      sMensagem := 'Ocorreu o seguinte erro ao inserir os itens do pedido: ' + e.Message;
      Result := false;
    end;
  end;
end;

procedure TdmPedidoVenda.RecalculaCampos;
begin
  if (cdsDadosPedido.State in [dsEdit]) then
  begin
    cdsDadosPedido.FieldByName('ValorTotal').AsFloat := cdsDadosPedido.FieldByName('Qtd').AsFloat *
                                                        cdsDadosPedido.FieldByName('ValorUnit').AsFloat;
  end;
end;

end.
