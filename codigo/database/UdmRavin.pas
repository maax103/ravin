unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses
  Vcl.Dialogs, UResourceUtils, UiniUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
var
  LCriarBaseDados: Boolean;
begin
  LCriarBaseDados := not FileExists
    (TIniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.FOLDER) + 'pessoa.ibd');
  if LCriarBaseDados then
  begin
    CriarTabelas;
    InserirDados;
  end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCriarBaseDados: Boolean;
begin
  LCriarBaseDados := not FileExists
    (TIniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.FOLDER) + 'pessoa.ibd');
  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := TiniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.Server);
    Params.Values['User_Name'] := TiniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.User_Name);
    Params.Values['Password'] := TiniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.Password);
    Params.Values['DriverID'] := TiniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.DriverID);
    Params.Values['Port'] := TiniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.Port);

    if not LCriarBaseDados then
    begin
      Params.Values['Database'] := TiniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.NOME_DATABASE);
    end;
  end

end;

procedure TdmRavin.CriarTabelas;
var
  LSqlArquivoScripts: TStringList;
  LCaminhoArquivo: String;
  LDBfolder : String;
begin
  LSqlArquivoScripts := TStringList.Create();
  LDBfolder := TIniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.SCRIPTS_FOLDER);
  LCaminhoArquivo := LDBfolder + 'createTable.sql';
  LSqlArquivoScripts.LoadFromFile(LCaminhoArquivo);
  cnxBancoDeDados.ExecSQL(LSqlArquivoScripts.Text);
  FreeAndNil(LSqlArquivoScripts);
end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
begin
  if not cnxBancoDeDados.Connected then
    cnxBancoDeDados.Connected := true;
end;

procedure TdmRavin.InserirDados;
var
  LSqlArquivoScript: TStringList;
  LCaminhoArquivo: String;
  LDBfolder : String;
begin
  LSqlArquivoScript := TStringList.Create();
  LDBfolder := TIniUtils.lerPropriedade(TSECAO.DATABASE, TPROPRIEDADE.SCRIPTS_FOLDER);
  LCaminhoArquivo := LDBfolder + 'inserts.sql';
  LSqlArquivoScript.LoadFromFile(LCaminhoArquivo);

  try
    cnxBancoDeDados.StartTransaction();
    cnxBancoDeDados.ExecSQL(
      TResourceUtils.carregarArquivoResource('insert','ravin')
    );
    cnxBancoDeDados.Commit();
  except
    on E: Exception do
    begin
      cnxBancoDeDados.Rollback();
      ShowMessage('Erro ao executar comando SQL: ' + E.Message);
    end;
  end;

  FreeAndNil(LSqlArquivoScript);
end;

end.
