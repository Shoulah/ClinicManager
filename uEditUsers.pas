unit uEditUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, unumEdit;

type
  TfrEditUsers = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    ToggleSwitch1: TToggleSwitch;
    Label3: TLabel;
    Button1: TButton;
    QryUserAccount: TFDQuery;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtPrefix: TEdit;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtPhone1: TNumEdit;
    edtPhone2: TNumEdit;
    edtPhone3: TNumEdit;
    edtAddress: TEdit;
    edtSpecialized: TEdit;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label12: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtPrefixKeyPress(Sender: TObject; var Key: Char);
    procedure edtFirstNameKeyPress(Sender: TObject; var Key: Char);
    procedure edtLastNameKeyPress(Sender: TObject; var Key: Char);
    procedure edtPhone1KeyPress(Sender: TObject; var Key: Char);
    procedure edtPhone2KeyPress(Sender: TObject; var Key: Char);
    procedure edtPhone3KeyPress(Sender: TObject; var Key: Char);
    procedure edtAddressKeyPress(Sender: TObject; var Key: Char);
    procedure edtSpecializedKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    UserAcountID: Int64;
    procedure GetUserAccountByID(const UserID: Int64);
    Procedure GetUserDetailsByID(const UserID: Int64);
    procedure ClearAllFields;
    function UpdateUserAccount(const UserID: Int64; UserName: string;
      Password, GroupName: string; IsAccoundEnabled: Boolean; Prefix: string;
      FirstName: string; LastName: string; Phone1, Phone2, Phone3: string;
      Address, Specialized: string): Boolean;
    procedure ListAllGroups;
    function GetGroupByID(const GroupID: Integer): string;
    procedure TabByEnter(Sender: TObject; Key: Char);
  public
    { Public declarations }
    procedure OpenAccountToEdit(const UserID: Int64);
  end;

var
  frEditUsers: TfrEditUsers;

implementation

{$R *.dfm}

uses uMain, uUsers;

{ TfrEditUsers }

procedure TfrEditUsers.Button1Click(Sender: TObject);
begin
  UserAcountID := -1;
  ClearAllFields();
  with TfrUsers.Create(nil) do
    try
      Execute(1, Self);
    finally
      Free;
    end;
end;

procedure TfrEditUsers.Button2Click(Sender: TObject);
var
  IsEnabled: Boolean;
begin
  if Trim(Edit1.Text) = '' then
  begin
    ShowMessage('Account User Name can not be empty..');
    Exit;
  end;
  if Trim(Edit2.Text) = '' then
  begin
    ShowMessage('Account Password can not be empty..');
    Exit;
  end;
  if ToggleSwitch1.State = tssOn then
  begin
    IsEnabled := True
  end
  else
  begin
    IsEnabled := False;
  end;
  if UpdateUserAccount(UserAcountID, Trim(Edit1.Text), Trim(Edit2.Text),
    ComboBox1.Items[ComboBox1.ItemIndex], IsEnabled, Trim(edtPrefix.Text),
    Trim(edtFirstName.Text), Trim(edtLastName.Text), Trim(edtPhone1.Text),
    Trim(edtPhone2.Text), Trim(edtPhone3.Text), Trim(edtAddress.Text),
    Trim(edtSpecialized.Text))

  then
  begin
    ShowMessage('Account has been updated successfully ..');
    ClearAllFields();
  end
  else
  begin
    ShowMessage('Error in update account ..');
  end;

end;

procedure TfrEditUsers.ClearAllFields;
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
    end;
  end;
  // --
  ToggleSwitch1.State := tssOff;
  ComboBox1.ItemIndex := -1;
end;

procedure TfrEditUsers.edtAddressKeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.edtFirstNameKeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.edtLastNameKeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.edtPhone1KeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.edtPhone2KeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.edtPhone3KeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.edtPrefixKeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.edtSpecializedKeyPress(Sender: TObject; var Key: Char);
begin
 TabByEnter(Sender, Key);
end;

procedure TfrEditUsers.FormCreate(Sender: TObject);
begin
  ListAllGroups();
  //--
  ToggleSwitch1.StateCaptions.CaptionOn:= 'Enabled';
  ToggleSwitch1.StateCaptions.CaptionOff:= 'Disabled';
end;

function TfrEditUsers.GetGroupByID(const GroupID: Integer): string;
var
  myQuery: TFDQuery;
begin
  myQuery := TFDQuery.Create(nil);
  try
    myQuery.Connection := frMain.FDConnection1;
    myQuery.SQL.Add('SELECT group_name from users_groups');
    myQuery.SQL.Add('WHERE id =' + IntToStr(GroupID));
    myQuery.Open();
    Result := myQuery.FieldByName('group_name').AsString;
  finally
    myQuery.Free;
  end;
end;

procedure TfrEditUsers.GetUserAccountByID(const UserID: Int64);
begin
  QryUserAccount.Close;
  QryUserAccount.Params.ParamByName('ID').AsLargeInt := UserID;
  QryUserAccount.Open();
  if not QryUserAccount.IsEmpty then
  begin
    Edit1.Text := QryUserAccount.FieldByName('username').AsString;
    Edit2.Text := QryUserAccount.FieldByName('password').AsString;
    if QryUserAccount.FieldByName('enabled').AsBoolean then
    begin
      ToggleSwitch1.State := tssOn
    end
    else
    begin
      ToggleSwitch1.State := tssOff;
    end;
    ComboBox1.ItemIndex := ComboBox1.Items.IndexOf
      (GetGroupByID(QryUserAccount.FieldByName('group_id').AsInteger));
  end;
end;

procedure TfrEditUsers.GetUserDetailsByID(const UserID: Int64);
var
  myQuery: TFDQuery;
begin
  myQuery := TFDQuery.Create(nil);
  try
    myQuery.Connection := frMain.FDConnection1;
    myQuery.SQL.Add('SELECT * FROM account_details');
    myQuery.SQL.Add('WHERE account_id =' + IntToStr(UserID));
    myQuery.Open();
    // --- fill details in edit boxes
    if not myQuery.IsEmpty then
    begin
      edtPrefix.Text := myQuery.FieldByName('prefix').AsString;
      edtFirstName.Text := myQuery.FieldByName('f_name').AsString;
      edtLastName.Text := myQuery.FieldByName('l_name').AsString;
      edtPhone1.Text := myQuery.FieldByName('phone1').AsString;
      edtPhone2.Text := myQuery.FieldByName('phone2').AsString;
      edtPhone3.Text := myQuery.FieldByName('phone3').AsString;
      edtAddress.Text := myQuery.FieldByName('address').AsString;
      edtSpecialized.Text := myQuery.FieldByName('specialized').AsString;
    end;
  finally
    myQuery.Free;
  end;
end;

procedure TfrEditUsers.ListAllGroups;
var
  myQuery: TFDQuery;
begin
  myQuery := TFDQuery.Create(nil);
  try
    myQuery.Connection := frMain.FDConnection1;
    myQuery.SQL.Add('SELECT group_name from users_groups');
    myQuery.SQL.Add('ORDER BY group_name');
    myQuery.Open();
    if not myQuery.IsEmpty then
    begin
      while not myQuery.Eof do
      begin
        ComboBox1.Items.Add(myQuery.FieldByName('group_name').AsString);
        myQuery.Next;
      end;
    end;
  finally
    myQuery.Free;
  end;
end;

procedure TfrEditUsers.OpenAccountToEdit(const UserID: Int64);
begin
  GetUserAccountByID(UserID);
  GetUserDetailsByID(UserID);
  UserAcountID := UserID;
end;

procedure TfrEditUsers.TabByEnter(Sender: TObject; Key: Char);
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

function TfrEditUsers.UpdateUserAccount(const UserID: Int64;
  UserName, Password, GroupName: string; IsAccoundEnabled: Boolean;
  Prefix, FirstName, LastName, Phone1, Phone2, Phone3, Address,
  Specialized: string): Boolean;
// --
var
  bResult: Boolean;
  myQuery: TFDQuery;
begin
  bResult := False;
  myQuery := TFDQuery.Create(nil);
  try
    frMain.FDConnection1.StartTransaction;
    try
      myQuery.Connection := frMain.FDConnection1;
      // --
      myQuery.SQL.Add('UPDATE users_accounts SET username = :myUserName');
      myQuery.SQL.Add(', password = :myPassword');
      myQuery.SQL.Add(', last_updated = CURRENT_TIMESTAMP');
      myQuery.SQL.Add(', enabled = :myEnabled');
      myQuery.SQL.Add
        (', group_id = (SELECT id FROM users_groups WHERE group_name = ' +
        QuotedStr(GroupName) + ')');
      myQuery.SQL.Add('WHERE id =' + IntToStr(UserID));
      myQuery.Params.ParamByName('myUserName').DataType := ftString;
      myQuery.Params.ParamByName('myPassword').DataType := ftString;
      myQuery.Params.ParamByName('myEnabled').DataType := ftBoolean;
      myQuery.Params.ParamByName('myUserName').AsString := UserName;
      myQuery.Params.ParamByName('myPassword').AsString := Password;
      myQuery.Params.ParamByName('myEnabled').AsBoolean := IsAccoundEnabled;
      myQuery.ExecSQL;
      myQuery.Close;
      myQuery.SQL.Clear;
      myQuery.SQL.Add
        ('INSERT INTO account_details(account_id, prefix, f_name, l_name, phone1, phone2, phone3, address, specialized)');
      myQuery.SQL.Add('Values(');
      myQuery.SQL.Add(IntToStr(UserID) +
        ', :myPrefix, :myFirstName, :myLastName, :myPhone1, :myPhone2, :myPhone3');
      myQuery.SQL.Add(', :myAddress, :mySpecialized');
      myQuery.SQL.Add(')');
      myQuery.SQL.Add('ON CONFLICT (account_id)');
      myQuery.SQL.Add('DO');
      myQuery.SQL.Add('UPDATE SET prefix =:myPrefix');
      myQuery.SQL.Add(', f_name = :myFirstName');
      myQuery.SQL.Add(', l_name = :myLastName');
      myQuery.SQL.Add(', phone1 = :myPhone1');
      myQuery.SQL.Add(', phone2 = :myPhone2');
      myQuery.SQL.Add(', phone3 = :myPhone3');
      myQuery.SQL.Add(', address = :myAddress');
      myQuery.SQL.Add(', specialized = :mySpecialized');
      myQuery.Params.ParamByName('myPrefix').DataType := ftString;
      myQuery.Params.ParamByName('myFirstName').DataType := ftString;
      myQuery.Params.ParamByName('myLastName').DataType := ftString;
      myQuery.Params.ParamByName('myPhone1').DataType := ftString;
      myQuery.Params.ParamByName('myPhone2').DataType := ftString;
      myQuery.Params.ParamByName('myPhone3').DataType := ftString;
      myQuery.Params.ParamByName('myAddress').DataType := ftString;
      myQuery.Params.ParamByName('mySpecialized').DataType := ftString;
      myQuery.Params.ParamByName('myPrefix').AsString := Prefix;
      myQuery.Params.ParamByName('myFirstName').AsString := FirstName;
      myQuery.Params.ParamByName('myLastName').AsString := LastName;
      myQuery.Params.ParamByName('myPhone1').AsString := Phone1;
      myQuery.Params.ParamByName('myPhone2').AsString := Phone2;
      myQuery.Params.ParamByName('myPhone3').AsString := Phone3;
      myQuery.Params.ParamByName('myAddress').AsString := Address;
      myQuery.Params.ParamByName('mySpecialized').AsString := Specialized;
      myQuery.ExecSQL;
      // --
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

end.
