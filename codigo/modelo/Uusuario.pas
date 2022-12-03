unit UUsuario;

interface

type Tusuario = class
  private
    Fid: Integer;
    Flogin: String;
    FPessoaId: Integer;
    Fsenha: String;
    FCriadoem: TDateTime;
    FCriadoPor: String;
    FALteradoEm: TdateTime;
    FAlteradoPor: String;
    FProdutoId: Integer;

  protected

  public
  property id :Integer           read Fid          write Fid;
  property login: String         read Flogin       write Flogin;
  property senha: String         read Fsenha       write Fsenha;
  property PessoaId: Integer     read FPessoaId    write FPessoaId;
  property ProdutoId: Integer    read FProdutoId   write FProdutoId;
  property Criadoem: TDateTime   read FCriadoem    write FCriadoem;
  property CriadoPor: String     read FCriadoPor   write FCriadoPor;
  property AlteradoEm: TdateTime read FALteradoEm  write FALteradoEm;
  property AlteradoPor: String   read FAlteradoPor write FAlteradoPor;
end;

implementation

end.
