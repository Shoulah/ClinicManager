object frAddPatient: TfrAddPatient
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Patient'
  ClientHeight = 310
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 30
    Top = 24
    Width = 41
    Height = 19
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 30
    Top = 53
    Width = 80
    Height = 19
    Caption = 'National ID'
  end
  object Label3: TLabel
    Left = 30
    Top = 82
    Width = 63
    Height = 19
    Caption = 'Birthdate'
  end
  object Label4: TLabel
    Left = 30
    Top = 111
    Width = 57
    Height = 19
    Caption = 'Address'
  end
  object Label5: TLabel
    Left = 30
    Top = 140
    Width = 44
    Height = 19
    Caption = 'Phone'
  end
  object Label6: TLabel
    Left = 30
    Top = 169
    Width = 44
    Height = 19
    Caption = 'Phone'
  end
  object Label7: TLabel
    Left = 30
    Top = 198
    Width = 134
    Height = 19
    Caption = 'Manual Record No.'
  end
  object Label8: TLabel
    Left = 30
    Top = 228
    Width = 53
    Height = 19
    Caption = 'Allergic'
  end
  object Label9: TLabel
    Left = 396
    Top = 82
    Width = 51
    Height = 19
    Caption = 'Gender'
  end
  object Edit1: TEdit
    Left = 176
    Top = 21
    Width = 352
    Height = 27
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object NumEdit1: TNumEdit
    Left = 176
    Top = 50
    Width = 225
    Height = 27
    TabOrder = 1
    OnKeyPress = NumEdit1KeyPress
    AllowZeroStart = True
  end
  object DateTimePicker1: TDateTimePicker
    Left = 176
    Top = 79
    Width = 113
    Height = 27
    Date = 44663.000000000000000000
    Time = 0.855042268522083800
    TabOrder = 2
    OnKeyPress = DateTimePicker1KeyPress
  end
  object Edit2: TEdit
    Left = 176
    Top = 108
    Width = 433
    Height = 27
    TabOrder = 4
    OnKeyPress = Edit2KeyPress
  end
  object NumEdit2: TNumEdit
    Left = 176
    Top = 137
    Width = 225
    Height = 27
    TabOrder = 5
    OnKeyPress = NumEdit2KeyPress
    AllowZeroStart = True
  end
  object NumEdit3: TNumEdit
    Left = 176
    Top = 166
    Width = 225
    Height = 27
    TabOrder = 6
    OnKeyPress = NumEdit3KeyPress
    AllowZeroStart = True
  end
  object NumEdit4: TNumEdit
    Left = 176
    Top = 195
    Width = 225
    Height = 27
    TabOrder = 7
    OnKeyPress = NumEdit4KeyPress
    AllowZeroStart = True
  end
  object Edit3: TEdit
    Left = 176
    Top = 225
    Width = 433
    Height = 27
    TabOrder = 8
    OnKeyPress = Edit3KeyPress
  end
  object Button1: TButton
    Left = 534
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 453
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 10
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 534
    Top = 22
    Width = 97
    Height = 25
    Caption = 'Select Patient'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Visible = False
    OnClick = Button3Click
  end
  object ComboBox1: TComboBox
    Left = 453
    Top = 79
    Width = 75
    Height = 27
    Style = csDropDownList
    TabOrder = 3
    Items.Strings = (
      'F'
      'M')
  end
end
