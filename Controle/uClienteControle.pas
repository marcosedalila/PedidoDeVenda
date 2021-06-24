unit uClienteControle;

interface
  uses
    uClienteModelo, uDmPedidoVenda;

type
  TClienteControle = class
    public
    procedure CarregarNomeCliente(oCliente: TCliente; iCodigo: Integer);
  end;

implementation

{ TClienteControle }

procedure TClienteControle.CarregarNomeCliente(oCliente: TCliente;
  iCodigo: Integer);
begin
  dmPedidoVenda.BuscaNomeCliente(oCliente, iCodigo);
end;

end.
