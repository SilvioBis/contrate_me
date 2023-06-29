program TCC_DS;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {frmLogin},
  uPadrao in 'uPadrao.pas' {frmPadrao},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  dmContrateME in 'dmContrateME.pas' {dm_ContrateME: TDataModule},
  uFuncoes in 'uFuncoes.pas',
  uMsg in 'uMsg.pas' {frmMsg},
  uCarregando in 'uCarregando.pas' {frmCarregando},
  uCarregandoStatic in 'uCarregandoStatic.pas' {frmCarregandoStatic},
  uCadInfo in 'uCadInfo.pas' {frmCadInfo},
  uUsuario in 'uUsuario.pas',
  uVagas in 'uVagas.pas' {frmVagas};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm_ContrateME, dm_ContrateME);
  Application.CreateForm(TfrmCarregando, frmCarregando);
  Application.Run;
end.
