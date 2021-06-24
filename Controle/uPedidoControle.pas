unit uPedidoControle;

interface

uses uPedidoModelo, uDmPedidoVenda, Datasnap.DBClient, System.Classes;

type
  TPedidoControle = class
    public
    function GravarPedido(oPedido: TPedido; var sMensagem: string; var iCodigoPedido: integer): Boolean;
    function PesquisarPedido(edCliente, lblTotal: TObject; iCodigoPedido: integer) : Boolean;
    function ExcluirPedido(iCodigoPedido: integer; var sMensagem: string): Boolean;
  end;

implementation

{ TPedidoControle }


function TPedidoControle.PesquisarPedido(edCliente, lblTotal: TObject;
  iCodigoPedido: integer): Boolean;
begin
  Result := dmPedidoVenda.BuscaPedidoVenda(edCliente, lblTotal, iCodigoPedido);
end;

{ TPedidoControle }

function TPedidoControle.ExcluirPedido(iCodigoPedido: integer;
  var sMensagem: string): Boolean;
begin
  Result := dmPedidoVenda.ExcluirPedidoVenda(iCodigoPedido, sMensagem);
end;

function TPedidoControle.GravarPedido(oPedido: TPedido;
  var sMensagem: string; var iCodigoPedido: integer): Boolean;
begin
  Result := dmPedidoVenda.Gravar(oPedido, sMensagem, iCodigoPedido);
end;

end.
