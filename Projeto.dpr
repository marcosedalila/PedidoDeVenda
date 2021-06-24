program Projeto;

uses
  Vcl.Forms,
  PedidoVenda in 'Apresentacao\PedidoVenda.pas' {frmPedidoVenda},
  uPedidoModelo in 'Modelo\uPedidoModelo.pas',
  uDmPedidoVenda in 'DAO\uDmPedidoVenda.pas' {dmPedidoVenda: TDataModule},
  uClienteModelo in 'Modelo\uClienteModelo.pas',
  uClienteControle in 'Controle\uClienteControle.pas',
  uProdutoModelo in 'Modelo\uProdutoModelo.pas',
  uProdutoControle in 'Controle\uProdutoControle.pas',
  ItensPedidoModelo in 'Modelo\ItensPedidoModelo.pas',
  uPedidoControle in 'Controle\uPedidoControle.pas',
  uItensPedidoControle in 'Controle\uItensPedidoControle.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPedidoVenda, dmPedidoVenda);
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.Run;
end.
