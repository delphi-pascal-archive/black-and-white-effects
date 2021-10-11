object Form1: TForm1
  Left = 215
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Black and white effects'
  ClientHeight = 498
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 633
    Height = 481
  end
  object Label1: TLabel
    Left = 648
    Top = 264
    Width = 201
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Threshold: 50%'
  end
  object BtFloyd_Steinberg: TButton
    Left = 648
    Top = 40
    Width = 201
    Height = 25
    Caption = 'Floyd-Steinberg'
    TabOrder = 0
    OnClick = BtFloyd_SteinbergClick
  end
  object btAleatoire: TButton
    Left = 648
    Top = 72
    Width = 201
    Height = 25
    Caption = 'Random'
    TabOrder = 1
    OnClick = btAleatoireClick
  end
  object BtMatriciel22: TButton
    Left = 648
    Top = 104
    Width = 201
    Height = 25
    Caption = 'Matrix 2x2'
    TabOrder = 2
    OnClick = BtMatriciel22Click
  end
  object BtMatriciel33: TButton
    Left = 648
    Top = 136
    Width = 201
    Height = 25
    Caption = 'Matrix 3x3'
    TabOrder = 3
    OnClick = BtMatriciel33Click
  end
  object BtMatriciel44: TButton
    Left = 648
    Top = 168
    Width = 201
    Height = 25
    Caption = 'Matrix 4x4'
    TabOrder = 4
    OnClick = BtMatriciel44Click
  end
  object BtOriginal: TButton
    Left = 648
    Top = 8
    Width = 201
    Height = 25
    Caption = 'Original'
    TabOrder = 5
    OnClick = BtOriginalClick
  end
  object Btseuil40: TButton
    Tag = 40
    Left = 648
    Top = 200
    Width = 201
    Height = 25
    Caption = 'Threshold'
    TabOrder = 6
    OnClick = BtseuilClick
  end
  object TrackSeuil: TTrackBar
    Left = 648
    Top = 232
    Width = 201
    Height = 25
    Max = 256
    Frequency = 16
    Position = 128
    TabOrder = 7
    ThumbLength = 12
    OnChange = TrackSeuilChange
  end
  object BtFloyd_SteinbergMatrice: TButton
    Left = 648
    Top = 288
    Width = 201
    Height = 25
    Caption = 'Floyd-Steinberg + Matrix 4x4'
    TabOrder = 8
    OnClick = BtFloyd_SteinbergMatriceClick
  end
  object Button2: TButton
    Left = 648
    Top = 464
    Width = 201
    Height = 25
    Caption = 'Exit'
    TabOrder = 9
    OnClick = Button2Click
  end
  object BtFloyd_SteinbergAleatoire: TButton
    Left = 648
    Top = 320
    Width = 201
    Height = 25
    Caption = 'Floyd-Steinberg + Random'
    TabOrder = 10
    OnClick = BtFloyd_SteinbergAleatoireClick
  end
end
