object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'SCAPS Conversion Time'
  ClientHeight = 690
  ClientWidth = 843
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
    Left = 292
    Top = 369
    Width = 238
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'No Selection'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LLightIntens: TLabel
    Left = 679
    Top = 325
    Width = 112
    Height = 36
    Caption = 'Light intensity (W m-2)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object BtFileSelect: TButton
    Left = 8
    Top = 365
    Width = 241
    Height = 34
    Caption = 'Process .iv file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtFileSelectClick
  end
  object BtClose: TButton
    Left = 169
    Top = 648
    Width = 105
    Height = 25
    Caption = '&Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtCloseClick
  end
  object GBTemp: TGroupBox
    Left = 271
    Top = 214
    Width = 403
    Height = 71
    Caption = 'Parameters'
    TabOrder = 2
    object LTemp_start: TLabel
      Left = 11
      Top = 24
      Width = 80
      Height = 16
      Caption = 'Temperature:'
    end
    object LActEnerg: TLabel
      Left = 157
      Top = 22
      Width = 59
      Height = 32
      Caption = 'Activation energy'
      WordWrap = True
    end
    object LDisPart: TLabel
      Left = 281
      Top = 20
      Width = 71
      Height = 32
      Caption = 'Dissociation Part'
      WordWrap = True
    end
    object STTemp_start: TStaticText
      Left = 102
      Top = 24
      Width = 25
      Height = 20
      Caption = '300'
      TabOrder = 0
    end
    object STActEnergy: TStaticText
      Left = 233
      Top = 31
      Width = 25
      Height = 20
      Caption = '350'
      TabOrder = 1
    end
    object STDisPart: TStaticText
      Left = 360
      Top = 28
      Width = 18
      Height = 20
      Caption = '10'
      TabOrder = 2
    end
  end
  object GBBoron: TGroupBox
    Left = 333
    Top = 88
    Width = 250
    Height = 120
    Caption = 'Base'
    TabOrder = 3
    object LBase_Conc: TLabel
      Left = 11
      Top = 19
      Width = 103
      Height = 54
      Caption = 'Boron concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LBase_Thick: TLabel
      Left = 11
      Top = 77
      Width = 74
      Height = 36
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STBoron: TStaticText
      Left = 131
      Top = 27
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
      Left = 131
      Top = 81
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
  object BDatesDat: TButton
    Left = 8
    Top = 489
    Width = 129
    Height = 48
    Caption = 'IV.txt convert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    WordWrap = True
    OnClick = BDatesDatClick
  end
  object BFeB_x: TButton
    Left = 373
    Top = 303
    Width = 130
    Height = 48
    Caption = 'Fe(x) and FeB(x) create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    WordWrap = True
    OnClick = BFeB_xClick
  end
  object GBFerum: TGroupBox
    Left = 8
    Top = 212
    Width = 240
    Height = 73
    Caption = 'Iron concentration, cm-3'
    TabOrder = 6
    object LFe_Lo: TLabel
      Left = 16
      Top = 24
      Width = 33
      Height = 16
      Caption = 'Start:'
    end
    object LFe_Hi: TLabel
      Left = 78
      Top = 24
      Width = 38
      Height = 16
      Caption = 'Finish:'
    end
    object LFe_steps: TLabel
      Left = 149
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
      Left = 78
      Top = 47
      Width = 25
      Height = 20
      Caption = '350'
      TabOrder = 1
    end
    object STFe_steps: TStaticText
      Left = 155
      Top = 47
      Width = 18
      Height = 20
      Caption = '10'
      TabOrder = 2
    end
  end
  object GBFinal: TGroupBox
    Left = 600
    Top = 511
    Width = 231
    Height = 148
    Caption = 'Final'
    TabOrder = 7
    object BResult: TButton
      Left = 29
      Top = 53
      Width = 178
      Height = 71
      Caption = 'ResultAll.dat convert'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = BResultClick
    end
  end
  object GBBSF: TGroupBox
    Left = 589
    Top = 88
    Width = 202
    Height = 120
    Caption = 'SBF layer'
    TabOrder = 8
    object LSBF_Conc: TLabel
      Left = 11
      Top = 19
      Width = 103
      Height = 54
      Caption = 'Boron concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LSBF_Thick: TLabel
      Left = 11
      Top = 77
      Width = 74
      Height = 36
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STSBF_Con: TStaticText
      Left = 131
      Top = 27
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
      Left = 131
      Top = 81
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
  object GBEmiter: TGroupBox
    Left = 117
    Top = 86
    Width = 210
    Height = 120
    Caption = 'Emiter'
    TabOrder = 9
    object LEmiter_Conc: TLabel
      Left = 11
      Top = 19
      Width = 103
      Height = 54
      Caption = 'Phosphorus concentration (cm-3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object LEmiter_Thick: TLabel
      Left = 11
      Top = 77
      Width = 74
      Height = 36
      Caption = 'Thickness (mkm)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object STEmiter_Con: TStaticText
      Left = 131
      Top = 40
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
      Left = 131
      Top = 81
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
    Left = 8
    Top = 307
    Width = 228
    Height = 36
    Caption = '.scaps file create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    WordWrap = True
    OnClick = BScapsFileCreateClick
  end
  object GBFolderSelect: TGroupBox
    Left = 16
    Top = 3
    Width = 724
    Height = 77
    Caption = 'Folder Select'
    TabOrder = 11
    object L_SCAPSF: TLabel
      Left = 323
      Top = 19
      Width = 385
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'D:\Oleg\Disser\Dokument\etap6\CD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object L_ResF: TLabel
      Left = 323
      Top = 47
      Width = 385
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'D:\Oleg\Disser\Dokument\etap6\CD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ST_SCAPSF: TStaticText
      Left = 21
      Top = 21
      Width = 101
      Height = 24
      Caption = 'SCAPS Folder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object B_SCAPSFSelect: TButton
      Left = 141
      Top = 16
      Width = 156
      Height = 25
      Caption = 'Select'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = B_SCAPSFSelectClick
    end
    object ST_ResF: TStaticText
      Left = 21
      Top = 49
      Width = 103
      Height = 24
      Caption = 'Results Folder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object B_ResFSelect: TButton
      Left = 141
      Top = 44
      Width = 156
      Height = 25
      Caption = 'Select'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = B_ResFSelectClick
    end
  end
  object BAllDatesDat: TButton
    Left = 8
    Top = 564
    Width = 156
    Height = 48
    Caption = 'all IV.txt convert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    WordWrap = True
    OnClick = BAllDatesDatClick
  end
  object RGIllumination: TRadioGroup
    Left = 706
    Top = 214
    Width = 129
    Height = 105
    Caption = 'Illumination'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'dark'
      'AM1.5'
      '940nm')
    ParentFont = False
    TabOrder = 13
    OnClick = RGIlluminationClick
  end
  object GBTime: TGroupBox
    Left = 14
    Top = 86
    Width = 97
    Height = 105
    Caption = 'Time'
    TabOrder = 14
    object LTime_start: TLabel
      Left = 11
      Top = 24
      Width = 33
      Height = 16
      Caption = 'Start:'
    end
    object LTime_Finish: TLabel
      Left = 11
      Top = 46
      Width = 38
      Height = 16
      Caption = 'Finish:'
    end
    object LTime_step: TLabel
      Left = 11
      Top = 68
      Width = 31
      Height = 16
      Caption = 'Step:'
    end
    object STTime_start: TStaticText
      Left = 60
      Top = 20
      Width = 25
      Height = 20
      Caption = '300'
      TabOrder = 0
    end
    object STTime_finish: TStaticText
      Left = 60
      Top = 46
      Width = 25
      Height = 20
      Caption = '350'
      TabOrder = 1
    end
    object STTime_step: TStaticText
      Left = 60
      Top = 68
      Width = 18
      Height = 20
      Caption = '10'
      TabOrder = 2
    end
  end
  object STLightIntens: TStaticText
    Left = 812
    Top = 328
    Width = 15
    Height = 28
    Caption = '8'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Scaps files (*.iv)|*.iv'
    Left = 426
    Top = 564
  end
  object OpenDialog2: TOpenDialog
    Left = 336
    Top = 600
  end
end
