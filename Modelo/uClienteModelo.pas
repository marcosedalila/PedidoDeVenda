unit uClienteModelo;

interface

type
  TCliente = class
  private
    FUF: string;
    FCodigo: integer;
    FNome: string;
    FCidade: string;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Cidade: string read FCidade write FCidade;
    property UF: string read FUF write FUF;

  end;

implementation

end.
