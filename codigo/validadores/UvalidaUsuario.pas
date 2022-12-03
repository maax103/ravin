unit UvalidaUsuario;

interface

uses
  UUsuario;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PUsuario : TUsuario; PSenhaconfirmacao : String);
end;

implementation

uses
  System.SysUtils;

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario : TUsuario; PSenhaconfirmacao : String);
  // nome n�o pode ser vazio
  // login n�o pode ser vazio
  // senha n�o pode ser vazio e = a confirma��o de senha
  // cpf n�o pode ser vazio
  //
begin
  if PUsuario.login.isEmpty then
  begin
    raise Exception.Create('O campo login n�o pode ser vazio');
  end;

  if PUsuario.senha.isEmpty then
  begin
    raise Exception.Create('O campo senha n�o pode ser vazio');
  end;

  if PUsuario.senha <> PSenhaconfirmacao then
  begin
    raise Exception.Create('A senha e a confirma��o devem ser iguais');
  end;
end;

end.
