unit ItensPedidoModelo;

interface

type
  TItensPedido = class
  private
    FProduto: integer;
    FQtd: integer;
    FValorUnit: double;
    FCodigo: integer;
    FValorTotal: double;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Produto: integer read FProduto write FProduto;
    property Qtd: integer read FQtd write FQtd;
    property ValorUnit: double read FValorUnit write FValorUnit;
    property ValorTotal: double read FValorTotal write FValorTotal;
    property CodigoPedido: integer read FCodigo write FCodigo;
  end;

implementation

end.
