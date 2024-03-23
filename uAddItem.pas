unit uAddItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, unumEdit,
  uashpercentage, uFloatEdit;

type
  TfrAddItem = class(TForm)
    FDspAddItem: TFDStoredProc;
    edtItemName: TEdit;
    fEdtSalePrice: TFloatEdit;
    pEdtDiscount: TpercentageEdit;
    nEditUnitNo1: TNumEdit;
    nEditUnitNo2: TNumEdit;
    nEdtUnitCode1: TNumEdit;
    nEdtUnitCode2: TNumEdit;
    chkPrint: TCheckBox;
    BtnSave: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure BtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure ClearAllFields;
  public
    { Public declarations }
  end;

var
  frAddItem: TfrAddItem;

implementation

{$R *.dfm}

uses uMain;

procedure TfrAddItem.BtnSaveClick(Sender: TObject);
begin
 if Trim(edtItemName.Text) = '' then
  begin
    ShowMessage('Please eneter item name');
  end
  else
  begin
    with FDspAddItem do
     begin
       Close;

       Params.ParamByName('item_name_p').AsString:= Trim(edtItemName.Text);
       Params.ParamByName('sale_price_p').Value:= StrToFloat(fEdtSalePrice.Text);
       Params.ParamByName('disc_p').Value:= StrToFloat(pEdtDiscount.text);
       Params.ParamByName('unit_no_1_p').AsInteger:= StrToInt(nEditUnitNo1.Text);
       Params.ParamByName('unit_no_2_p').AsInteger:= StrToInt(nEditUnitNo2.Text);
       Params.ParamByName('unit_code_1_p').AsInteger:= StrToInt(nEdtUnitCode1.Text);
       Params.ParamByName('unit_code_2_p').AsInteger:= StrToInt(nEdtUnitCode2.Text);
       Params.ParamByName('print_p').AsBoolean:= chkPrint.Checked;
       ExecProc;
     end;
     ShowMessage('New item has been added successfully ..');
     ClearAllFields();
  end;

end;

procedure TfrAddItem.ClearAllFields;
begin
 edtItemName.Clear;
 fEdtSalePrice.Clear;
 pEdtDiscount.Text := '0';
 nEdtUnitCode1.Text:= '1';
 nEdtUnitCode2.Text:= '1';
 nEditUnitNo1.Text:= '1';
 nEditUnitNo2.Text:= '1';
 chkPrint.Checked:= True;
end;

end.
