program InfoSistemas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uEnvioEmail in 'uEnvioEmail.pas' {frmEnvioEmail},
  uEndereco in 'uEndereco.pas',
  uPessoa in 'uPessoa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmEnvioEmail, frmEnvioEmail);
  Application.Run;
end.
