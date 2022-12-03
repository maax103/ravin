unit UpessoaDao;

interface

uses
  UPessoa, System.Generics.Collections;

type
  TPessoaDao = class
    private
    protected
    public
      function buscarPessoaPorId(Pid : Integer) : TPessoa;
      function buscarIdPorCPF (Pcpf : String) : Integer;
      function buscarTodasAsPessoas : TList<TPessoa>;
      function buscarTodosOsClientes : TList<TPessoa>;
      procedure inserirFuncionario( const PPessoa : TPessoa);
      procedure inserirCliente( const PPessoa : TPessoa);
      function checarExistencia(Pcpf : String) : Boolean;
  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils, UdmRavin;

{ TPessoaDao }

function TPessoaDao.buscarIdPorCPF(Pcpf: String): Integer;
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);

  try
    with LQuery do
    begin
      Connection := dmRavin.cnxBancoDeDados;

      SQL.Add('SELECT * FROM pessoa where cpf = :cpf');
      ParamByName('cpf').AsString := Pcpf;

      LQuery.Open;
      if LQuery.IsEmpty then 
      raise Exception.Create(Format('CPF: %s não localizado.',[Pcpf]));
      
      Result := LQuery.FieldByName('id').AsInteger;
    end;
  finally
    LQuery.Close;
    FreeAndNil(LQuery);
  end;
end;

function TPessoaDao.buscarPessoaPorId(Pid: Integer): TPessoa;
begin

end;

function TPessoaDao.buscarTodasAsPessoas: TList<TPessoa>;
var
  Lquery : TFDQuery;
  I      : Integer;
  LPessoa : TPessoa;
  LPessoas : TList<TPessoa>;
begin
  Lquery := TFDQuery.Create(nil);
  try
    with Lquery do
    begin
      Connection := dmRavin.cnxBancoDeDados;

      SQL.Add('SELECT * FROM pessoa');
      Lquery.Open();
      if Lquery.IsEmpty then
        Result := nil
      else
      begin
        LPessoas := TList<TPessoa>.Create;
        Lquery.First;
        while not Lquery.Eof do
        begin

          LPessoa := TPessoa.Create;
          LPessoa.id := FieldByName('id').AsInteger;
          LPessoa.nome := FieldByName('nome').AsString;
          LPessoa.tipoPessoa := FieldByName('tipoPessoa').AsString;
          LPessoa.cpf := FieldByName('cpf').AsString;
          LPessoa.telefone := FieldByName('telefone').AsInteger;
          LPessoa.ativo := FieldByName('ativo').AsBoolean;
          LPessoa.criadoEm := FieldByName('criadoEm').AsDateTime;
          LPessoa.criadoPor := FieldByName('criadoPor').AsString;
          LPessoa.alteradoEm := FieldByName('alteradoEm').AsDateTime;
          LPessoa.alteradoPor := FieldByName('alteradoPor').AsString;

          LPessoas.Add(LPessoa);
          Lquery.Next;
        end;
        Result := LPessoas;
        LPessoa.Free;
      end;
      Lquery.Close;
    end;
  finally
    FreeAndNil(Lquery);
  end;
end;

function TPessoaDao.buscarTodosOsClientes: TList<TPessoa>;
var
  Lquery : TFDQuery;
  I      : Integer;
  LPessoa : TPessoa;
  LPessoas : TList<TPessoa>;
begin
  Lquery := TFDQuery.Create(nil);
  try
    with Lquery do
    begin
      Connection := dmRavin.cnxBancoDeDados;

      SQL.Add('SELECT * FROM pessoa where tipoPessoa = :tipoPessoa');
      ParamByName('tipoPessoa').AsString := 'C';
      Lquery.Open();
      if Lquery.IsEmpty then
        Result := nil
      else
      begin
        LPessoas := TList<TPessoa>.Create;
        Lquery.First;
        while not Lquery.Eof do
        begin

          LPessoa := TPessoa.Create;
          LPessoa.id := FieldByName('id').AsInteger;
          LPessoa.nome := FieldByName('nome').AsString;
          LPessoa.tipoPessoa := FieldByName('tipoPessoa').AsString;
          LPessoa.cpf := FieldByName('cpf').AsString;
          LPessoa.telefone := FieldByName('telefone').AsInteger;
          LPessoa.ativo := FieldByName('ativo').AsBoolean;
          LPessoa.criadoEm := FieldByName('criadoEm').AsDateTime;
          LPessoa.criadoPor := FieldByName('criadoPor').AsString;
          LPessoa.alteradoEm := FieldByName('alteradoEm').AsDateTime;
          LPessoa.alteradoPor := FieldByName('alteradoPor').AsString;

          LPessoas.Add(LPessoa);
          Lquery.Next;
        end;
        Result := LPessoas;
      end;
      Lquery.Close;
    end;
  finally
    FreeAndNil(Lquery);
  end;
end;

function TPessoaDao.checarExistencia(Pcpf: String): Boolean;
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    with LQuery do
    begin
      Connection := dmRavin.cnxBancoDeDados;

      SQL.Add('SELECT * FROM pessoa where cpf = :cpf');
      ParamByName('cpf').AsString := Pcpf;

      LQuery.Open;
      if LQuery.IsEmpty then
        Result := false
      else
        Result := true;
      LQuery.Close;
    end;
  finally
    FreeAndNil(LQuery)
  end;
end;

procedure TPessoaDao.inserirCliente(const PPessoa: TPessoa);
var
  LQuery : TFDQuery;
begin

  LQuery := TFDQuery.Create(nil);
  try
    with LQuery do
    begin
      Connection := dmRavin.cnxBancoDeDados;

      SQL.Add('INSERT INTO pessoa');
      SQL.Add(' (nome, tipoPessoa, cpf, ativo, criadoEm,');
      SQL.Add(' criadoPor, alteradoEm, alteradoPor)');
      SQL.Add(' VALUES (:nome, :tipoPessoa, :cpf, :ativo, :criadoEm,');
      SQL.Add(' :criadoPor, :alteradoEm, :alteradoPor)');

      ParamByName('nome').AsString := PPessoa.nome;
      ParamByName('tipoPessoa').AsString := 'C';
      ParamByName('cpf').AsString := PPessoa.cpf;
    //ParamByName('telefone').AsInteger := PPessoa.telefone;
      ParamByName('ativo').AsInteger := 1;
      ParamByName('criadoEm').AsDateTime := Now;
      ParamByName('criadoPor').AsString := 'admin';
      ParamByName('alteradoEm').AsDateTime := Now;
      ParamByName('alteradoPor').AsString := 'admin';

      LQuery.ExecSQL;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TPessoaDao.inserirFuncionario( const PPessoa : TPessoa);
var
  LQuery : TFDQuery;
begin

  LQuery := TFDQuery.Create(nil);
  try
    with LQuery do
    begin
      Connection := dmRavin.cnxBancoDeDados;

      SQL.Add('INSERT INTO pessoa');
      SQL.Add(' (nome, tipoPessoa, cpf, ativo, criadoEm,');
      SQL.Add(' criadoPor, alteradoEm, alteradoPor)');
      SQL.Add(' VALUES (:nome, :tipoPessoa, :cpf, :ativo, :criadoEm,');
      SQL.Add(' :criadoPor, :alteradoEm, :alteradoPor)');

      ParamByName('nome').AsString := PPessoa.nome;
      ParamByName('tipoPessoa').AsString := 'F';
      ParamByName('cpf').AsString := PPessoa.cpf;
    //ParamByName('telefone').AsInteger := PPessoa.telefone;
      ParamByName('ativo').AsInteger := 1;
      ParamByName('criadoEm').AsDateTime := Now;
      ParamByName('criadoPor').AsString := 'admin';
      ParamByName('alteradoEm').AsDateTime := Now;
      ParamByName('alteradoPor').AsString := 'admin';

      LQuery.ExecSQL;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

end.
