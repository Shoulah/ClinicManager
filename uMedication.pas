unit uMedication;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, unumEdit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uFloatEdit;

type
  TfrAddMedication = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    FloatEdit1: TFloatEdit;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FloatEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    IsForEdit: Boolean;
    MedID: Int64;
    function AddMedication(const MedicationName: string; const Dose: string;
      const Form: string): Boolean;
    procedure ClearAllFields;
    function GetFirstLetterPos(const str: string): Integer;
    procedure TabByEnter(Sender: TObject; Key: Char);
    function UpdateMedication(const MedicationID: Int64; MedicationName: string;
      Dose: string; Form: string): Boolean;
  public
    { Public declarations }
    procedure GetMedicationByID(const ID: Integer);
    procedure ExecuteForEdit;
  end;

var
  frAddMedication: TfrAddMedication;

implementation

{$R *.dfm}

uses uMain, uMedicationSearch;

function TfrAddMedication.AddMedication(const MedicationName, Dose,
  Form: string): Boolean;
var
  bResult: Boolean;
  myQuery: TFDQuery;
begin
  bResult := False;
  myQuery := TFDQuery.Create(nil);
  try
    frMain.FDConnection1.StartTransaction;
    try
      with myQuery do
      begin
        Connection := frMain.FDConnection1;
        SQL.Add('INSERT INTO medication(');
        SQL.Add('id, name, dose, form, created, last_update)');
        SQL.Add('VALUES (');
        SQL.Add('(SELECT COALESCE(max(id),0) +1 FROM medication)');
        SQL.Add(',' + QuotedStr(MedicationName));
        SQL.Add(',' + QuotedStr(Dose));
        SQL.Add(',' + QuotedStr(Form));
        SQL.Add(', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP )');
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

procedure TfrAddMedication.Button1Click(Sender: TObject);
begin
  if Trim(Edit1.Text) = '' then
  begin
    ShowMessage('Please enter medication name');
    Exit;
  end;
  if FloatEdit1.Text = '' then
  begin
    ShowMessage('Please enter medication dose and concentration');
    FloatEdit1.SetFocus;
    Exit;
  end;
  if ComboBox2.ItemIndex = -1 then
  begin
    ShowMessage('Please select medication dose conc');
    Exit;
  end;
  if ComboBox1.ItemIndex = -1 then
  begin
    ShowMessage('Please select medication dosage form');
    Exit;
  end;

  // -
  if not IsForEdit then
  begin
    if AddMedication(Trim(Edit1.Text), Trim(FloatEdit1.Text) + ComboBox2.Items
      [ComboBox2.ItemIndex], ComboBox1.Items[ComboBox1.ItemIndex]) then
    begin
      ShowMessage('Medication added successfully ..');
      ClearAllFields();
      Edit1.SetFocus;
    end
    else
    begin
      ShowMessage('Error in adding new medication');
    end;
  end // end not isForEdit
  else
  begin
    // --- Update medication ---
    if UpdateMedication(MedID, Trim(Edit1.Text),
      FloatEdit1.Text + ComboBox2.Items[ComboBox2.ItemIndex],
      ComboBox1.Items[ComboBox1.ItemIndex]) then
    begin
      ShowMessage('Medication updated successfully..');
      ClearAllFields();
      MedID := -1;
    end
    else
    begin
      ShowMessage('Error in update medication..');
    end;
  end;

end;

procedure TfrAddMedication.Button2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrAddMedication.Button3Click(Sender: TObject);
begin
  ClearAllFields();
  MedID := -1;
  with TfrMedicationSearch.Create(nil) do
    try
      Execute(1, Self);
    finally
      Free;
    end;
end;

procedure TfrAddMedication.ClearAllFields;
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
    else if Components[I].ClassType = TComboBox then
    begin
      (Components[I] as TComboBox).ItemIndex := -1;
    end
    else if Components[I].ClassType = TFloatEdit then
    begin
      (Components[I] as TFloatEdit).Text := '';
    end;
  end;
  Edit1.SetFocus();
end;

procedure TfrAddMedication.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (ComboBox1.ItemIndex <> -1) then
  begin
    TabByEnter(Sender, Key);
  end;
end;

procedure TfrAddMedication.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (ComboBox2.ItemIndex <> -1) then
  begin
    TabByEnter(Sender, Key);
  end;
end;

procedure TfrAddMedication.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Trim(Edit1.Text) <> '' then
    begin
      TabByEnter(Sender, Key);
    end;
  end;
end;

procedure TfrAddMedication.ExecuteForEdit;
begin
  IsForEdit := True;
  MedID := -1;
  Button3.Visible := True;
  Self.Caption := 'Update Medication';
  ShowModal;
end;

procedure TfrAddMedication.FloatEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Trim(FloatEdit1.Text) <> '' then
    begin
      TabByEnter(Sender, Key);
    end;
  end;
end;

procedure TfrAddMedication.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Self.Close;
  end;
end;

function TfrAddMedication.GetFirstLetterPos(const str: string): Integer;
var
  I: Integer;
begin
  for I := 1 to Length(str) do
  begin
    if (CharInSet(str[I], ['a' .. 'z'])) or (CharInSet(str[I], ['A' .. 'Z']))
    then
    begin
      Break;
    end;
  end;
  Result := I;
end;

procedure TfrAddMedication.GetMedicationByID(const ID: Integer);
var
  myQuery: TFDQuery;
  AlphaStart: Integer;
begin
  myQuery := TFDQuery.Create(nil);
  try
    with myQuery do
    begin
      Connection := frMain.FDConnection1;
      // -
      SQL.Add('SELECT * FROM medication');
      SQL.Add('WHERE id =' + IntToStr(ID));
      Open();
    end;
    if not myQuery.IsEmpty then
    begin
      Edit1.Text := Trim(myQuery.FieldByName('name').AsString);
      AlphaStart := GetFirstLetterPos(myQuery.FieldByName('dose').AsString);
      FloatEdit1.Text := Copy(myQuery.FieldByName('dose').AsString, 1,
        AlphaStart - 1);
      // --
      ComboBox2.ItemIndex := ComboBox2.Items.IndexOf
        (Copy(myQuery.FieldByName('dose').AsString, AlphaStart,
        Length(myQuery.FieldByName('dose').AsString)));
      // --
      ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(myQuery.FieldByName('form')
        .AsString);
      MedID := ID;
    end;
  finally
    myQuery.Free;
  end;
end;

procedure TfrAddMedication.TabByEnter(Sender: TObject; Key: Char);
begin
  if Key = #13 then
  begin
    if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
    begin
      SelectNext(Sender as TWinControl, False, True);
    end
    else
    begin
      SelectNext(Sender as TWinControl, True, True);
    end;
    Key := #0;
  end;
end;

function TfrAddMedication.UpdateMedication(const MedicationID: Int64;
  MedicationName, Dose, Form: string): Boolean;
var
  bResult: Boolean;
  myQuery: TFDQuery;
begin
  bResult := False;
  myQuery := TFDQuery.Create(nil);
  try
    frMain.FDConnection1.StartTransaction;
    try
      with myQuery do
      begin
        Connection := frMain.FDConnection1;
        // --
        SQL.Add('UPDATE medication set');
        SQL.Add('name=' + QuotedStr(MedicationName));
        SQL.Add(', dose=' + QuotedStr(Dose));
        SQL.Add(', form=' + QuotedStr(Form));
        SQL.Add(', last_update = CURRENT_TIMESTAMP');
        SQL.Add('WHERE id=' + IntToStr(MedicationID));
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
