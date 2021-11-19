unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  Datasnap.DBClient, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, uEnvioEmail,
  Vcl.Imaging.pngimage, uEndereco, uPessoa;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    lbNome: TLabel;
    lbIdentidade: TLabel;
    lblCPF: TLabel;
    lbTelefone: TLabel;
    lbEmail: TLabel;
    edtNome: TEdit;
    gbEndereco: TGroupBox;
    lbCEP: TLabel;
    lbLogradouro: TLabel;
    lbBairro: TLabel;
    lbComplemento: TLabel;
    lbNumero: TLabel;
    lbCidade: TLabel;
    lbEstado: TLabel;
    lbPais: TLabel;
    edtCEP: TMaskEdit;
    edtLogradouro: TEdit;
    edtBairro: TEdit;
    edtComplemento: TEdit;
    edtCidade: TEdit;
    edtEstado: TEdit;
    edtPais: TEdit;
    edtIdentidade: TMaskEdit;
    edtCPF: TMaskEdit;
    edtTelefone: TMaskEdit;
    edtEmail: TEdit;
    Panel2: TPanel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btnEnviar: TButton;
    XMLDocument1: TXMLDocument;
    edtNumero: TEdit;
    Image1: TImage;
    procedure edtCEPExit(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    { Private declarations }
    Function preencheEndereco(endereco:TEndereco):TEndereco;
    Function preenchePessoa(pessoa:TPessoa):TPessoa;
    procedure criaXML(pessoa:TPessoa);
    function montaCorpoEmail(pessoa:TPessoa; memo:TMemo):TStrings;
    procedure LimpaEndereco;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnEnviarClick(Sender: TObject);
var
  pessoa:TPessoa;
begin
  pessoa:=preenchePessoa(pessoa);
  criaXML(pessoa);
  montaCorpoEmail(pessoa, frmEnvioEmail.memCorpo);
  frmEnvioEmail.edtAnexo.text:='C:\Cadastro.xml';
  frmEnvioEmail.ShowModal;
end;

procedure TfrmPrincipal.criaXML(pessoa: TPessoa);
var
  XMLDocument:TXMLDOCUMENT;
  NodeRegistro, NodeEndereco,NodePessoa: IXMLNode;
  erro:boolean;
  msgErro:String;
begin
XMLDocument:= TXMLDocument.Create(Self);
  try
      try
        XMLDocument.Active := True;
        NodeRegistro := XMLDocument.AddChild('Cadastro');
        NodePessoa := NodeRegistro.AddChild('Pessoa');
        NodePessoa.ChildValues['Nome'] := pessoa.nome;
        NodePessoa.ChildValues['Identidade'] := pessoa.identidade;
        NodePessoa.ChildValues['CPF'] := pessoa.cpf;
        NodePessoa.ChildValues['Telefone'] := pessoa.telefone;
        NodePessoa.ChildValues['Email'] := pessoa.email;
        NodeEndereco := NodePessoa.AddChild('Endereco');
        NodeEndereco.ChildValues['CEP'] := pessoa.Endereco.cep;
        NodeEndereco.ChildValues['Bairro'] := pessoa.Endereco.bairro;
        NodeEndereco.ChildValues['Logradouro'] := pessoa.Endereco.logradouro;
        NodeEndereco.ChildValues['Complemento'] := pessoa.Endereco.complemento;
        NodeEndereco.ChildValues['Numero'] := pessoa.Endereco.numero;
        NodeEndereco.ChildValues['Cidade'] := pessoa.Endereco.cidade;
        NodeEndereco.ChildValues['Estado'] := pessoa.Endereco.Estado;
        NodeEndereco.ChildValues['Pais'] := pessoa.Endereco.Pais;
        XMLDocument.SaveToFile('C:\Cadastro.xml');
        except on e:Exception do
        begin
          erro:=true;
          msgErro:=e.Message;
        end;
      end;
    finally
    begin
      if erro then
        showmessage('Houve um erro: ' + msgErro);
      XMLDocument.Free;
    end;
  end;
end;

procedure TfrmPrincipal.edtCEPExit(Sender: TObject);
begin
  RESTClient1.BaseURL:='http://viacep.com.br/ws/'+ StringReplace(edtCEP.Text,'-','',[rfReplaceAll, rfIgnoreCase]) +'/json';
  try
    RESTRequest1.Execute;

    edtBairro.Text:= StringReplace(RESTResponse1.JSONValue.FindValue('bairro').ToString, '"','',[rfReplaceAll, rfIgnoreCase]);
    edtCidade.Text:= StringReplace(RESTResponse1.JSONValue.FindValue('localidade').ToString, '"','',[rfReplaceAll, rfIgnoreCase]);
    edtLogradouro.Text:= StringReplace(RESTResponse1.JSONValue.FindValue('logradouro').ToString, '"','',[rfReplaceAll, rfIgnoreCase]);
    edtComplemento.Text:= StringReplace(RESTResponse1.JSONValue.FindValue('complemento').ToString, '"','',[rfReplaceAll, rfIgnoreCase]);
    edtEstado.Text:= StringReplace(RESTResponse1.JSONValue.FindValue('uf').ToString, '"','',[rfReplaceAll, rfIgnoreCase]);

    except on E:Exception do
    begin
      showmessage('CEP inv�lido');
      LimpaEndereco;
    end;

  end;


end;

procedure TfrmPrincipal.LimpaEndereco;
begin
  edtBairro.Text:='';
  edtCidade.Text:='';
  edtLogradouro.Text:='';
  edtComplemento.text:='';
  edtEstado.Text:='';
  edtPais.Text:='';
end;

function TfrmPrincipal.montaCorpoEmail(pessoa: TPessoa; memo: TMemo): TStrings;
begin
  memo.Lines.Add('Dados do Cadastro:');
  memo.Lines.Add('');
  memo.Lines.Add('- Nome: '        +pessoa.nome);
  memo.Lines.Add('- Identidade: '  +pessoa.identidade);
  memo.Lines.Add('- CPF: '         +pessoa.cpf);
  memo.Lines.Add('- Telefone: '    +pessoa.telefone);
  memo.Lines.Add('- Email: '       +pessoa.email);
  memo.Lines.Add('- Endere�o: ');
  memo.Lines.Add('      - Cep: '          +pessoa.Endereco.cep);
  memo.Lines.Add('      - Logradouro: '   +pessoa.Endereco.logradouro);
  memo.Lines.Add('      - Numero: '       +pessoa.Endereco.numero);
  memo.Lines.Add('      - Complemento: '  +pessoa.Endereco.complemento);
  memo.Lines.Add('      - Bairro: '       +pessoa.Endereco.bairro);
  memo.Lines.Add('      - Cidade: '       +pessoa.Endereco.cidade);
  memo.Lines.Add('      - Estado: '       +pessoa.Endereco.Estado);
  memo.Lines.Add('      - Pais: '         +pessoa.Endereco.Pais);
end;

function TfrmPrincipal.preencheEndereco(endereco: TEndereco): TEndereco;
begin
  endereco := TEndereco.Create;
  try
    endereco.cep:=edtcep.Text;
    endereco.bairro:=edtBairro.Text;
    endereco.logradouro:=edtLogradouro.Text;
    endereco.cidade:=edtCidade.Text;
    endereco.Estado:=edtEstado.Text;
    endereco.complemento:=edtComplemento.Text;
    endereco.numero:=  edtNumero.Text;
    endereco.Pais:=edtPais.Text;
  finally
    result:=endereco;
  end;
end;

function TfrmPrincipal.preenchePessoa(pessoa: TPessoa): TPessoa;
var
  endereco:TEndereco;
begin
  pessoa := TPessoa.Create;
  try
    pessoa.nome:=edtNome.Text;
    pessoa.identidade:=edtIdentidade.Text;
    pessoa.cpf:=edtCPF.Text;
    pessoa.telefone:=edtTelefone.Text;
    pessoa.email:=edtEmail.Text;
    pessoa.Endereco:=preencheEndereco(endereco);
  finally
    result:=pessoa;
  end;

end;

end.
