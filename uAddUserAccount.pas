unit uAddUserAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uMain, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrAddUserAccount = class(TForm)
    Edit2: TEdit;
    Edit1: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Button1: TButton;
    QryAddUser: TFDQuery;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function AddNewUser(const UserName: string; const Password: string)
      : Boolean;
    procedure DoSave;
  public
    { Public declarations }
  end;

var
  frAddUserAccount: TfrAddUserAccount;

implementation

{$R *.dfm}

function TfrAddUserAccount.AddNewUser(const UserName, Password: string)
  : Boolean;
var
  bResult: Boolean;
begin
  bResult := False;
  frMain.FDConnection1.StartTransaction;
  try
    QryAddUser.Close;
    QryAddUser.Params.ParamByName('UserName').AsString := UserName;
    QryAddUser.Params.ParamByName('Password').AsString := Password;
    QryAddUser.ExecSQL;
    frMain.FDConnection1.Commit;
    bResult := True;
  except
    frMain.FDConnection1.Rollback;
  end;
  Result := bResult;
end;

procedure TfrAddUserAccount.Button1Click(Sender: TObject);
begin
  DoSave();
end;

procedure TfrAddUserAccount.DoSave;
begin
  if (Trim(Edit1.Text) <> '') and (Trim(Edit2.Text) <> '') then
  begin
    if AddNewUser(Trim(Edit1.Text), Trim(Edit2.Text)) then
    begin
      ShowMessage('User Added successfully');
      Edit1.Text := '';
      Edit2.Text := '';
    end
    else
    begin
      ShowMessage('Error in adding new account');
    end;
  end;
end;

procedure TfrAddUserAccount.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Trim(Edit1.Text) <> '' then
    begin
      Edit1.SetFocus;
    end;
  end;
end;

procedure TfrAddUserAccount.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if (Trim(Edit1.Text) <> '') and (Trim(Edit2.Text) <> '') then
    begin
      DoSave();
    end;
  end;
end;

end.
