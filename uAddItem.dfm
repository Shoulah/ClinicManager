object frAddItem: TfrAddItem
  Left = 0
  Top = 0
  Caption = 'frAddItem'
  ClientHeight = 220
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 17
  object Label1: TLabel
    Left = 42
    Top = 27
    Width = 64
    Height = 17
    Caption = 'Item Name'
  end
  object Label2: TLabel
    Left = 42
    Top = 61
    Width = 56
    Height = 17
    Caption = 'Sale Price'
  end
  object Label3: TLabel
    Left = 281
    Top = 61
    Width = 50
    Height = 17
    Caption = 'Discount'
  end
  object Label4: TLabel
    Left = 42
    Top = 95
    Width = 94
    Height = 17
    Caption = 'Medium Unit no'
  end
  object Label5: TLabel
    Left = 281
    Top = 94
    Width = 77
    Height = 17
    Caption = 'Small Unit no'
  end
  object Label6: TLabel
    Left = 42
    Top = 138
    Width = 106
    Height = 17
    Caption = 'Medium unit code'
  end
  object Label7: TLabel
    Left = 281
    Top = 133
    Width = 91
    Height = 17
    Caption = 'Small unit Code'
  end
  object edtItemName: TEdit
    Left = 154
    Top = 24
    Width = 305
    Height = 25
    TabOrder = 0
  end
  object fEdtSalePrice: TFloatEdit
    Left = 154
    Top = 57
    Width = 121
    Height = 25
    Alignment = taCenter
    TabOrder = 1
    Text = '0'
  end
  object pEdtDiscount: TpercentageEdit
    Left = 378
    Top = 57
    Width = 81
    Height = 25
    Alignment = taCenter
    TabOrder = 2
    text = '0'
  end
  object nEditUnitNo1: TNumEdit
    Left = 154
    Top = 92
    Width = 121
    Height = 25
    TabOrder = 3
    Text = '1'
    AllowZeroStart = True
    AllowMinus = False
  end
  object nEditUnitNo2: TNumEdit
    Left = 378
    Top = 88
    Width = 81
    Height = 25
    TabOrder = 4
    Text = '1'
    AllowZeroStart = True
    AllowMinus = False
  end
  object nEdtUnitCode1: TNumEdit
    Left = 154
    Top = 130
    Width = 121
    Height = 25
    TabOrder = 5
    Text = '1'
    AllowZeroStart = True
    AllowMinus = False
  end
  object nEdtUnitCode2: TNumEdit
    Left = 378
    Top = 130
    Width = 80
    Height = 25
    TabOrder = 6
    Text = '1'
    AllowZeroStart = True
    AllowMinus = False
  end
  object chkPrint: TCheckBox
    Left = 42
    Top = 169
    Width = 106
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Barcode Print'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object BtnSave: TButton
    Left = 200
    Top = 165
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 8
    OnClick = BtnSaveClick
  end
  object FDspAddItem: TFDStoredProc
    Connection = frMain.FDConnection1
    SchemaName = 'public'
    StoredProcName = 'sp_add_item'
    Left = 32
    Top = 16
    ParamData = <
      item
        Position = 1
        Name = 'item_name_p'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'sale_price_p'
        DataType = ftFMTBcd
        FDDataType = dtFmtBCD
        ParamType = ptInput
      end
      item
        Position = 3
        Name = 'disc_p'
        DataType = ftFMTBcd
        FDDataType = dtFmtBCD
        ParamType = ptInput
      end
      item
        Position = 4
        Name = 'unit_no_1_p'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Position = 5
        Name = 'unit_no_2_p'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Position = 6
        Name = 'unit_code_1_p'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Position = 7
        Name = 'unit_code_2_p'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Position = 8
        Name = 'print_p'
        DataType = ftBoolean
        FDDataType = dtBoolean
        ParamType = ptInput
      end>
  end
end
