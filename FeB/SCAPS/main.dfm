object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'SCAPS Conversion'
  ClientHeight = 525
  ClientWidth = 567
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
    Left = 152
    Top = 211
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
    Left = 152
    Top = 246
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
    Left = 8
    Top = 208
    Width = 115
    Height = 25
    Caption = '&Select  .iv file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtFileSelectClick
  end
  object BtDone: TButton
    Left = 8
    Top = 244
    Width = 115
    Height = 25
    Caption = '&Extract IV files'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtDoneClick
  end
  object BtClose: TButton
    Left = 126
    Top = 498
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
    Left = 8
    Top = 66
    Width = 73
    Height = 79
    Caption = 'Temperature'
    TabOrder = 3
    object LTemp_start: TLabel
      Left = 8
      Top = 18
      Width = 25
      Height = 12
      Caption = 'Start:'
    end
    object LTemp_Finish: TLabel
      Left = 8
      Top = 35
      Width = 30
      Height = 12
      Caption = 'Finish:'
    end
    object LTemp_Step: TLabel
      Left = 8
      Top = 51
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
      Left = 47
      Top = 35
      Width = 19
      Height = 16
      Caption = '350'
      TabOrder = 1
    end
    object STTemp_Step: TStaticText
      Left = 48
      Top = 51
      Width = 14
      Height = 16
      Caption = '10'
      TabOrder = 2
    end
  end
  object GBBoron: TGroupBox
    Left = 250
    Top = 66
    Width = 157
    Height = 90
    Caption = 'Base'
    TabOrder = 4
    object LBase_Conc: TLabel
      Left = 8
      Top = 14
      Width = 79
      Height = 39
      Caption = 'Boron concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LBase_Thick: TLabel
      Left = 8
      Top = 58
      Width = 56
      Height = 26
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STBoron: TStaticText
      Left = 98
      Top = 20
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
    object STBase_Thick: TStaticText
      Left = 98
      Top = 61
      Width = 36
      Height = 22
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object BMaterialFileCreate: TButton
    Left = 36
    Top = 170
    Width = 171
    Height = 27
    Caption = '.material file create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    WordWrap = True
    OnClick = BMaterialFileCreateClick
  end
  object BDatesDat: TButton
    Left = 8
    Top = 295
    Width = 97
    Height = 36
    Caption = 'dates.dat convert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = BDatesDatClick
  end
  object BFeB_x: TButton
    Left = 229
    Top = 362
    Width = 97
    Height = 36
    Caption = 'Fe(x) and FeB(x) create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    WordWrap = True
    OnClick = BFeB_xClick
  end
  object GBFerum: TGroupBox
    Left = 8
    Top = 348
    Width = 197
    Height = 55
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
  object BDatesDatCorrect: TButton
    Left = 124
    Top = 295
    Width = 97
    Height = 36
    Caption = 'correct dates.dat'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    WordWrap = True
    OnClick = BDatesDatCorrectClick
  end
  object GBFinal: TGroupBox
    Left = 382
    Top = 348
    Width = 173
    Height = 111
    Caption = 'Final'
    TabOrder = 10
    object BResult: TButton
      Left = 22
      Top = 40
      Width = 133
      Height = 53
      Caption = 'ResultAll.dat convert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = BResultClick
    end
  end
  object GBBSF: TGroupBox
    Left = 412
    Top = 66
    Width = 151
    Height = 90
    Caption = 'SBF layer'
    TabOrder = 11
    object LSBF_Conc: TLabel
      Left = 8
      Top = 14
      Width = 79
      Height = 39
      Caption = 'Boron concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LSBF_Thick: TLabel
      Left = 8
      Top = 58
      Width = 56
      Height = 26
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STSBF_Con: TStaticText
      Left = 98
      Top = 20
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
    object STSBF_Thick: TStaticText
      Left = 98
      Top = 61
      Width = 36
      Height = 22
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object GBEmiter: TGroupBox
    Left = 88
    Top = 66
    Width = 157
    Height = 90
    Caption = 'Emiter'
    TabOrder = 12
    object LEmiter_Conc: TLabel
      Left = 8
      Top = 14
      Width = 79
      Height = 39
      Caption = 'Phosphorus concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LEmiter_Thick: TLabel
      Left = 8
      Top = 58
      Width = 56
      Height = 26
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STEmiter_Con: TStaticText
      Left = 98
      Top = 30
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
    object STEmiter_Thick: TStaticText
      Left = 98
      Top = 61
      Width = 36
      Height = 22
      Caption = '1e16'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object BScapsFileCreate: TButton
    Left = 236
    Top = 170
    Width = 171
    Height = 27
    Caption = '.scaps file create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    WordWrap = True
    OnClick = BScapsFileCreateClick
  end
  object GBFolderSelect: TGroupBox
    Left = 12
    Top = 2
    Width = 543
    Height = 58
    Caption = 'Folder Select'
    TabOrder = 14
    object L_SCAPSF: TLabel
      Left = 242
      Top = 14
      Width = 289
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'D:\Oleg\Disser\Dokument\etap6\CD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object L_ResF: TLabel
      Left = 242
      Top = 35
      Width = 289
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'D:\Oleg\Disser\Dokument\etap6\CD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ST_SCAPSF: TStaticText
      Left = 16
      Top = 16
      Width = 77
      Height = 18
      Caption = 'SCAPS Folder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object B_SCAPSFSelect: TButton
      Left = 106
      Top = 12
      Width = 117
      Height = 19
      Caption = 'Select'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ST_ResF: TStaticText
      Left = 16
      Top = 37
      Width = 79
      Height = 18
      Caption = 'Results Folder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object B_ResFSelect: TButton
      Left = 106
      Top = 33
      Width = 117
      Height = 19
      Caption = 'Select'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Scaps files (*.iv)|*.iv'
    Left = 426
    Top = 564
  end
end
