unit uMedicationSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uMedication;

type
  TfrMedicationSearch = class(TForm)
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ParentForm: TCustomForm;
    CreatorID: Integer;
    procedure DoSearch;
    procedure SelectItem;
  public
    { Public declarations }
    procedure Execute(myCreator: Integer; myParentForm: TCustomForm);
  end;

var
  frMedicationSearch: TfrMedicationSearch;

implementation

{$R *.dfm}

uses uMain;

{ TfrMedicationSearch }

procedure TfrMedicationSearch.DBGrid1DblClick(Sender: TObject);
begin
  // if not FDQuery1.IsEmpty then
  // begin
  // case CreatorID of
  // 1:
  // begin
  // (ParentForm as TfrAddMedication).GetMedicationByID(FDQuery1.FieldByName('id').AsInteger);
  // end;
  // end;
  // Self.Close;
  // end;
  SelectItem();
end;

procedure TfrMedicationSearch.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    SelectItem();
  end
  else if Key = Char(VK_BACK) then
  begin
    Edit1.SetFocus;
  end;
end;

procedure TfrMedicationSearch.DoSearch;
begin
  with FDQuery1 do
  begin
    Close;
    Params.ParamByName('MEDICATIONNAME').Value := Trim(Edit1.Text) + '%';
    Open;
  end;
end;

procedure TfrMedicationSearch.Edit1Change(Sender: TObject);
begin
  DoSearch();
end;

procedure TfrMedicationSearch.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (not FDQuery1.IsEmpty) then
  begin
    DBGrid1.SetFocus;
  end;
end;

procedure TfrMedicationSearch.Execute(myCreator: Integer;
  myParentForm: TCustomForm);
begin
  CreatorID := myCreator;
  ParentForm := myParentForm;
  ShowModal;
end;

procedure TfrMedicationSearch.FormCreate(Sender: TObject);
begin
  DoSearch();
end;

procedure TfrMedicationSearch.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_ESCAPE) then
  begin
    Self.Close;
  end;
end;

procedure TfrMedicationSearch.SelectItem;
begin
  if not FDQuery1.IsEmpty then
  begin
    case CreatorID of
      1:
        begin
          (ParentForm as TfrAddMedication).GetMedicationByID
            (FDQuery1.FieldByName('id').AsInteger);
        end;
    end;
    Self.Close;
  end;
end;

end.
