unit uPatients;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unumEdit, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrPatients = class(TForm)
    Edit1: TEdit;
    NumEdit1: TNumEdit;
    NumEdit2: TNumEdit;
    NumEdit3: TNumEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBGrid1: TDBGrid;
    Label5: TLabel;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure NumEdit1Change(Sender: TObject);
    procedure NumEdit3Change(Sender: TObject);
    procedure NumEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Enter(Sender: TObject);
    procedure NumEdit1Enter(Sender: TObject);
    procedure NumEdit2Enter(Sender: TObject);
    procedure NumEdit3Enter(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    CreatorID : Integer;
    ParentForm: TCustomForm;
    procedure DoSearch;
    procedure DoSearchByPhone;
    procedure DoSearchByNationalID;
    procedure DoSearchByID;
  public
    { Public declarations }
    procedure Execute(myId: Integer; myParentForm: TCustomForm);
  end;

var
  frPatients: TfrPatients;

implementation

{$R *.dfm}

uses uMain, uAddPatient;

procedure TfrPatients.DBGrid1DblClick(Sender: TObject);
begin
 if not FDQuery1.IsEmpty then
  begin
    case CreatorID of
     1:
     begin
       (ParentForm as TfrAddPatient).GetPatientByID(FDQuery1.FieldByName('id').AsLargeInt);
     end;
    end;
    //--
    Self.Close;
  end;
end;

procedure TfrPatients.DoSearch;
begin
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('select id, name from patient');
  FDQuery1.SQL.Add('WHERE upper(name) like upper(:myname)');
  FDQuery1.ParamByName('myname').DataType := ftString;
  FDQuery1.ParamByName('myname').Value := Trim(Edit1.Text + '%');
  FDQuery1.Open();
end;

procedure TfrPatients.DoSearchByNationalID;
begin
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('select id, name from patient');
  FDQuery1.SQL.Add('WHERE nid like :NationalID');
  FDQuery1.ParamByName('NationalID').DataType := ftString;
  FDQuery1.ParamByName('NationalID').Value := Trim(NumEdit3.Text + '%');
  FDQuery1.Open();
end;

procedure TfrPatients.DoSearchByPhone;
begin
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('select id, name from patient');
  FDQuery1.SQL.Add
    ('WHERE phone1 like :PhoneNumber or phone2 like :PhoneNumber');
  FDQuery1.ParamByName('PhoneNumber').DataType := ftString;
  FDQuery1.ParamByName('PhoneNumber').Value := Trim(NumEdit1.Text + '%');
  FDQuery1.Open();
end;

procedure TfrPatients.Edit1Change(Sender: TObject);
begin
  DoSearch();
end;

procedure TfrPatients.Edit1Enter(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I].ClassType = TNumEdit then
      (Components[I] as TNumEdit).Text := '';
  end;
end;



procedure TfrPatients.Execute(myId: Integer; myParentForm: TCustomForm);
begin
 CreatorID := myId;
 ParentForm := myParentForm;
 ShowModal;
end;

procedure TfrPatients.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Self.Close;
  end;
end;

procedure TfrPatients.NumEdit1Change(Sender: TObject);
begin
  DoSearchByPhone
end;

procedure TfrPatients.NumEdit1Enter(Sender: TObject);
begin
  Edit1.Text := '';
  NumEdit2.Text := '';
  NumEdit3.Text := '';
end;

procedure TfrPatients.NumEdit2Enter(Sender: TObject);
begin

  Edit1.Text := '';
  NumEdit1.Text := '';
  NumEdit3.Text := '';
end;

procedure TfrPatients.NumEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Trim(NumEdit2.Text) <> '' then
    begin
      DoSearchByID();
    end;
  end;
end;

procedure TfrPatients.NumEdit3Change(Sender: TObject);
begin
  DoSearchByNationalID();
end;

procedure TfrPatients.NumEdit3Enter(Sender: TObject);
begin

  Edit1.Text := '';
  NumEdit1.Text := '';
  NumEdit2.Text := '';
end;

procedure TfrPatients.DoSearchByID;
begin
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('select id, name from patient');
  FDQuery1.SQL.Add('WHERE id = :ID');
  FDQuery1.ParamByName('ID').DataType := ftLargeint;
  FDQuery1.ParamByName('ID').Value := StrToInt64(NumEdit2.Text);
  FDQuery1.Open();
  if FDQuery1.IsEmpty then
  begin
    ShowMessage('No patient has this id number');
    NumEdit2.Text := '';
    NumEdit2.SetFocus;
  end;
end;

end.
