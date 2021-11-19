unit uEndereco;

interface

Type
  TEndereco = class
  private
    Fcep: String;
    Flogradouro: string;
    Fbairro: String;
    Fnumero: String;
    Fcomplemento: String;
    Fcidade: String;
    FPais: String;
    FEstado: String;
    procedure Setcep(const Value: String);
    procedure Setbairro(const Value: String);
    procedure Setcidade(const Value: String);
    procedure Setcomplemento(const Value: String);
    procedure SetEstado(const Value: String);
    procedure Setlogradouro(const Value: string);
    procedure Setnumero(const Value: string);
    procedure SetPais(const Value: String);

  public
    property cep: String read Fcep write Setcep;
    property bairro:String read Fbairro write Setbairro;
    property logradouro:string read Flogradouro write Setlogradouro;
    property cidade:String read Fcidade write Setcidade;
    property Estado:String read FEstado write SetEstado;
    property Pais:String read FPais write SetPais;
    property numero:string read Fnumero write Setnumero;
    property complemento:String read Fcomplemento write Setcomplemento;

    end;

implementation

{ TEndereco }

procedure TEndereco.Setbairro(const Value: String);
begin
  Fbairro := Value;
end;

procedure TEndereco.Setcep(const Value: String);
begin
  Fcep := Value;
end;

procedure TEndereco.Setcidade(const Value: String);
begin
  Fcidade := Value;
end;

procedure TEndereco.Setcomplemento(const Value: String);
begin
  Fcomplemento := Value;
end;

procedure TEndereco.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TEndereco.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TEndereco.Setnumero(const Value: String);
begin
  Fnumero := Value;
end;

procedure TEndereco.SetPais(const Value: String);
begin
  FPais := Value;
end;

end.
