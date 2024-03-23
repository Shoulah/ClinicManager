object frPatients: TfrPatients
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Patients'
  ClientHeight = 472
  ClientWidth = 416
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
    Left = 20
    Top = 8
    Width = 41
    Height = 19
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 20
    Top = 44
    Width = 44
    Height = 19
    Caption = 'Phone'
  end
  object Label3: TLabel
    Left = 281
    Top = 44
    Width = 17
    Height = 19
    Caption = 'ID'
  end
  object Label4: TLabel
    Left = 20
    Top = 74
    Width = 33
    Height = 19
    Caption = 'N ID'
  end
  object Label5: TLabel
    Left = 290
    Top = 451
    Width = 103
    Height = 13
    Caption = 'Press escape to close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 72
    Top = 8
    Width = 321
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TextHint = 'Search By patient Name'
    OnChange = Edit1Change
    OnEnter = Edit1Enter
  end
  object NumEdit1: TNumEdit
    Left = 72
    Top = 41
    Width = 169
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TextHint = 'Search By Phone'
    OnChange = NumEdit1Change
    OnEnter = NumEdit1Enter
    AllowZeroStart = True
  end
  object NumEdit2: TNumEdit
    Left = 304
    Top = 41
    Width = 89
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TextHint = 'Search by ID'
    OnEnter = NumEdit2Enter
    OnKeyPress = NumEdit2KeyPress
    AllowZeroStart = False
  end
  object NumEdit3: TNumEdit
    Left = 72
    Top = 74
    Width = 321
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TextHint = 'Search By National ID'
    OnChange = NumEdit3Change
    OnEnter = NumEdit3Enter
    AllowZeroStart = True
  end
  object DBGrid1: TDBGrid
    Left = 20
    Top = 104
    Width = 373
    Height = 345
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Title.Caption = 'ID'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Alignment = taCenter
        Title.Caption = 'Patient Name'
        Width = 265
        Visible = True
      end>
  end
  object FDQuery1: TFDQuery
    Connection = frMain.FDConnection1
    Left = 72
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 64
    Top = 224
  end
end
