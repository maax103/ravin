unit UusuarioDao;

interface

uses
  UUsuario, System.Classes, System.Generics.Collections;

type TusuarioDao = class
  private

  protected

  public
  function BuscarTodosUsuarios : TList<TUsuario>;
  function BuscarUsuarioPorLoginSenha(
    PLogin : String;PSenha:String):TUsuario;
  procedure InserirUsuario(PUsuario: TUsuario);
end;

implementation

uses
  FireDAC.Comp.Client, UdmRavin, System.SysUtils;

{ TusuarioDao }

function TusuarioDao.BuscarTodosUsuarios: TList<TUsuario>;
var
  LLista : TList<Tusuario>;
  LU1, LU2, LU3 : Tusuario;
begin

  LU1 := Tusuario.Create;
  LU1.id := 1;
  LU1.login := 'Max';
  LU1.senha := '123';

  LLista.Add(LU1);

end;

function TusuarioDao.BuscarUsuarioPorLoginSenha(PLogin,
  PSenha: String): TUsuario;
var
  LQuery : TFDQuery;
  LUsuario : TUsuario;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM usuario' +
      ' WHERE login = :login AND senha = :senha';
  LQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := PSenha;
  LQuery.Open();

  LUsuario := nil;

  if not LQuery.IsEmpty then
  begin
    LUsuario := Tusuario.Create();
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.PessoaId := LQuery.FieldByName('pessoaId').AsInteger;
    LUsuario.Criadoem := LQuery.FieldByName('criadoEm').AsDateTime;
    LUsuario.CriadoPor := LQuery.FieldByName('criadoPor').AsString;
    LUsuario.AlteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
    LUsuario.AlteradoPor := LQuery.FieldByName('alteradoPor').AsString;
  end;

  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LUsuario;
end;

procedure TusuarioDao.InserirUsuario(PUsuario: TUsuario);
var
  LQuery : TFDQuery;
begin

  LQuery := TFDQuery.Create(nil);
  with LQuery do
  begin
    Connection := dmRavin.cnxBancoDeDados;
    SQL.Add('INSERT INTO usuario ');
    SQL.Add('(login, senha, pessoaId, criadoEm, ');
    SQL.Add(' criadoPor, alteradoEm, alteradoPor) ');
    sql.Add(' VALUES (:login, :senha, :pessoaId, :criadoEm, ');
    sql.Add(' :criadoPor, :alteradoEm, :alteradoPor)');

    ParamByName('login').AsString := PUsuario.login;
    ParamByName('senha').AsString := PUsuario.senha;
    ParamByName('pessoaId').AsInteger := PUsuario.PessoaId;
    ParamByName('criadoEm').AsDateTime := PUsuario.Criadoem;
    ParamByName('criadoPor').AsString := PUsuario.CriadoPor;
    ParamByName('alteradoEm').AsDateTime := PUsuario.AlteradoEm;
    ParamByName('alteradoPor').AsString := PUsuario.AlteradoPor;

    LQuery.ExecSQL;
  end;

  FreeAndNil(LQuery);

end;

end.
