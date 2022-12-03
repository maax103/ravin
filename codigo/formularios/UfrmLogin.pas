unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, UfrmBotaoSubmit, UiniUtils;

type
  TfrmLogin = class(TForm)
    bgPanel: TPanel;
    Image1: TImage;
    lbTittle: TLabel;
    lbSubTittle: TLabel;
    edtUser: TEdit;
    edtPass: TEdit;
    lbHelp: TLabel;
    lbRegister: TLabel;
    Frame11: TFrame1;
    Shape1: TShape;
    procedure Frame11Panel1Click(Sender: TObject);
    procedure lbRegisterClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure SetarFormPrincipal(PNovoFormulario : TForm);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UusuarioDao, UUsuario, UfrmPainelGestao, UfrmRegistrar;

{$R *.dfm}

procedure TfrmLogin.Button1Click(Sender: TObject);
var
  LUsuario : TUsuario;
  Ldao : TUsuarioDao;
begin

  LUsuario := Tusuario.Create;
  LUsuario.login := 'teste';
  LUsuario.senha := '123';
  LUsuario.PessoaId := 1;
  LUsuario.criadoEm := Now();
  LUsuario.criadoPor := 'max';
  LUsuario.alteradoEm := Now();
  LUsuario.alteradoPor := 'max';

  Ldao := TusuarioDao.Create();
  Ldao.InserirUsuario(LUsuario);

  FreeAndNil(Ldao);
  FreeAndNil(LUsuario);

end;

procedure TFrmLogin.SetarFormPrincipal(PNovoFormulario:Tform);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := PNovoFormulario;
end;

procedure TfrmLogin.Frame11Panel1Click(Sender: TObject);
var
  Ldao : TusuarioDao;
  LUsuario : TUsuario;
  LLogin, LSenha : String;
begin
  Ldao := nil;
  LUsuario := nil;
  Ldao := TusuarioDao.Create();
  LLogin := edtUser.Text;
  LSenha := edtPass.Text;

  LUsuario := Ldao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

  if Assigned(LUsuario) then
  begin
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS,
    TPROPRIEDADE.LOGADO, TIniUtils.Valor_Verdadeiro);

    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.ULTIMO_LOGIN,
      DateTimeToStr(Now));
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.NOME_USUARIO,
      LUsuario.login);

    if not Assigned(frmPainelGestao) then
    begin
      Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
    end;
    SetarFormPrincipal(frmPainelGestao);
    frmPainelGestao.Show();

    Close;
  end
  else
  begin
    ShowMessage('Login ou senha inválidos!')
  end;
  FreeAndNil(LDao);
  FreeAndNil(LUsuario);
end;

procedure TfrmLogin.lbRegisterClick(Sender: TObject);

begin
if not Assigned(frmRegistrar) then
  begin
    Application.CreateForm(TfrmRegistrar, frmRegistrar);
  end;
  SetarFormPrincipal(frmRegistrar);
  frmRegistrar.Show();
  Close();
end;

end.
