unit uConfiguradorINI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, jpeg, ActnList, System.Actions;

type
  TfrmConfiguradorINI = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    edtServidorBanco: TEdit;
    lblServidorBanco: TLabel;
    edtPathBanco: TEdit;
    Label1: TLabel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    ActionList1: TActionList;
    acSalvar: TAction;
    acCancelar: TAction;
    acFechar: TAction;
    Label2: TLabel;
    edtServidorCurriculo: TEdit;
    edtServidorVaga: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    Conexao : TIniFile;
    vpDiretorio : string;
  public
    { Public declarations }
  end;

var
  frmConfiguradorINI: TfrmConfiguradorINI;

implementation

{$R *.dfm}

procedure TfrmConfiguradorINI.FormCreate(Sender: TObject);
begin
  vpDiretorio := GetCurrentDir + '\Config.ini';
  btnCancelar.Click;
end;

procedure TfrmConfiguradorINI.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConfiguradorINI.btnCancelarClick(Sender: TObject);
begin

  if not DirectoryExists(vpDiretorio) then
   Conexao := TIniFile.Create(vpDiretorio);
  edtServidorBanco.Text     := Conexao.ReadString('PARAMETRO', 'NOMEBANCO', '');
  edtPathBanco.Text         := Conexao.ReadString('PARAMETRO', 'DLL', '');
  edtServidorCurriculo.Text := Conexao.ReadString('PARAMETRO', 'SERVIDORCURRICULO', '');
  edtServidorVaga.Text := Conexao.ReadString('PARAMETRO', 'SERVIDORVAGA', '');

end;

procedure TfrmConfiguradorINI.btnSalvarClick(Sender: TObject);
begin
  Try
    Conexao.WriteString('PARAMETRO', 'NOMEBANCO', edtServidorBanco.Text);
    Conexao.WriteString('PARAMETRO', 'DLL', edtPathBanco.Text);
    Conexao.WriteString('PARAMETRO', 'SERVIDORCURRICULO', edtServidorCurriculo.Text);
    Conexao.WriteString('PARAMETRO', 'SERVIDORVAGA', edtServidorVaga.Text);

    Application.messageBox('SALVO COM SUCESSO!','SALVAR',MB_OK+mb_IconInformation)
  except
    on e:Exception do
    begin
      Application.messageBox('ERRO AQUI MAN','ERRO',MB_OK+mb_IconInformation)
    end
  end;
end;

end.
