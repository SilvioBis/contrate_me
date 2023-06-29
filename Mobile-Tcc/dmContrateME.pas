unit dmContrateME;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, System.IniFiles, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,Windows ;

type
  Tdm_ContrateME = class(TDataModule)
    conexao: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DLL: TFDPhysMySQLDriverLink;
    Transacao: TFDTransaction;
    qryLogin: TFDQuery;
    qryConsulta: TFDQuery;
    qryCidade: TFDQuery;
    SQLExecutar: TFDQuery;
    qryConsulta2: TFDQuery;
    qryConsulta3: TFDQuery;
    qryConsulta4: TFDQuery;
    qryPessoas: TFDQuery;
    qryEmpresa: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  Arquivo : TIniFile;
  vpDiretorio : string;
    { Public declarations }
  end;

var
  dm_ContrateME: Tdm_ContrateME;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uCarregando;

{$R *.dfm}

procedure Tdm_ContrateME.DataModuleCreate(Sender: TObject);
VAR TESTE, TESTE2 : STRING;
begin

  vpDiretorio := GetCurrentDir + '\Config.ini';

  Arquivo := TIniFile.Create(vpDiretorio);
  conexao.Params.Database := Arquivo.ReadString('PARAMETRO', 'NOMEBANCO', '');
  DLL.VendorLib := Arquivo.ReadString('PARAMETRO', 'DLL', '');
  conexao.Connected := true;
  frmCarregando := TfrmCarregando.Create(Self);
  frmCarregando.ShowModal;

  FreeMem(Pointer(frmCarregando));
  frmCarregando := nil;
  FreeMem(pointer(self));
  ExitProcess(0);
end;

end.