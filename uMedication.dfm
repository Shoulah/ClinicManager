object frAddMedication: TfrAddMedication
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add New Mediation'
  ClientHeight = 173
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 121
    Height = 19
    Caption = 'Medication Name'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 81
    Height = 19
    Caption = 'Dose/Conc.'
  end
  object Label3: TLabel
    Left = 24
    Top = 104
    Width = 37
    Height = 19
    Caption = 'Form'
  end
  object Label4: TLabel
    Left = 8
    Top = 155
    Width = 105
    Height = 13
    Caption = 'Press Escape to Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 176
    Top = 13
    Width = 337
    Height = 27
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object ComboBox1: TComboBox
    Left = 176
    Top = 101
    Width = 145
    Height = 27
    Style = csDropDownList
    TabOrder = 3
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      'Tab'
      'Cap'
      'Amp'
      'Vail'
      'Syringe'
      'Supp'
      'Patch')
  end
  object ComboBox2: TComboBox
    Left = 255
    Top = 53
    Width = 66
    Height = 27
    Style = csDropDownList
    TabOrder = 2
    OnKeyPress = ComboBox2KeyPress
    Items.Strings = (
      'g'
      'mg'
      'mcg'
      'mg/ml'
      'mg/5ml')
  end
  object Button1: TButton
    Left = 438
    Top = 136
    Width = 75
    Height = 25
    Caption = 'SAVE'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 352
    Top = 136
    Width = 75
    Height = 25
    Caption = 'CANCEL'
    TabOrder = 5
    OnClick = Button2Click
  end
  object FloatEdit1: TFloatEdit
    Left = 176
    Top = 53
    Width = 65
    Height = 27
    Alignment = taCenter
    TabOrder = 1
    OnKeyPress = FloatEdit1KeyPress
  end
  object Button3: TButton
    Left = 400
    Top = 46
    Width = 113
    Height = 25
    Caption = 'Select Medication'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Visible = False
    OnClick = Button3Click
  end
end
