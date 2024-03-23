unit uAddPatient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, unumEdit, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrAddPatient = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    NumEdit1: TNumEdit;
    DateTimePicker1: TDateTimePicker;
    Edit2: TEdit;
    NumEdit2: TNumEdit;
    NumEdit3: TNumEdit;
    NumEdit4: TNumEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label9: TLabel;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure NumEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DateTimePicker1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure NumEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure NumEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure NumEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    IsForEdit: boolean;
    function AddNewPatient: boolean;
    procedure TabByEnter(Sender: TObject; Key: Char);
    procedure ClearAllFields;
    function UpdatePatient(const id: Int64; PatientName: string;
      NationalID: string; PatientBirthdate: TDate; Address: string;
      Phone1, Phone2: string; ManualRecord: string; Allergic: string; PatientGender: Char): boolean;
  public
    { Public declarations }
    PatientID: Int64;
    procedure GetPatientByID(const PatientID: Int64);
    procedure ExecuteForEdit;
  end;

var
  frAddPatient: TfrAddPatient;

implementation

{$R *.dfm}

uses uMain, uPatients;

{ TfrAddPatient }

function TfrAddPatient.AddNewPatient: boolean;
var
  myQuery: TFDQuery;
  bResult: boolean;
  // iNewID: Int64;
begin
  bResult := False;
  myQuery := TFDQuery.Create(nil);
  try
    frMain.FDConnection1.StartTransaction;
    try
      with myQuery do
      begin
        Connection := frMain.FDConnection1;
        SQL.Add('INSERT INTO patient (id, nid, name, birthdate, manualid, allergic, address, phone1, phone2, gender)');
        SQL.Add(' VALUES (');
        SQL.Add('(select COALESCE(max(id),0) +1 from patient) ,');
        SQL.Add(QuotedStr(Trim(NumEdit1.Text)) + ',');
        SQL.Add(QuotedStr(Trim(Edit1.Text)) + ',');
        SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',
          DateTimePicker1.Date)) + ',');
        SQL.Add(QuotedStr(Trim(NumEdit4.Text)) + ',');
        SQL.Add(QuotedStr(Trim(Edit3.Text)) + ',');
        SQL.Add(QuotedStr(Trim(Edit2.Text)) + ',');
        SQL.Add(QuotedStr(Trim(NumEdit2.Text)) + ',');
        SQL.Add(QuotedStr(Trim(NumEdit3.Text)));
        SQL.Add(','+QuotedStr( ComboBox1.Items[ComboBox1.ItemIndex]));
        SQL.Add(')');
        ExecSQL;
      end;

      frMain.FDConnection1.Commit;
      bResult := True;
    except
      frMain.FDConnection1.Rollback;
    end;
  finally
    myQuery.Free;
  end;
  Result := bResult;
end;

procedure TfrAddPatient.Button1Click(Sender: TObject);
begin
  // if IsForEdit then
  // begin
  // ShowMessage('For edit ');
  // end;
  if (IsForEdit) and (PatientID = -1) then
   begin
     ShowMessage('Please select patient to be edit');
     Exit;
   end;
  if Trim(Edit1.Text) = '' then
  begin
    ShowMessage('Please enter patient name ..');
    Exit;
  end;
  // --
  if NumEdit1.Text = '' then
  begin
    ShowMessage('Plaese enter national ID number');
    Exit;
  end;

  if NumEdit2.Text = '' then
  begin
    ShowMessage('Plaese enter patient number');
    Exit;
  end;
  if ComboBox1.ItemIndex = -1 then
   begin
     ShowMessage('Please Select Patient Gender ..');
     Exit;
   end;
  if not IsForEdit then
  begin
    if AddNewPatient() then
    begin
      ShowMessage('New patient added successfully ...');
      ClearAllFields();
    end
    else
    begin
      ShowMessage('Error in adding new patient information ...');
    end;
  end
  else
  begin
    if PatientID <> -1 then
    begin
      if UpdatePatient(PatientID, Trim(Edit1.Text), Trim(NumEdit1.Text),
        DateTimePicker1.Date, Trim(Edit2.Text), Trim(NumEdit2.Text),
        Trim(NumEdit3.Text), Trim(NumEdit4.Text), Trim(Edit3.Text)
        , ComboBox1.Items[ComboBox1.ItemIndex][1]    //-- Very unusual use [n]
        ) then
      begin
        ShowMessage('Patient updated successfully ..');
        ClearAllFields();
        PatientID := -1;
      end
      else
      begin
        ShowMessage('Error in update Patient information');
      end;
    end;
  end;
end;

procedure TfrAddPatient.Button2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrAddPatient.Button3Click(Sender: TObject);
begin
  ClearAllFields();
  // -
  PatientID := -1;
  // -
  with TfrPatients.Create(nil) do
    try
      Execute(1, Self);
    finally
      Free;
    end;
end;

procedure TfrAddPatient.ClearAllFields;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I].ClassType = TEdit then
    begin
      (Components[I] as TEdit).Text := '';
    end
    else if Components[I].ClassType = TNumEdit then
    begin
      (Components[I] as TNumEdit).Text := '';
    end
    else if Components[I].ClassType = TDateTimePicker then
    begin
      (Components[I] as TDateTimePicker).Date := Date();
    end
    else if Components[I].ClassType = TComboBox then
          begin
            (Components[I] as TComboBox).ItemIndex := -1;
          end;
  end;
  Edit1.SetFocus();
end;

procedure TfrAddPatient.DateTimePicker1KeyPress(Sender: TObject; var Key: Char);
begin
  TabByEnter(Sender, Key);
end;

procedure TfrAddPatient.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Trim((Sender as TEdit).Text) <> '' then
  begin
    TabByEnter(Sender, Key);
  end;
end;

procedure TfrAddPatient.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  TabByEnter(Sender, Key);
end;

procedure TfrAddPatient.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  TabByEnter(Sender, Key);
end;

procedure TfrAddPatient.ExecuteForEdit;
begin
  IsForEdit := True;
  PatientID := -1;
  Button3.Visible := True;
  ShowModal;
end;

procedure TfrAddPatient.FormCreate(Sender: TObject);
begin
 DateTimePicker1.DateTime := Now;
end;

procedure TfrAddPatient.GetPatientByID(const PatientID: Int64);
var
  myQuery: TFDQuery;
begin
  myQuery := TFDQuery.Create(nil);
  try
    with myQuery do
    begin
      Connection := frMain.FDConnection1;
      // -
      SQL.Add('Select * from patient');
      SQL.Add('WHERE id = ' + IntToStr(PatientID));
      Open();
    end;
    if not myQuery.IsEmpty then
    begin
      Edit1.Text := Trim(myQuery.FieldByName('name').AsString);
      NumEdit1.Text := Trim(myQuery.FieldByName('nid').AsString);
      DateTimePicker1.DateTime := myQuery.FieldByName('birthdate').AsDateTime;
      Edit2.Text := Trim(myQuery.FieldByName('address').AsString);
      NumEdit2.Text := Trim(myQuery.FieldByName('phone1').AsString);
      NumEdit3.Text := Trim(myQuery.FieldByName('phone2').AsString);
      NumEdit4.Text := Trim(myQuery.FieldByName('manualid').AsString);
      Edit3.Text := Trim(myQuery.FieldByName('allergic').AsString);
      ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(myQuery.FieldByName('gender').AsString[1]);
      Self.PatientID := PatientID;
    end;

  finally
    myQuery.Free;
  end;
end;

procedure TfrAddPatient.NumEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Trim((Sender as TEdit).Text) <> '' then
  begin
    TabByEnter(Sender, Key);
  end;
end;

procedure TfrAddPatient.NumEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  TabByEnter(Sender, Key);
end;

procedure TfrAddPatient.NumEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  TabByEnter(Sender, Key);
end;

procedure TfrAddPatient.NumEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  TabByEnter(Sender, Key);
end;

procedure TfrAddPatient.TabByEnter(Sender: TObject; Key: Char);
begin
  if Key = #13 then
  begin
    if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
    begin
      SelectNext((Sender as TWinControl), False, True);
    end
    else
    begin
      SelectNext((Sender as TWinControl), True, True);
    end;
    Key := #0;
  end;
end;

function TfrAddPatient.UpdatePatient(const id: Int64;
  PatientName, NationalID: string; PatientBirthdate: TDate;
  Address, Phone1, Phone2, ManualRecord, Allergic: string; PatientGender: Char): boolean;
// --
var
  bResult: boolean;
  myQuery: TFDQuery;
begin
  bResult := False;
  // --
  myQuery := TFDQuery.Create(nil);
  try
    frMain.FDConnection1.StartTransaction;
    try
      with myQuery do
      begin
        Connection := frMain.FDConnection1;
        // --
        SQL.Add('UPDATE patient SET ');
        SQL.Add('nid=' + QuotedStr(NationalID) + ',');
        SQL.Add('name=' + QuotedStr(PatientName) + ',');
        SQL.Add('birthdate=' + QuotedStr(FormatDateTime('yyyy-MM-dd',
          PatientBirthdate)) + ',');
        SQL.Add('manualid=' + QuotedStr(ManualRecord) + ',');
        SQL.Add('allergic=' + QuotedStr(Allergic) + ',');
        SQL.Add('address=' + QuotedStr(Address) + ',');
        SQL.Add('phone1=' + QuotedStr(Phone1) + ',');
        SQL.Add('phone2=' + QuotedStr(Phone2));
        SQL.Add(', gender='+ QuotedStr(PatientGender));
        SQL.Add('WHERE id =' + IntToStr(id));
        ExecSQL;
      end;
      frMain.FDConnection1.Commit;
      bResult := True;
    Except
      frMain.FDConnection1.Rollback;
    end;
  finally
    myQuery.Free;
  end;
  Result := bResult;
end;

end.
