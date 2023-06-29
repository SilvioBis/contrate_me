program CONFIG_INI;

uses
  Forms,
  uConfiguradorINI in 'uConfiguradorINI.pas' {frmConfiguradorINI};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmConfiguradorINI, frmConfiguradorINI);
  Application.Run;
end.
