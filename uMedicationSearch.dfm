object frMedicationSearch: TfrMedicationSearch
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Search For Medication'
  ClientHeight = 454
  ClientWidth = 343
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 16
  object Label4: TLabel
    Left = 8
    Top = 436
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
    Left = 24
    Top = 16
    Width = 297
    Height = 24
    TabOrder = 0
    TextHint = 'Search by Medication Name'
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 46
    Width = 297
    Height = 387
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
        FieldName = 'name'
        Title.Alignment = taCenter
        Title.Caption = 'Medication Name'
        Width = 250
        Visible = True
      end>
  end
  object FDQuery1: TFDQuery
    Connection = frMain.FDConnection1
    SQL.Strings = (
      'SELECT id, name FROM medication'
      'WHERE UPPER(name) like UPPER(:MedicationName)'
      'ORDER BY NAME ASC')
    Left = 32
    Top = 96
    ParamData = <
      item
        Name = 'MEDICATIONNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 64
    Top = 184
  end
end
