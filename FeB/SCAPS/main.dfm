object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SCAPS Conversion'
  ClientHeight = 413
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object LFile: TLabel
    Left = 168
    Top = 27
    Width = 179
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Caption = 'No Selection'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LAction: TLabel
    Left = 168
    Top = 62
    Width = 179
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Caption = 'Not Yet'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BtFileSelect: TButton
    Left = 24
    Top = 24
    Width = 115
    Height = 25
    Caption = '&Select  .iv file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtFileSelectClick
  end
  object BtDone: TButton
    Left = 24
    Top = 60
    Width = 115
    Height = 25
    Caption = '&Extract IV files'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtDoneClick
  end
  object BtClose: TButton
    Left = 126
    Top = 378
    Width = 79
    Height = 19
    Caption = '&Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtCloseClick
  end
  object GBTemp: TGroupBox
    Left = 12
    Top = 108
    Width = 235
    Height = 49
    Caption = 'Temperature'
    TabOrder = 3
    object LTemp_start: TLabel
      Left = 12
      Top = 18
      Width = 25
      Height = 12
      Caption = 'Start:'
    end
    object LTemp_Finish: TLabel
      Left = 92
      Top = 18
      Width = 30
      Height = 12
      Caption = 'Finish:'
    end
    object LTemp_Step: TLabel
      Left = 168
      Top = 18
      Width = 24
      Height = 12
      Caption = 'Step:'
    end
    object STTemp_start: TStaticText
      Left = 48
      Top = 18
      Width = 19
      Height = 16
      Caption = '300'
      TabOrder = 0
    end
    object STTemp_Finish: TStaticText
      Left = 128
      Top = 18
      Width = 19
      Height = 16
      Caption = '350'
      TabOrder = 1
    end
    object STTemp_Step: TStaticText
      Left = 204
      Top = 18
      Width = 14
      Height = 16
      Caption = '10'
      TabOrder = 2
    end
  end
  object GBBoron: TGroupBox
    Left = 12
    Top = 167
    Width = 133
    Height = 49
    Caption = 'Boron concentration, cm-3'
    TabOrder = 4
    object STBoron: TStaticText
      Left = 24
      Top = 18
      Width = 36
      Height = 22
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object BMaterialFileCreate: TButton
    Left = 246
    Top = 175
    Width = 101
    Height = 41
    Caption = '.material file create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    WordWrap = True
    OnClick = BMaterialFileCreateClick
  end
  object BDatesDat: TButton
    Left = 6
    Top = 235
    Width = 97
    Height = 36
    Caption = 'dates.dat convert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = BDatesDatClick
  end
  object BFeB_x: TButton
    Left = 257
    Top = 294
    Width = 97
    Height = 36
    Caption = 'Fe(x) and FeB(x) create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    WordWrap = True
    OnClick = BFeB_xClick
  end
  object GBFerum: TGroupBox
    Left = 6
    Top = 288
    Width = 197
    Height = 49
    Caption = 'Iron concentration, cm-3'
    TabOrder = 8
    object LFe_Lo: TLabel
      Left = 12
      Top = 18
      Width = 25
      Height = 12
      Caption = 'Start:'
    end
    object LFe_Hi: TLabel
      Left = 74
      Top = 18
      Width = 30
      Height = 12
      Caption = 'Finish:'
    end
    object LFe_steps: TLabel
      Left = 134
      Top = 18
      Width = 24
      Height = 12
      Caption = 'Step:'
    end
    object STFe_Lo: TStaticText
      Left = 12
      Top = 35
      Width = 19
      Height = 16
      Caption = '300'
      TabOrder = 0
    end
    object STFe_Hi: TStaticText
      Left = 74
      Top = 35
      Width = 19
      Height = 16
      Caption = '350'
      TabOrder = 1
    end
    object STFe_steps: TStaticText
      Left = 134
      Top = 35
      Width = 14
      Height = 16
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
