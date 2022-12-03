unit UResourceUtils;

interface

uses
  Vcl.Dialogs;

type TResourceUtils = class
  private

  protected

  public
    class function carregarArquivoResource(pNomeArquivo : String; pNomeAplicacao : String) : String;
end;

implementation

uses
  System.Classes, Math,
  System.IOUtils, System.SysUtils;

{ TResouceUtils }

class function TResourceUtils.carregarArquivoResource(pNomeArquivo : String; pNomeAplicacao : String) : String;
var
  LCaminhoArquivo : String;
  LCaminhoAplicacao : String;
  LConteudoArquivo: TStringList;
begin
  Result := '';

  try
    LCaminhoAplicacao := TPath.Combine(TPath.GetDocumentsPath, pNomeAplicacao);
    LCaminhoArquivo   := Tpath.Combine(LCaminhoAplicacao, pNomeArquivo);
    LConteudoArquivo := TStringList.Create();
    try
      LConteudoArquivo.LoadFromFile(LCaminhoArquivo);
      Result := LConteudoArquivo.Text;
    except on E: Exception do
      raise Exception.Create('Erro ao ler arquivo: ' + E.ToString);
    end;
  finally
    LConteudoArquivo.Free;
  end;

end;

end.
