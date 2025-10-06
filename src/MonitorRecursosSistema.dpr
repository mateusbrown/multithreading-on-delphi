program MonitorRecursosSistema;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uWinUsageHelpers in 'uWinUsageHelpers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
