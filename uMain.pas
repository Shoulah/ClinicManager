unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin,
  Vcl.ActnCtrls, Vcl.ActnMenus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrMain = class(TForm)
    StatusBar1: TStatusBar;
    ActionMainMenuBar1: TActionMainMenuBar;
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Image1: TImage;
    Timer1: TTimer;
    Action9: TAction;
    Action10: TAction;
    Action11: TAction;
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
  private
    { Private declarations }
    procedure LoadMainMenu;
    function GetUserGroupID(const UserID: Integer): Integer;
  public
    { Public declarations }
class var UserID: Int64;
  end;

var
  frMain: TfrMain;

implementation

{$R *.dfm}

uses uAddPatient, uPatients, uMedication, uAddUserAccount, uUsers, uEditUsers,
  uAddItem;

procedure TfrMain.Action10Execute(Sender: TObject);
begin
 with TfrEditUsers.Create(nil) do
 try
   ShowModal;
 finally
   Free;
 end;
end;

procedure TfrMain.Action11Execute(Sender: TObject);
 var
  myAddItemForm: TfrAddItem;
begin
  myAddItemForm:= TfrAddItem.Create(nil);
  try
    myAddItemForm.showmodal;
  finally
    myAddItemForm.Free;
  end;
end;

procedure TfrMain.Action1Execute(Sender: TObject);
begin
    Self.Close;
end;

procedure TfrMain.Action2Execute(Sender: TObject);
begin
  with TfrAddPatient.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrMain.Action3Execute(Sender: TObject);
begin
  with TfrPatients.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrMain.Action4Execute(Sender: TObject);
begin
  with TfrAddPatient.Create(nil) do
    try
      ExecuteForEdit;
    finally
      Free;
    end;
end;

procedure TfrMain.Action5Execute(Sender: TObject);
begin
  with TfrAddMedication.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrMain.Action6Execute(Sender: TObject);
begin
  with TfrAddMedication.Create(nil) do
    try
      ExecuteForEdit;
    finally
      Free;
    end;
end;

procedure TfrMain.Action8Execute(Sender: TObject);
begin
  with TfrAddUserAccount.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrMain.Action9Execute(Sender: TObject);
begin
 with TfrUsers.Create(nil) do
 try
   ShowModal;
 finally
   Free;
 end;
end;

function TfrMain.GetUserGroupID(const UserID: Integer): Integer;
var
  myQuery: TFDQuery;
begin
  myQuery := TFDQuery.Create(nil);
  try
    myQuery.Connection := FDConnection1;
    myQuery.SQL.Add('SELECT group_id FROM users_accounts');
    myQuery.SQL.Add('WHERE id =' + IntToStr(UserID));
    myQuery.Open();
    Result := myQuery.FieldByName('group_id').AsInteger;
  finally
    myQuery.Free;
  end;
end;

procedure TfrMain.LoadMainMenu;
var
  lGroupID: Integer;
  I: Integer;
begin

  lGroupID := GetUserGroupID(UserID);
  // --
  if lGroupID = 3 then
  begin
    for I := 0 to ActionMainMenuBar1.ActionManager.ActionCount - 1 do
    begin
      if I in [1, 2, 3] then
       begin
        ActionMainMenuBar1.ActionControls[I].Visible := False;
       end;
    end;
  end;
   ActionMainMenuBar1.Visible := True;
end;

procedure TfrMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  LoadMainMenu();
end;

end.
