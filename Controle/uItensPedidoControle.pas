unit uItensPedidoControle;

interface

uses ItensPedidoModelo, uDmPedidoVenda;

type
  TItensPedidoControle = class
    public
    function GravarItensPedido(oItensPedido: TItensPedido; var sMensagem: string; var iCodigoPedido: integer): Boolean;
  end;

implementation

{ TItensPedidoControle }

function TItensPedidoControle.GravarItensPedido(oItensPedido: TItensPedido;
  var sMensagem: string; var iCodigoPedido: integer): Boolean;
begin
  Result := dmPedidoVenda.GravarItens(oItensPedido, sMensagem, iCodigoPedido);
end;

end.
