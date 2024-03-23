program ClinicManager;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frMain},
  uAddPatient in 'uAddPatient.pas' {frAddPatient},
  uPatients in 'uPatients.pas' {frPatients},
  uMedication in 'uMedication.pas' {frAddMedication},
  uMedicationSearch in 'uMedicationSearch.pas' {frMedicationSearch},
  uLogin in 'uLogin.pas' {frLogin},
  uAddUserAccount in 'uAddUserAccount.pas' {frAddUserAccount},
  Vcl.Themes,
  Vcl.Styles,
  uUsers in 'uUsers.pas' {frUsers},
  uEditUsers in 'uEditUsers.pas' {frEditUsers},
  uAddItem in 'uAddItem.pas' {frAddItem};

{$R *.res}

begin

  if TfrLogin.Execute then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Turquoise Gray');
  Application.CreateForm(TfrMain, frMain);
  frMain.UserID := frLogin.GetUserID();
    Application.Run;
  end;

end.
