unit uUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrUsers = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Creator: Integer;
    myParent: TCustomForm;
    procedure SelectUser;
  public
    { Public declarations }
    procedure Execute(CreatorID: Integer; ParentForm: TCustomForm);
  end;

var
  frUsers: TfrUsers;

implementation

{$R *.dfm}

uses uMain, uEditUsers;

procedure TfrUsers.DBGrid1DblClick(Sender: TObject);
begin
  SelectUser();
end;

procedure TfrUsers.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
    SelectUser();
  end;
end;

procedure TfrUsers.Edit1Change(Sender: TObject);
begin
  if Trim(Edit1.Text) = '' then
  begin
    FDQuery1.Close;
  end
  else
  begin
    FDQuery1.Close;
    FDQuery1.Params.ParamByName('UserName').AsString := Trim(Edit1.Text) + '%';
    FDQuery1.Open();
  end;
end;

procedure TfrUsers.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
    if not FDQuery1.IsEmpty then
     begin
       DBGrid1.SetFocus;
     end;
  end;
end;

procedure TfrUsers.Execute(CreatorID: Integer; ParentForm: TCustomForm);
begin
  myParent := ParentForm;
  Creator := CreatorID;
  ShowModal;
end;

procedure TfrUsers.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_ESCAPE) then
  begin
    Self.Close;
  end;
end;

procedure TfrUsers.SelectUser;
begin
  if not FDQuery1.IsEmpty then
  begin
    case Creator of
      1:
        begin
          (myParent as TfrEditUsers).OpenAccountToEdit
            (FDQuery1.FieldByName('id').AsLargeInt);
        end;
    end;
    Self.Close;
  end;
end;

end.
