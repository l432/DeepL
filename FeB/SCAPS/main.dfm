object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SCAPS Conversion'
  ClientHeight = 550
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object LFile: TLabel
    Left = 224
    Top = 36
    Width = 238
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'No Selection'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LAction: TLabel
    Left = 224
    Top = 82
    Width = 238
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'Not Yet'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BtFileSelect: TButton
    Left = 32
    Top = 32
    Width = 153
    Height = 33
    Caption = '&Select  .iv file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtFileSelectClick
  end
  object BtDone: TButton
    Left = 32
    Top = 80
    Width = 153
    Height = 33
    Caption = '&Extract IV files'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtDoneClick
  end
  object BtClose: TButton
    Left = 168
    Top = 504
    Width = 105
    Height = 25
    Caption = '&Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtCloseClick
  end
  object GBTemp: TGroupBox
    Left = 16
    Top = 144
    Width = 313
    Height = 65
    Caption = 'Temperature'
    TabOrder = 3
    object LTemp_start: TLabel
      Left = 16
      Top = 24
      Width = 33
      Height = 16
      Caption = 'Start:'
    end
    object LTemp_Finish: TLabel
      Left = 123
      Top = 24
      Width = 38
      Height = 16
      Caption = 'Finish:'
    end
    object LTemp_Step: TLabel
      Left = 224
      Top = 24
      Width = 31
      Height = 16
      Caption = 'Step:'
    end
    object STTemp_start: TStaticText
      Left = 64
      Top = 24
      Width = 25
      Height = 20
      Caption = '300'
      TabOrder = 0
    end
    object STTemp_Finish: TStaticText
      Left = 171
      Top = 24
      Width = 25
      Height = 20
      Caption = '350'
      TabOrder = 1
    end
    object STTemp_Step: TStaticText
      Left = 272
      Top = 24
      Width = 18
      Height = 20
      Caption = '10'
      TabOrder = 2
    end
  end
  object GBBoron: TGroupBox
    Left = 16
    Top = 223
    Width = 177
    Height = 65
    Caption = 'Boron concentration, cm-3'
    TabOrder = 4
    object STBoron: TStaticText
      Left = 32
      Top = 24
      Width = 43
      Height = 26
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object BMaterialFileCreate: TButton
    Left = 328
    Top = 233
    Width = 134
    Height = 55
    Caption = '.material file create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    WordWrap = True
    OnClick = BMaterialFileCreateClick
  end
  object BDatesDat: TButton
    Left = 16
    Top = 313
    Width = 129
    Height = 48
    Caption = 'dates.dat convert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = BDatesDatClick
  end
  object BFeB_x: TButton
    Left = 343
    Top = 392
    Width = 129
    Height = 48
    Caption = 'Fe(x) and FeB(x) create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    WordWrap = True
    OnClick = BFeB_xClick
  end
  object GBFerum: TGroupBox
    Left = 8
    Top = 384
    Width = 263
    Height = 65
    Caption = 'Iron concentration, cm-3'
    TabOrder = 8
    object LFe_Lo: TLabel
      Left = 16
      Top = 24
      Width = 33
      Height = 16
      Caption = 'Start:'
    end
    object LFe_Hi: TLabel
      Left = 99
      Top = 24
      Width = 38
      Height = 16
      Caption = 'Finish:'
    end
    object LFe_steps: TLabel
      Left = 179
      Top = 24
      Width = 31
      Height = 16
      Caption = 'Step:'
    end
    object STFe_Lo: TStaticText
      Left = 16
      Top = 46
      Width = 25
      Height = 20
      Caption = '300'
      TabOrder = 0
    end
    object STFe_Hi: TStaticText
      Left = 99
      Top = 46
      Width = 25
      Height = 20
      Caption = '350'
      TabOrder = 1
    end
    object STFe_steps: TStaticText
      Left = 179
      Top = 46
      Width = 18
      Height = 20
      Caption = '10'
      TabOrder = 2
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Scaps files (*.iv)|*.iv'
    Left = 424
    Top = 504
  end
end
