object frmEnvioEmail: TfrmEnvioEmail
  Left = 0
  Top = 0
  Caption = 'Enviar E-mail'
  ClientHeight = 448
  ClientWidth = 601
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbPara: TLabel
    Left = 55
    Top = 44
    Width = 26
    Height = 13
    Caption = 'Para:'
  end
  object lbAssunto: TLabel
    Left = 38
    Top = 84
    Width = 43
    Height = 13
    Caption = 'Assunto:'
  end
  object lbMensagem: TLabel
    Left = 26
    Top = 124
    Width = 55
    Height = 13
    Caption = 'Mensagem:'
  end
  object lbAnexo: TLabel
    Left = 38
    Top = 324
    Width = 35
    Height = 13
    Caption = 'Anexo:'
  end
  object edtPara: TEdit
    Left = 96
    Top = 41
    Width = 450
    Height = 21
    TabOrder = 0
  end
  object edtAssunto: TEdit
    Left = 96
    Top = 81
    Width = 450
    Height = 21
    TabOrder = 1
  end
  object memCorpo: TMemo
    Left = 96
    Top = 121
    Width = 450
    Height = 168
    TabOrder = 2
  end
  object edtAnexo: TEdit
    Left = 96
    Top = 321
    Width = 361
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object btnEnviar: TButton
    Left = 215
    Top = 368
    Width = 162
    Height = 49
    Cursor = crHandPoint
    Caption = 'Enviar'
    TabOrder = 4
    OnClick = btnEnviarClick
  end
end
