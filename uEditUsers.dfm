object frEditUsers: TfrEditUsers
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edit User Account'
  ClientHeight = 348
  ClientWidth = 508
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 481
    Height = 105
    TabOrder = 0
    object Label1: TLabel
      Left = 19
      Top = 21
      Width = 52
      Height = 13
      Caption = 'User Name'
    end
    object Label2: TLabel
      Left = 19
      Top = 48
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label3: TLabel
      Left = 19
      Top = 75
      Width = 100
      Height = 13
      Caption = 'Enable / Disable user'
    end
    object Label12: TLabel
      Left = 305
      Top = 50
      Width = 33
      Height = 13
      Caption = 'Group:'
    end
    object Edit1: TEdit
      Left = 125
      Top = 18
      Width = 162
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 125
      Top = 45
      Width = 162
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object ToggleSwitch1: TToggleSwitch
      Left = 125
      Top = 72
      Width = 92
      Height = 20
      TabOrder = 2
    end
    object Button1: TButton
      Left = 344
      Top = 16
      Width = 129
      Height = 25
      Caption = 'Select a user to edit'
      TabOrder = 3
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 344
      Top = 47
      Width = 129
      Height = 21
      Style = csDropDownList
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 119
    Width = 481
    Height = 190
    TabOrder = 1
    object Label4: TLabel
      Left = 133
      Top = 19
      Width = 51
      Height = 13
      Caption = 'First Name'
    end
    object Label5: TLabel
      Left = 304
      Top = 19
      Width = 50
      Height = 13
      Caption = 'Last Name'
    end
    object Label6: TLabel
      Left = 13
      Top = 19
      Width = 28
      Height = 13
      Caption = 'Prefix'
    end
    object Label7: TLabel
      Left = 13
      Top = 46
      Width = 30
      Height = 13
      Caption = 'Phone'
    end
    object Label8: TLabel
      Left = 13
      Top = 101
      Width = 30
      Height = 13
      Caption = 'Phone'
    end
    object Label9: TLabel
      Left = 13
      Top = 128
      Width = 39
      Height = 13
      Caption = 'Address'
    end
    object Label10: TLabel
      Left = 13
      Top = 156
      Width = 52
      Height = 13
      Caption = 'Specialized'
    end
    object Label11: TLabel
      Left = 13
      Top = 73
      Width = 30
      Height = 13
      Caption = 'Phone'
    end
    object edtPrefix: TEdit
      Left = 67
      Top = 16
      Width = 60
      Height = 21
      TabOrder = 0
      OnKeyPress = edtPrefixKeyPress
    end
    object edtFirstName: TEdit
      Left = 190
      Top = 16
      Width = 108
      Height = 21
      TabOrder = 1
      OnKeyPress = edtFirstNameKeyPress
    end
    object edtLastName: TEdit
      Left = 360
      Top = 16
      Width = 118
      Height = 21
      TabOrder = 2
      OnKeyPress = edtLastNameKeyPress
    end
    object edtPhone1: TNumEdit
      Left = 67
      Top = 43
      Width = 124
      Height = 21
      TabOrder = 3
      OnKeyPress = edtPhone1KeyPress
      AllowZeroStart = True
      AllowMinus = False
    end
    object edtPhone2: TNumEdit
      Left = 67
      Top = 70
      Width = 124
      Height = 21
      TabOrder = 4
      OnKeyPress = edtPhone2KeyPress
      AllowZeroStart = True
      AllowMinus = False
    end
    object edtPhone3: TNumEdit
      Left = 67
      Top = 98
      Width = 124
      Height = 21
      TabOrder = 5
      OnKeyPress = edtPhone3KeyPress
      AllowZeroStart = True
      AllowMinus = False
    end
    object edtAddress: TEdit
      Left = 67
      Top = 125
      Width = 402
      Height = 21
      TabOrder = 6
      OnKeyPress = edtAddressKeyPress
    end
    object edtSpecialized: TEdit
      Left = 67
      Top = 152
      Width = 402
      Height = 21
      TabOrder = 7
      OnKeyPress = edtSpecializedKeyPress
    end
  end
  object Button2: TButton
    Left = 406
    Top = 315
    Width = 75
    Height = 25
    Caption = 'SAVE'
    TabOrder = 2
    OnClick = Button2Click
  end
  object QryUserAccount: TFDQuery
    Connection = frMain.FDConnection1
    SQL.Strings = (
      'SELECT username, password, enabled, group_id FROM users_accounts'
      'WHERE ID = :ID')
    Left = 88
    Top = 16
    ParamData = <
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
end
