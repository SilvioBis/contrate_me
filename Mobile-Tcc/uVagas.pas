unit uVagas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Objects,
  FMX.ListView;

type
  TfrmVagas = class(TfrmPadrao)
    Label1: TLabel;
    lvInformacoes: TListView;
    Image2: TImage;
    imgVaga: TImage;
    btnSair: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure lvInformacoesItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ListarEmpresa;
    procedure AddEmpresaListView(vCodPessoa: Integer; vEmailContato,
      vTelefoneContato: String; vCodUsuario: integer; vDescricao,
      vAnexo: string; vSequenca: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVagas: TfrmVagas;

implementation

{$R *.fmx}

uses uFuncoes, dmContrateME, uUsuario;

procedure TfrmVagas.btnSairClick(Sender: TObject);
begin
  inherited;
  CLOSE;
end;

procedure TfrmVagas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  lvInformacoes := nil;
end;

procedure TfrmVagas.FormCreate(Sender: TObject);
begin
  inherited;
  ListarEmpresa;
end;

procedure TfrmVagas.ListarEmpresa;
var i : Integer;
begin
  i := 0;
  lvInformacoes.BeginUpdate;
  lvInformacoes.Items.Clear;

  with dm_ContrateME.qryEmpresa do
  begin
    dm_ContrateME.qryEmpresa.Close;
    dm_ContrateME.qryEmpresa.SQL.Text :=  'SELECT * FROM `contrateme`.`cm_empresavaga` EV WHERE EV.CM_EMPVAGA_CODUSUARIO = ' + CampoFloat(tid);

    dm_ContrateME.qryEmpresa.Open;
    if dm_ContrateME.qryEmpresa.IsEmpty then
      Exit;

    while not eof do
    begin
      AddEmpresaListView(dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_CODIGO').AsInteger,
                        dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_EMAILCONTATO').AsString,
                        dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_TELCONTATO').AsString,
                        dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_CODUSUARIO').AsInteger,
                        dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_DESCRICAO').AsString,
                        dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_ANEXO').AsString,
                        i);

      inc(i);
      Next;
    end;

  end;
  lvInformacoes.EndUpdate;
end;

procedure TfrmVagas.lvInformacoesItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  inherited;
  if ItemObject.Name = 'btnExcluir' then
  begin
    if MSG('Confirma Excluir vaga?', 0 , 0,1) = 1 then
    begin
      try
        dm_ContrateME.conexao.StartTransaction;
        dm_ContrateME.SQLExecutar.Close;
        dm_ContrateME.SQLExecutar.SQL.Text := ' DELETE FROM `contrateme`.`cm_vagalinguagem` ' +
                                              ' WHERE CM_VAGALING_CODVAGA = ' + CampoFloat(lvInformacoes.items[ItemIndex].Tag);
        dm_ContrateME.SQLExecutar.ExecSQL;

        dm_ContrateME.SQLExecutar.SQL.Text := ' DELETE FROM `contrateme`.`cm_pessoalvaga` ' +
                                              ' WHERE CM_PESSVAGA_CODVAGA = ' + CampoFloat(lvInformacoes.items[ItemIndex].Tag);
        dm_ContrateME.SQLExecutar.ExecSQL;

        dm_ContrateME.SQLExecutar.SQL.Text := ' DELETE FROM `contrateme`.`cm_empresavaga` ' +
                                              ' WHERE CM_EMPVAGA_CODIGO = '+ CampoFloat(lvInformacoes.items[ItemIndex].Tag);
        dm_ContrateME.SQLExecutar.ExecSQL;

        dm_ContrateME.conexao.Commit;

        MSG('Vaga Deletada com sucesso.',3,0);

        ListarEmpresa;
      except
        on e:Exception do
        begin
          if dm_ContrateME.conexao.InTransaction then
            dm_ContrateME.conexao.Rollback;
          msg('Erro ao Excluir vaga.',2,2);
        end;
      end;
    end;
  end;
end;

procedure TfrmVagas.AddEmpresaListView(vCodPessoa:Integer; vEmailContato: String; vTelefoneContato: String; vCodUsuario: integer;vDescricao: string;vAnexo: string; vSequenca :Integer);
var vEmpresa : TListViewItem;
    vNome : string;
begin

  vEmpresa := lvInformacoes.items.add;

  with vEmpresa do
  begin
    Height := 60;
    Tag    := vCodPessoa;

    if vSequenca <> 0 then
    begin
      imgVaga.MultiResBitmap.Add;
      imgVaga.MultiResBitmap[vSequenca].Bitmap.LoadFromFile(dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_PHOTO').AsString);
    end
    else
    begin
      imgVaga.MultiResBitmap[vSequenca].Bitmap.LoadFromFile(dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_PHOTO').AsString);
    end;

    dm_ContrateME.qryConsulta2.Close;
    dm_ContrateME.qryConsulta2.SQL.Text := 'SELECT * FROM `contrateme`.`cm_empresavaga` EV WHERE EV.CM_EMPVAGA_CODIGO =' + CampoFloat(vCodPessoa);
    dm_ContrateME.qryConsulta2.Open;
    if (imgVaga.MultiResBitmap[vSequenca] <> nil) then
    begin
      TListItemImage(vEmpresa.Objects.FindDrawable('imgPhoto')).Bitmap := imgVaga.MultiResBitmap[vSequenca].Bitmap;
      TListItemImage(vEmpresa.Objects.FindDrawable('imgPhoto')).OwnsBitmap := true;
    end;

    if Trim(dm_ContrateME.qryConsulta2.FindField('CM_EMPVAGA_NOMEVG').AsString) = '' then
      vNome := 'Sem Nome'
    else
      vNome := dm_ContrateME.qryConsulta2.FindField('CM_EMPVAGA_NOMEVG').AsString;

    TListItemText(vEmpresa.Objects.FindDrawable('txtDescricao')).Text := vNome;
    TListItemText(vEmpresa.Objects.FindDrawable('txtVaga')).Text := 'Nome Vaga';
    TListItemText(vEmpresa.Objects.FindDrawable('btnExcluir')).Text := 'X';

  end;
end;

end.
