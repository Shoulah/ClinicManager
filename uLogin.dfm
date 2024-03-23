object frLogin: TfrLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 127
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 19
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 78
    Height = 19
    Caption = 'User Name'
  end
  object Label2: TLabel
    Left = 40
    Top = 56
    Width = 67
    Height = 19
    Caption = 'Password'
  end
  object Edit1: TEdit
    Left = 124
    Top = 21
    Width = 225
    Height = 27
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 124
    Top = 53
    Width = 225
    Height = 27
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = Edit2KeyPress
  end
  object Button1: TButton
    Left = 274
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = Button1Click
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'D:\postgresql_Lib\pgsql\bin\libpq.dll'
    Left = 24
    Top = 24
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=Clinic'
      'Password=pass'
      'User_Name=postgres'
      'Port=5433'
      'DriverID=PG')
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object QryLogin: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT id FROM users_accounts'
      
        'WHERE username = :UserName and password = :Password AND enabled ' +
        '= true')
    Left = 32
    Top = 80
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
