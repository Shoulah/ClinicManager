object frAddUserAccount: TfrAddUserAccount
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add New Account'
  ClientHeight = 117
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label2: TLabel
    Left = 40
    Top = 54
    Width = 55
    Height = 16
    Caption = 'Password'
  end
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 63
    Height = 16
    Caption = 'User Name'
  end
  object Edit2: TEdit
    Left = 112
    Top = 51
    Width = 225
    Height = 24
    TabOrder = 0
    OnKeyPress = Edit2KeyPress
  end
  object Edit1: TEdit
    Left = 112
    Top = 21
    Width = 225
    Height = 24
    TabOrder = 1
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 262
    Top = 81
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button1Click
  end
  object QryAddUser: TFDQuery
    Connection = frMain.FDConnection1
    SQL.Strings = (
      
        'INSERT INTO users_accounts (id, username, password) values ((coa' +
        'lesce((SELECT max(id) FROM users_accounts), 0)+1), :UserName, :P' +
        'assword);')
    Left = 72
    Top = 72
    ParamData = <
      item
        Name = 'USERNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
