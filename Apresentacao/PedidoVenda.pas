unit PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, uDmPedidoVenda, Data.DB, uClienteModelo, uClienteControle,
  uProdutoModelo, uProdutoControle, ItensPedidoModelo, uPedidoModelo,
  uItensPedidoControle, uPedidoControle, System.Generics.Collections, Data.DBXCommon;

type
  TfrmPedidoVenda = class(TForm)
    gbPedidoVenda: TGroupBox;
    lblCliente: TLabel;
    lblProduto: TLabel;
    lblQuantidade: TLabel;
    edQuantidade: TEdit;
    lblValorUnit: TLabel;
    GroupBox1: TGroupBox;
    btnAdd: TBitBtn;
    gdDadosPedido: TDBGrid;
    lblValorTotal: TLabel;
    lblTotalPedido: TLabel;
    btnPesquisar: TBitBtn;
    edCodigoCliente: TEdit;
    edDescricaoNome: TEdit;
    btnLimpar: TBitBtn;
    btnExcluir: TBitBtn;
    dsPesqCliente: TDataSource;
    dsPesqProduto: TDataSource;
    edCodigoProduto: TEdit;
    edDescricaoProduto: TEdit;
    edValorUnit: TEdit;
    dsDadosPedido: TDataSource;
    dsPedido: TDataSource;
    btnGravarPedido: TBitBtn;
    lblNumeroPedido: TLabel;
    edNumeroPedido: TEdit;
    lblExcluirPedido: TLabel;
    edExcluirPedido: TEdit;
    procedure edCodigoClienteExit(Sender: TObject);
    procedure edCodigoProdutoExit(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure gdDadosPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FListaItensPedido: TObjectList<TItensPedido>;
    { Private declarations }
  public
    { Public declarations }
    dQtdTotal: double;
    bPesquisar : Boolean;
    property ListaItensPedido: TObjectList<TItensPedido> read FListaItensPedido write FListaItensPedido;
    function ValidarCampos(out sMensagem: string): Boolean;
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

{$R *.dfm}

procedure TfrmPedidoVenda.btnAddClick(Sender: TObject);
var
  i : integer;
  sMensagem : string;
begin

  sMensagem := '';
  if not (ValidarCampos(sMensagem)) then
  begin
    MessageDlg(sMensagem, mtInformation, [mbOk], 0, mbOk);
  end
  else
  begin

    if (dsDadosPedido.DataSet.RecordCount > 0) and (dsDadosPedido.DataSet.State in [dsEdit]) then
    begin
      dsDadosPedido.DataSet.Post;
    end
    else
    begin
      ListaItensPedido.Add(TItensPedido.Create);
      i := ListaItensPedido.Count -1;
      ListaItensPedido[i].Produto := StrToInt(edCodigoProduto.Text);
      ListaItensPedido[i].Qtd := StrToInt(edQuantidade.Text);
      ListaItensPedido[i].ValorUnit := StrToFloat(edValorUnit.Text);
      ListaItensPedido[i].ValorTotal := (StrToInt(edQuantidade.Text) * StrToFloat(edValorUnit.Text));

      dsDadosPedido.DataSet.Append;
      dsDadosPedido.DataSet.FieldByName('Codigo').AsInteger := ListaItensPedido[i].Produto;
      dsDadosPedido.DataSet.FieldByName('Produto').AsString := edDescricaoProduto.Text;
      dsDadosPedido.DataSet.FieldByName('Qtd').AsInteger := ListaItensPedido[i].Qtd;
      dsDadosPedido.DataSet.FieldByName('ValorUnit').AsFloat := ListaItensPedido[i].ValorUnit;
      dsDadosPedido.DataSet.FieldByName('ValorTotal').AsFloat := ListaItensPedido[i].ValorTotal;
      dsDadosPedido.DataSet.Post;

    end;
    dQtdTotal := dQtdTotal + dsDadosPedido.DataSet.FieldByName('Qtd').AsInteger *
                             dsDadosPedido.DataSet.FieldByName('ValorUnit').AsFloat;
    lblTotalPedido.Caption := FormatFloat('#,##0.00', dQtdTotal);
  end;
end;

procedure TfrmPedidoVenda.btnExcluirClick(Sender: TObject);
var
  oPedidoControle: TPedidoControle;
  sMensagem : string;
  dbx : TDBXTransaction;
begin
  if (edExcluirPedido.Text = '') then
  begin
    MessageDlg('Informe o número do pedido para excluir!', mtInformation, [mbOk], 0, mbOk);
  end
  else
  begin
    try
      oPedidoControle := TPedidoControle.Create;

      dbx := dmPedidoVenda.sqlConexao.DBXConnection.BeginTransaction(TDBXIsolations.ReadCommitted);

      if not (oPedidoControle.ExcluirPedido(StrToInt(edExcluirPedido.Text), sMensagem)) then
      begin
        Exit;
      end;

      dmPedidoVenda.sqlConexao.DBXConnection.CommitFreeAndNil(dbx);

      MessageDlg('Pedido de venda excluído com sucesso!', mtInformation, [mbOk], 0, mbOk);
      btnLimparClick(btnLimpar);
    except on
      e: exception do
      begin
        raise Exception.Create(sMensagem);
        dmPedidoVenda.sqlConexao.DBXConnection.RollbackFreeAndNil(dbx);
      end;
    end;
  end;
end;

procedure TfrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
var
  oPedido: TPedido;
  oPedidoControle: TPedidoControle;
  oItensPedido: TItensPedido;
  oItensPedidoControle: TItensPedidoControle;
  sMensagem : string;
  iPedido : integer;
  iContador : integer;
  dbx : TDBXTransaction;
begin
  if dmPedidoVenda.cdsDadosPedido.RecordCount = 0 then
  begin
    MessageDlg('Não há itens do pedido. Insira itens antes de gravar pedido!', mtInformation, [mbOk], 0, mbOk);
  end
  else
  begin
    try
      iPedido := 0;
      oPedido := TPedido.Create;
      oPedidoControle := TPedidoControle.Create;
      oItensPedido := TItensPedido.Create;
      oItensPedidoControle := TItensPedidoControle.Create;

      oPedido.DataEmissao := Now;
      oPedido.ValorTotal := dQtdTotal;
      oPedido.Cliente := StrToInt(edCodigoCliente.Text);

      dbx := dmPedidoVenda.sqlConexao.DBXConnection.BeginTransaction(TDBXIsolations.ReadCommitted);

      if not (oPedidoControle.GravarPedido(oPedido, sMensagem, iPedido)) then
      begin
        Exit;
      end;

      for iContador := 0 to Pred(ListaItensPedido.Count) do
      begin
        if not (oItensPedidoControle.GravarItensPedido(ListaItensPedido[iContador], sMensagem, iPedido)) then
        begin
          Exit;
        end;
      end;

      dmPedidoVenda.sqlConexao.DBXConnection.CommitFreeAndNil(dbx);

      MessageDlg('Pedido de venda gravado com sucesso!', mtInformation, [mbOk], 0, mbOk);
      btnLimparClick(btnLimpar);

      FreeAndNil(oPedido);
      FreeAndNil(oPedidoControle);
      FreeAndNil(oItensPedido);
      FreeAndNil(oItensPedidoControle);

    except on
      e: exception do
      begin
        raise Exception.Create(sMensagem);
        dmPedidoVenda.sqlConexao.DBXConnection.RollbackFreeAndNil(dbx);
      end;
    end;
  end;
end;

procedure TfrmPedidoVenda.btnLimparClick(Sender: TObject);
begin
  dmPedidoVenda.cdsDadosPedido.CancelUpdates;
  edCodigoCliente.Text := '';
  edDescricaoNome.Text := '';
  edCodigoProduto.Text := '';
  edDescricaoProduto.Text := '';
  edQuantidade.Text := '';
  edValorUnit.Text := '';
  lblTotalPedido.Caption := '0.00';
  bPesquisar := false;
end;

procedure TfrmPedidoVenda.btnPesquisarClick(Sender: TObject);
var
  oPedidoControle: TPedidoControle;
begin

  if (edNumeroPedido.Text = '') then
  begin
    MessageDlg('Informe o número do pedido para pesquisar!', mtInformation, [mbOk], 0, mbOk);
  end
  else
  begin
    btnLimparClick(btnLimpar);
    oPedidoControle := TPedidoControle.Create;

    if not (oPedidoControle.PesquisarPedido(edCodigoCliente, lblTotalPedido, StrToInt(edNumeroPedido.Text))) then
    begin
      raise Exception.Create('Código do pedido inexistente');
      Exit;
    end
    else
    begin
      bPesquisar := true;
      edCodigoClienteExit(edCodigoCliente);
    end;
  end;
end;

procedure TfrmPedidoVenda.edCodigoClienteExit(Sender: TObject);
var
  oCliente: TCliente;
  oClienteControle: TClienteControle;
begin
  if (edCodigoCliente.Text = '') then
  begin
    edNumeroPedido.Enabled := true;
    btnPesquisar.Enabled := true;
    btnLimpar.Enabled := true;
    btnExcluir.Enabled := true;
  end
  else
  begin
    try
      oCLiente := TCliente.Create;
      oClienteControle := TClienteControle.Create;

      oClienteControle.CarregarNomeCliente(oCliente, StrToInt(edCodigoCliente.Text));
      edDescricaoNome.Text := oCliente.Nome;
    finally
      FreeAndNil(oCliente);
      FreeAndNil(oClienteControle);
    end;
    if not (bPesquisar) then
    begin
      edNumeroPedido.Enabled := false;
      btnPesquisar.Enabled := false;
      btnLimpar.Enabled := false;
      btnExcluir.Enabled := false;
    end;
  end;
end;

procedure TfrmPedidoVenda.edCodigoProdutoExit(Sender: TObject);
var
  oProduto: TProduto;
  oProdutoControle: TProdutoControle;
begin
  if (edCodigoProduto.Text <> '') then
  begin
    try
      oProduto := TProduto.Create;
      oProdutoControle := TProdutoControle.Create;

      oProdutoControle.CarregarDadosProduto(oProduto, StrToInt(edCodigoProduto.Text));
      edDescricaoProduto.Text := oProduto.Descricao;
      edValorUnit.Text := FormatFloat('#,##0.00', oProduto.PcoVenda);
    finally
      FreeAndNil(oProduto);
      FreeAndNil(oProdutoControle);
    end;
  end;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
  FListaItensPedido := TObjectList<TItensPedido>.Create;
  dQtdTotal := 0;
  lblTotalPedido.Caption := '0.00';
  bPesquisar := false;
end;

procedure TfrmPedidoVenda.gdDadosPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if MessageDlg('Deseja realmente excluir esse item?', mtConfirmation, [mbYes,mbNo],0) = mrYes then
    begin
      dQtdTotal := (dQtdTotal - dmPedidoVenda.cdsDadosPedido.FieldByName('ValorTotal').AsFloat);
      lblTotalPedido.Caption := FormatFloat('#,##0.00', dQtdTotal);
      dmPedidoVenda.cdsDadosPedido.Delete;

    end;
  end;

  if Ord(key) = 13 then
  begin
    dsDadosPedido.DataSet.Edit;
  end;
end;

function TfrmPedidoVenda.ValidarCampos(out sMensagem: string): Boolean;
var
  bRetorno : Boolean;
begin

  bRetorno := true;

  if (edCodigoCliente.Text = '') then
  begin
    sMensagem := 'Informe o código do cliente para inserir pedido!';
    bRetorno := false;
    Exit;
  end
  else
  if (edCodigoProduto.Text = '') then
  begin
    sMensagem := 'Informe o código do produto para inserir o item!';
    bRetorno := false;
    Exit;
  end
  else
  if (edQuantidade.Text = '') then
  begin
    sMensagem := 'Informe a quantidade para inserir o item!';
    bRetorno := false;
    Exit;
  end
  else
  if (edValorUnit.Text = '') then
  begin
    sMensagem := 'Informe o valor total para inserir o item!';
    bRetorno := false;
    Exit;
  end;

  Result := bRetorno;

end;

end.
