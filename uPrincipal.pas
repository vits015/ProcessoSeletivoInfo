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
  Vcl.Imaging.pngimage;

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
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnEnviarClick(Sender: TObject);
var
  XMLDocument:TXMLDOCUMENT;
  NodeRegistro, NodeEndereco: IXMLNode;
  erro:boolean;
  msgErro, StringXML:String;
begin
  XMLDocument:= TXMLDocument.Create(Self);
  try
      try
        XMLDocument.Active := True;
        NodeRegistro := XMLDocument.AddChild('Cadastro');
        NodeRegistro.ChildValues['Nome'] := edtNome.Text;
        NodeRegistro.ChildValues['Identidade'] := edtIdentidade.Text;
        NodeRegistro.ChildValues['CPF'] := edtCPF.Text;
        NodeRegistro.ChildValues['Telefone'] := edtTelefone.Text;
        NodeRegistro.ChildValues['Email'] := edtEmail.Text;
        NodeEndereco := NodeRegistro.AddChild('Endereco');
        NodeEndereco.ChildValues['CEP'] := edtCEP.text;
        NodeEndereco.ChildValues['Bairro'] := edtBairro.text;
        NodeEndereco.ChildValues['Logradouro'] := edtLogradouro.text;
        NodeEndereco.ChildValues['Complemento'] := edtComplemento.text;
        NodeEndereco.ChildValues['Numero'] := edtNumero.text;
        NodeEndereco.ChildValues['Cidade'] := edtCidade.text;
        NodeEndereco.ChildValues['Estado'] := edtEstado.text;
        NodeEndereco.ChildValues['Pais'] := edtPais.text;
        XMLDocument.SaveToFile('C:\Cadastro.xml');
        StringXML := XMLDocument.XML.Text;
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

  frmEnvioEmail.memCorpo.lines.add(StringXML);
  frmEnvioEmail.edtAnexo.text:='C:\Cadastro.xml';
  frmEnvioEmail.ShowModal;
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
      showmessage('CEP inválido');
      edtBairro.Text:='';
      edtCidade.Text:='';
      edtLogradouro.Text:='';
      edtComplemento.text:='';
      edtEstado.Text:='';
    end;

  end;


end;

end.
