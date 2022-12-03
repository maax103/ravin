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
  // nome não pode ser vazio
  // login não pode ser vazio
  // senha não pode ser vazio e = a confirmação de senha
  // cpf não pode ser vazio
  //
begin
  if PUsuario.login.isEmpty then
  begin
    raise Exception.Create('O campo login não pode ser vazio');
  end;

  if PUsuario.senha.isEmpty then
  begin
    raise Exception.Create('O campo senha não pode ser vazio');
  end;

  if PUsuario.senha <> PSenhaconfirmacao then
  begin
    raise Exception.Create('A senha e a confirmação devem ser iguais');
  end;
end;

end.
