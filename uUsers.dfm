object frUsers: TfrUsers
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Users'
  ClientHeight = 342
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  DesignSize = (
    372
    342)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 11
    Width = 63
    Height = 16
    Caption = 'User Name'
  end
  object Edit1: TEdit
    Left = 85
    Top = 8
    Width = 262
    Height = 24
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 48
    Width = 331
    Height = 286
    Anchors = [akLeft, akTop, akBottom]
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'ID'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'username'
        Title.Alignment = taCenter
        Title.Caption = 'Name'
        Width = 250
        Visible = True
      end>
  end
  object FDQuery1: TFDQuery
    Connection = frMain.FDConnection1
    SQL.Strings = (
      'SELECT id, username FROM users_accounts'
      'WHERE UPPER(username) LIKE UPPER(:UserName)'
      'ORDER BY username ASC')
    Left = 176
    Top = 168
    ParamData = <
      item
        Name = 'USERNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 224
    Top = 120
  end
end
