unit uProdutoControle;

interface

uses uProdutoModelo, uDmPedidoVenda;

type
  TProdutoControle = class
    public
    procedure CarregarDadosProduto(oProduto: TProduto; iCodigo: Integer);
  end;

implementation

{ TClienteControle }

procedure TProdutoControle.CarregarDadosProduto(oProduto: TProduto; iCodigo: Integer);
begin
  dmPedidoVenda.BuscaDadosProduto(oProduto, iCodigo);
end;

end.
