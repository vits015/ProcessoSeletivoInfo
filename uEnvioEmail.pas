unit uEnvioEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  IniFiles,IdComponent,IdTCPConnection,IdTCPClient,IdHTTP,IdBaseComponent,IdMessage,
  IdExplicitTLSClientServerBase,IdMessageClient,IdSMTPBase,IdSMTP,IdIOHandler,
  IdIOHandlerSocket,IdIOHandlerStack,IdSSL,IdSSLOpenSSL,IdAttachmentFile,IdText,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg;

type
  TfrmEnvioEmail = class(TForm)
    lbPara: TLabel;
    edtPara: TEdit;
    edtAssunto: TEdit;
    lbAssunto: TLabel;
    lbMensagem: TLabel;
    memCorpo: TMemo;
    lbAnexo: TLabel;
    edtAnexo: TEdit;
    btnEnviar: TButton;
    pnGeral: TPanel;
    pnAguarde: TPanel;
    Image1: TImage;
    procedure btnEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function EnviarEmail(const AAssunto, ADestino, AAnexo: String; ACorpo: TStrings): Boolean;
  public
    { Public declarations }
  end;

var
  frmEnvioEmail: TfrmEnvioEmail;

implementation

{$R *.dfm}

{ TfrmEnvioEmail }

procedure TfrmEnvioEmail.btnEnviarClick(Sender: TObject);
begin
  pnAguarde.Visible:=true;
  pnGeral.Visible:=false;

  TThread.CreateAnonymousThread(procedure
  begin
    if edtPara.Text<>EmptyStr then
    begin
      if EnviarEmail(edtAssunto.Text, edtPara.Text, edtAnexo.Text, memCorpo.Lines) then
      begin
        pnAguarde.Visible:=false;
        pnGeral.Visible:=true;
        ShowMessage('Enviado com sucesso!');
      end else
      begin
        pnAguarde.Visible:=false;
        pnGeral.Visible:=true;
      end;
    end else
    begin
      pnAguarde.Visible:=false;
      pnGeral.Visible:=true;
      showmessage('Favor preencher o destinatário');
    end;
  end).Start;
end;

function TfrmEnvioEmail.EnviarEmail(const AAssunto, ADestino, AAnexo: String;
  ACorpo: TStrings): Boolean;
var
  IniFile              : TIniFile;
  sFrom                : String;
  sBccList             : String;
  sHost                : String;
  iPort                : Integer;
  sUserName            : String;
  sPassword            : String;

  idMsg                : TIdMessage;
  IdText               : TIdText;
  idSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
  cursor:TCursor;
begin
  try
    try
      //Criação e leitura do arquivo INI com as configurações
      IniFile                          := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
      sFrom                            := IniFile.ReadString('Email' , 'From'     , sFrom);
      sBccList                         := IniFile.ReadString('Email' , 'BccList'  , sBccList);
      sHost                            := IniFile.ReadString('Email' , 'Host'     , sHost);
      iPort                            := IniFile.ReadInteger('Email', 'Port'     , iPort);
      sUserName                        := IniFile.ReadString('Email' , 'UserName' , sUserName);
      sPassword                        := IniFile.ReadString('Email' , 'Password' , sPassword);

      //Configura os parâmetros necessários para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;

      //Variável referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := edtAssunto.Text;
      idMsg.From.Address               := sFrom;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;

      //Add Destinatário(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
      idMsg.CCList.EMailAddresses      := '';
      idMsg.BccList.EMailAddresses    := sBccList;
      idMsg.BccList.EMailAddresses    := ''; //Cópia Oculta

      //Variável do texto
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(ACorpo.Text);
      idText.ContentType := 'text/plain; charset=iso-8859-1';

      //Prepara o Servidor
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := sHost;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := iPort;
      IdSMTP.Username                  := sUserName;
      IdSMTP.Password                  := sPassword;

      //Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;

      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      //Se a conexão foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            Result := False;
            ShowMessage('Erro ao tentar enviar: ' + E.Message);
            abort;
          end;
        end;
      end;

      //Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally
      IniFile.Free;

      UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TfrmEnvioEmail.FormCreate(Sender: TObject);
begin
  ( Image1.Picture.Graphic as TGIFImage ).Animate := True;
  ( Image1.Picture.Graphic as TGIFImage ).AnimationSpeed:= 130;
end;

end.
