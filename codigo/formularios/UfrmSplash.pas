unit UfrmSplash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.DateUtils,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  UfrmLogomarca;

type
  TfrmSplash = class(TForm)
    pnlFundo: TPanel;
    tmrSplash: TTimer;
    frmLogo: TfrmLogo;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure ShowPainelGestao();
    procedure ShowLogin();
    procedure InicializeApplication();
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmPainelGestao, UfrmLogin, UiniUtils, UFormUtils;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Inicialized := false;
  tmrSplash.Enabled := false;
  tmrSplash.Interval := 1000;
end;

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializeApplication;
var
  LLogado : String;
  LDateString : String;
  LUltimo_login : TDateTime;
  LDias_logado : Double;
const
  DURACAO_LOGIN_DIAS = 5;
begin
  LLogado := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO);
  LDateString := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.ULTIMO_LOGIN);
  LUltimo_login := StrToDateTime(LDateString);
  LDias_logado := DaysBetween(Now, LUltimo_login);

  if (LLogado = TIniUtils.VALOR_VERDADEIRO) and (LDias_logado < DURACAO_LOGIN_DIAS) then
  begin
    ShowPainelGestao;
  end
  else begin
    ShowLogin;
  end;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  if not Inicialized then
  begin
    Inicialized := true;
    InicializeApplication();
  end;
end;

procedure TfrmSplash.ShowLogin;
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  TformUtils.SetMainForm(frmLogin);
  frmLogin.Show();
  Close;
end;

procedure TfrmSplash.ShowPainelGestao;
begin
  if not Assigned(frmPainelGestao) then
  begin
    Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  end;

  TformUtils.SetMainForm(frmPainelGestao);
  frmPainelGestao.Show;

  Close;
end;

end.


