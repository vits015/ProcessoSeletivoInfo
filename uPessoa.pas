unit uPessoa;

interface

uses uEndereco;

Type
  TPessoa = class
  private
    Femail: string;
    Fcpf: String;
    Fidentidade: String;
    Fnome: String;
    FEndereco: TEndereco;
    Ftelefone: string;
    procedure Setcpf(const Value: String);
    procedure Setemail(const Value: string);
    procedure SetEndereco(const Value: TEndereco);
    procedure Setidentidade(const Value: String);
    procedure Setnome(const Value: String);
    procedure Settelefone(const Value: string);

  public
    property nome: String read Fnome write Setnome;
    property identidade: String read Fidentidade write Setidentidade;
    property cpf: String read Fcpf write Setcpf;
    property telefone: string read Ftelefone write Settelefone;
    property email: string read Femail write Setemail;
    property Endereco: TEndereco read FEndereco write SetEndereco;
  end;

implementation

{ TPessoa }

procedure TPessoa.Setcpf(const Value: String);
begin
  Fcpf := Value;
end;

procedure TPessoa.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TPessoa.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TPessoa.Setidentidade(const Value: String);
begin
  Fidentidade := Value;
end;

procedure TPessoa.Setnome(const Value: String);
begin
  Fnome := Value;
end;

procedure TPessoa.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

end.
