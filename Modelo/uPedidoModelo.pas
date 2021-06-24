unit uPedidoModelo;

interface

  uses
    System.SysUtils;

type
  TPedido = class
  private
    FPedido: integer;
    FCliente: integer;
    FValorTotal: double;
    FDataEmissao: TDateTime;
  public
    property Pedido: integer read FPedido write FPedido;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property ValorTotal: double read FValorTotal write FValorTotal;
    property Cliente: integer read FCliente write FCliente;
  end;

implementation

end.
