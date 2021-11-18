object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 502
  ClientWidth = 695
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 695
    Height = 423
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 410
    object lbNome: TLabel
      Left = 88
      Top = 77
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object lbIdentidade: TLabel
      Left = 63
      Top = 122
      Width = 56
      Height = 13
      Caption = 'Identidade:'
    end
    object lblCPF: TLabel
      Left = 328
      Top = 122
      Width = 23
      Height = 13
      Caption = 'CPF:'
    end
    object lbTelefone: TLabel
      Left = 76
      Top = 160
      Width = 46
      Height = 13
      Caption = 'Telefone:'
    end
    object lbEmail: TLabel
      Left = 319
      Top = 160
      Width = 32
      Height = 13
      Caption = 'E-mail:'
    end
    object edtNome: TEdit
      Left = 144
      Top = 74
      Width = 417
      Height = 21
      TabOrder = 0
    end
    object gbEndereco: TGroupBox
      Left = 48
      Top = 208
      Width = 593
      Height = 201
      Caption = 'Endere'#231'o'
      TabOrder = 5
      object lbCEP: TLabel
        Left = 51
        Top = 42
        Width = 23
        Height = 13
        Caption = 'CEP:'
      end
      object lbLogradouro: TLabel
        Left = 28
        Top = 80
        Width = 59
        Height = 13
        Caption = 'Logradouro:'
      end
      object lbBairro: TLabel
        Left = 271
        Top = 40
        Width = 32
        Height = 13
        Caption = 'Bairro:'
      end
      object lbComplemento: TLabel
        Left = 18
        Top = 120
        Width = 69
        Height = 13
        Caption = 'Complemento:'
      end
      object lbNumero: TLabel
        Left = 429
        Top = 120
        Width = 41
        Height = 13
        Caption = 'N'#250'mero:'
      end
      object lbCidade: TLabel
        Left = 50
        Top = 159
        Width = 37
        Height = 13
        Caption = 'Cidade:'
      end
      object lbEstado: TLabel
        Left = 258
        Top = 159
        Width = 37
        Height = 13
        Caption = 'Estado:'
      end
      object lbPais: TLabel
        Left = 435
        Top = 159
        Width = 23
        Height = 13
        Caption = 'Pa'#237's:'
      end
      object edtCEP: TMaskEdit
        Left = 96
        Top = 34
        Width = 118
        Height = 21
        EditMask = '#####-###'
        MaxLength = 9
        TabOrder = 0
        Text = '     -   '
        OnExit = edtCEPExit
      end
      object edtLogradouro: TEdit
        Left = 96
        Top = 74
        Width = 456
        Height = 21
        TabOrder = 2
      end
      object edtBairro: TEdit
        Left = 328
        Top = 34
        Width = 224
        Height = 21
        TabOrder = 1
      end
      object edtComplemento: TEdit
        Left = 96
        Top = 114
        Width = 288
        Height = 21
        TabOrder = 3
      end
      object edtCidade: TEdit
        Left = 96
        Top = 154
        Width = 142
        Height = 21
        TabOrder = 4
      end
      object edtEstado: TEdit
        Left = 304
        Top = 154
        Width = 80
        Height = 21
        TabOrder = 5
      end
      object edtPais: TEdit
        Left = 464
        Top = 154
        Width = 89
        Height = 21
        TabOrder = 6
      end
      object edtNumero: TEdit
        Left = 489
        Top = 114
        Width = 64
        Height = 21
        TabOrder = 7
      end
    end
    object edtIdentidade: TMaskEdit
      Left = 144
      Top = 114
      Width = 120
      Height = 21
      EditMask = '##.###.###-##'
      MaxLength = 13
      TabOrder = 1
      Text = '  .   .   -  '
    end
    object edtCPF: TMaskEdit
      Left = 376
      Top = 114
      Width = 118
      Height = 21
      EditMask = '###.###.###-##'
      MaxLength = 14
      TabOrder = 2
      Text = '   .   .   -  '
    end
    object edtTelefone: TMaskEdit
      Left = 144
      Top = 154
      Width = 118
      Height = 21
      EditMask = '(##)#####-####'
      MaxLength = 14
      TabOrder = 3
      Text = '(  )     -    '
    end
    object edtEmail: TEdit
      Left = 376
      Top = 154
      Width = 185
      Height = 21
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 423
    Width = 695
    Height = 79
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 410
    object btnEnviar: TButton
      Left = 232
      Top = 16
      Width = 185
      Height = 49
      Caption = 'Enviar E-mail'
      TabOrder = 0
      OnClick = btnEnviarClick
    end
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://viacep.com.br/ws/01001000/json'
    Params = <>
    Left = 584
    Top = 24
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Left = 592
    Top = 72
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 592
    Top = 136
  end
  object XMLDocument1: TXMLDocument
    Left = 496
    Top = 16
  end
end
