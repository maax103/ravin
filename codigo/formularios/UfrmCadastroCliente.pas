unit UfrmCadastroCliente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.WinXCtrls,
  UfrmBotaoPrimario,

  UfrmBotaoExcluir,
  UfrmBotaoCancelar;

type
  TfrmCadastroCliente = class(TForm)
    pnlCadastroCliente: TPanel;
    lblCadastroCliente: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    mskCpf: TMaskEdit;
    dtpDataNascimento: TDateTimePicker;
    lblInformacoesGerenciais: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    frmBotaoExcluir: TfrmBotaoExcluir;
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure lblInformacoesGerenciaisspbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoExcluirspbBotaoExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  UPessoa, UpessoaDao, UfrmListaClientes;

{$R *.dfm}

procedure TfrmCadastroCliente.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroCliente.frmBotaoExcluirspbBotaoExcluirClick(
  Sender: TObject);
begin
  if MessageDlg('Deseja realmente excluir o registro?',
    TMsgDlgType.mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    MessageDlg('Saindo da aplicação.', mtInformation,
      [mbOk], 0, mbOk);
    Close;
  end;
end;

procedure TfrmCadastroCliente.lblInformacoesGerenciaisspbBotaoPrimarioClick(
  Sender: TObject);
var
  LPessoa : TPessoa;
  LPessoaDao : TPessoaDao;
begin
  LPessoa := TPessoa.Create;
  LPessoa.nome := edtNome.Text;
  LPessoa.cpf := mskCpf.Text;
  LPessoa.telefone := StrToInt(edtTelefone.Text);
  try
    LPessoaDao := TPessoaDao.Create;
    LPessoaDao.inserirCliente(LPessoa);
    ShowMessage('Cliente cadastrado com sucesso!');
    frmListaClientes.limparLista;
    frmListaClientes.atualizarLista;
  finally
    FreeAndNil(LPessoa);
    FreeAndNil(LPessoaDao);
  end;
  Close;
end;

end.
