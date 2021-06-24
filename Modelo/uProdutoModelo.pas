unit uProdutoModelo;

interface

type
  TProduto = class
  private
    FPcoVenda: double;
    FDescricao: string;
    FCodigo: integer;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property PcoVenda: double read FPcoVenda write FPcoVenda;
  end;

implementation

end.
