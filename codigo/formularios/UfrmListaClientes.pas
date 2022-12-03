unit UfrmListaClientes;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,

  UfrmBotaoPrimario,
  UfrmBotaoCancelar, Vcl.ExtCtrls, UPessoa, UpessoaDao;

type
  TfrmListaClientes = class(TForm)
    frmBotaoPrimario: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    lvwClientes: TListView;
    Shape1: TShape;
    Shape2: TShape;
    Shape5: TShape;
    lblInformacoesGerenciais: TLabel;
    pnlListaClientes: TPanel;
    lblListaClientesTitulo: TLabel;
    procedure frmBotaoPrimariospbBotaoPrimarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure atualizarLista;
    procedure limparLista;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FPessoas: TList<TPessoa>;
  public
    { Public declarations }
  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

uses
  UfrmCadastroCliente;

{$R *.dfm}

procedure TfrmListaClientes.atualizarLista;
var
  LpessoaDao: TPessoaDao;
  I: Integer;
  Litem: TListItem;
begin
  lvwClientes.Clear;
  try
    LpessoaDao := TPessoaDao.Create;
    FPessoas   := LpessoaDao.buscarTodosOsClientes;
    for I := 0 to FPessoas.Count - 1 do
    begin
      Litem := lvwClientes.Items.Add;
      Litem.Caption := (FPessoas[I].nome);
      Litem.SubItems.Add(FPessoas[I].cpf);
      Litem.SubItems.Add(FPessoas[I].telefone.ToString);
      if FPessoas[I].ativo then
        Litem.SubItems.Add('Ativo')
      else
        Litem.SubItems.Add('Inativo');
    end;
  finally
    FreeAndNil(LpessoaDao);
  end;
end;

procedure TfrmListaClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  limparLista;
end;

procedure TfrmListaClientes.FormShow(Sender: TObject);
begin
  atualizarLista;
end;

procedure TfrmListaClientes.frmBotaoPrimariospbBotaoPrimarioClick
  (Sender: TObject);
var
  Litem: TListItem;
begin
  if not Assigned(frmCadastroCliente) then
  begin
    Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  end;
  frmCadastroCliente.Show;
end;

procedure TfrmListaClientes.limparLista;
var
  I : Integer;
begin
  lvwClientes.Clear;

  for I := 0 to FPessoas.Count - 1 do
    FreeAndNil(FPessoas[I]);
  FreeAndNil(FPessoas);
end;

end.
