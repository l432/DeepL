object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SCAPS Conversion'
  ClientHeight = 551
  ClientWidth = 756
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
    Left = 200
    Top = 201
    Width = 239
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
    Left = 200
    Top = 248
    Width = 239
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
    Left = 8
    Top = 197
    Width = 153
    Height = 33
    Caption = '&Select  .iv file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtFileSelectClick
  end
  object BtDone: TButton
    Left = 8
    Top = 245
    Width = 153
    Height = 33
    Caption = '&Extract IV files'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
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
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtCloseClick
  end
  object GBTemp: TGroupBox
    Left = 8
    Top = 8
    Width = 97
    Height = 105
    Caption = 'Temperature'
    TabOrder = 3
    object LTemp_start: TLabel
      Left = 10
      Top = 24
      Width = 33
      Height = 16
      Caption = 'Start:'
    end
    object LTemp_Finish: TLabel
      Left = 10
      Top = 46
      Width = 38
      Height = 16
      Caption = 'Finish:'
    end
    object LTemp_Step: TLabel
      Left = 10
      Top = 68
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
      Left = 63
      Top = 46
      Width = 25
      Height = 20
      Caption = '350'
      TabOrder = 1
    end
    object STTemp_Step: TStaticText
      Left = 64
      Top = 68
      Width = 18
      Height = 20
      Caption = '10'
      TabOrder = 2
    end
  end
  object GBBoron: TGroupBox
    Left = 330
    Top = 8
    Width = 210
    Height = 105
    Caption = 'Base'
    TabOrder = 4
    object LBase_Conc: TLabel
      Left = 11
      Top = 10
      Width = 95
      Height = 48
      Caption = 'Boron concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LBase_Thick: TLabel
      Left = 11
      Top = 64
      Width = 62
      Height = 32
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STBoron: TStaticText
      Left = 130
      Top = 20
      Width = 48
      Height = 28
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object STBase_Thick: TStaticText
      Left = 130
      Top = 68
      Width = 48
      Height = 28
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object BMaterialFileCreate: TButton
    Left = 45
    Top = 128
    Width = 228
    Height = 36
    Caption = '.material file create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    WordWrap = True
    OnClick = BMaterialFileCreateClick
  end
  object BDatesDat: TButton
    Left = 8
    Top = 313
    Width = 129
    Height = 48
    Caption = 'dates.dat convert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = BDatesDatClick
  end
  object BFeB_x: TButton
    Left = 303
    Top = 403
    Width = 129
    Height = 48
    Caption = 'Fe(x) and FeB(x) create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
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
      Top = 47
      Width = 25
      Height = 20
      Caption = '300'
      TabOrder = 0
    end
    object STFe_Hi: TStaticText
      Left = 99
      Top = 47
      Width = 25
      Height = 20
      Caption = '350'
      TabOrder = 1
    end
    object STFe_steps: TStaticText
      Left = 179
      Top = 47
      Width = 18
      Height = 20
      Caption = '10'
      TabOrder = 2
    end
  end
  object BDatesDatCorrect: TButton
    Left = 163
    Top = 313
    Width = 129
    Height = 48
    Caption = 'correct dates.dat'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    WordWrap = True
    OnClick = BDatesDatCorrectClick
  end
  object GBFinal: TGroupBox
    Left = 504
    Top = 288
    Width = 231
    Height = 225
    Caption = 'Final'
    TabOrder = 10
    object BResult: TButton
      Left = 29
      Top = 53
      Width = 178
      Height = 71
      Caption = 'ResultAll.dat convert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = BResultClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 546
    Top = 8
    Width = 202
    Height = 105
    Caption = 'SBF layer'
    TabOrder = 11
    object LSBF_Conc: TLabel
      Left = 11
      Top = 12
      Width = 95
      Height = 48
      Caption = 'Boron concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LSBF_Thick: TLabel
      Left = 11
      Top = 64
      Width = 62
      Height = 32
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STSBF_Con: TStaticText
      Left = 130
      Top = 20
      Width = 48
      Height = 28
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object STSBF_Thick: TStaticText
      Left = 130
      Top = 68
      Width = 48
      Height = 28
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 114
    Top = 8
    Width = 210
    Height = 105
    Caption = 'Emiter'
    TabOrder = 12
    object LEmiter_Conc: TLabel
      Left = 11
      Top = 12
      Width = 95
      Height = 48
      Caption = 'Phosphorus concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LEmiter_Thick: TLabel
      Left = 11
      Top = 64
      Width = 62
      Height = 32
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STEmiter_Con: TStaticText
      Left = 130
      Top = 20
      Width = 48
      Height = 28
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object STEmiter_Thick: TStaticText
      Left = 130
      Top = 68
      Width = 48
      Height = 28
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object BScapsFileCreate: TButton
    Left = 312
    Top = 128
    Width = 228
    Height = 36
    Caption = '.scaps file create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    WordWrap = True
    OnClick = BScapsFileCreateClick
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Scaps files (*.iv)|*.iv'
    Left = 424
    Top = 504
  end
end
