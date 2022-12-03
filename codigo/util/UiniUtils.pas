unit UiniUtils;

interface

uses
  System.IOUtils,

  Vcl.Forms,

  TypInfo,
  IniFiles;

type
  TSECAO = (CONFIGURACOES, INFORMACOES_GERAIS, DATABASE);

type
  TPROPRIEDADE = (NOME_USUARIO, NOME_DATABASE, LOGADO, ULTIMO_LOGIN,
    Server, User_Name, Password, DriverID, Port, FOLDER, SCRIPTS_FOLDER);

type
  TIniUtils = class
  private

  protected

  public
    constructor Create();
    destructor Destroy; override;

    class procedure gravarPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE; PValor: String);
    class function lerPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE): String;

    const VALOR_VERDADEIRO : String = 'true';
    const VALOR_FALSO      : String = 'false';
  end;

implementation

uses
  System.SysUtils;

{ TIniUltis }

constructor TIniUtils.Create;
begin
  inherited;

end;

destructor TIniUtils.Destroy;
begin

  inherited;
end;

class procedure TIniUtils.gravarPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE; PValor: String);
var
  LcaminhoArquivoIni, LNomePropriedade, LNomeSecao: String;
  LarquivoINI:        TIniFile;
begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');

  LarquivoINI      := TIniFile.Create(LcaminhoArquivoIni);
  LNomeSecao       := GetEnumName(TypeInfo(TSECAO), Integer(PSecao));
  LNomePropriedade := GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade));
  LarquivoINI.WriteString(LNomeSecao, LNomePropriedade, PValor);
  LarquivoINI.Free;
end;

class function TIniUtils.lerPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE): String;
var
  LcaminhoArquivoIni, LNomeSecao,LNomePropriedade: String;
  LarquivoINI:        TIniFile;
begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');

  LarquivoINI      := TIniFile.Create(LcaminhoArquivoIni);
  LNomeSecao       := GetEnumName(TypeInfo(TSECAO),Integer(PSecao));
  LNomePropriedade := GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade));

  Result := LarquivoINI.ReadString(LNomeSecao, LNomePropriedade, '');

  LarquivoINI.Free;

  if Result = '' then
    Result := 'Erro 404';

end;

end.
