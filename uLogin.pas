unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Phys.PGDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Themes;

type
  TfrLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDConnection1: TFDConnection;
    QryLogin: TFDQuery;
    procedure Button1Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    procedure DoLogin;
    procedure LastTimeLoginTime(const ID: Int64);
  public
    { Public declarations }
    class function Execute: Boolean;
    function GetUserID: Int64;
  end;

var
  frLogin: TfrLogin;

implementation

{$R *.dfm}
{ TfrLogin }
  var UserID : Int64;
procedure TfrLogin.Button1Click(Sender: TObject);
begin
   DoLogin;
end;

procedure TfrLogin.DoLogin;
begin
    // -- First check if username and password not Empty
  if (Trim(Edit1.Text) <> '') and (Trim(Edit2.Text) <> '') then
  begin
    // -- Select user based on username and password --
    QryLogin.Close;
    QryLogin.Params.ParamByName('UserName').AsString := Trim(Edit1.Text);
    QryLogin.Params.ParamByName('Password').AsString := Trim(Edit2.Text);
    QryLogin.Open();
    if not QryLogin.IsEmpty then
    begin
      LastTimeLoginTime(QryLogin.FieldByName('id').AsLargeInt);
      UserID := QryLogin.FieldByName('id').AsLargeInt;
      ModalResult := mrOk;
    end
    else
    begin
      ShowMessage('Wrong User Name or password ..');
    end;
  end;
end;

procedure TfrLogin.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
  Key:= #0;
    if Trim(Edit1.Text) <> '' then
     begin
       Edit2.SetFocus;
     end;
  end;
end;

procedure TfrLogin.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
   Key:= #0;
    if (Trim(Edit1.Text) <> '') and (Trim(Edit2.Text) <> '') then
     begin
       DoLogin();
     end;
  end;
end;

class function TfrLogin.Execute: Boolean;
begin
  with TfrLogin.Create(nil) do
    try
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

procedure TfrLogin.FormCreate(Sender: TObject);
begin
   TStyleManager.TrySetStyle('Turquoise Gray');
end;

function TfrLogin.GetUserID: Int64;
begin
 Result := UserID;
end;

procedure TfrLogin.LastTimeLoginTime(const ID: Int64);
 var
  myQuery: TFDQuery;
begin
 myQuery := TFDQuery.Create(nil);
 try
  myQuery.Connection := FDConnection1;
  myQuery.SQL.Add('UPDATE users_accounts SET last_login = CURRENT_TIMESTAMP') ;
  myQuery.SQL.Add('WHERE id = ' + IntToStr(ID));
  myQuery.ExecSQL;
 finally
   myQuery.Free;
 end;
end;

end.
