unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Ani,
  FMX.Edit, FMX.ListView.Types, FMX.ListView.Appearances, Data.DB,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Menus, System.ImageList,uUsuario ,
  FMX.ImgList,ShellAPI;

type
  TfrmPrincipal = class(TfrmPadrao)
    lytToolBar: TLayout;
    Image1: TImage;
    lblMenu: TLabel;
    lytPesquisa: TLayout;
    rectPesquisa: TRectangle;
    edtBusca: TEdit;
    Image3: TImage;
    btnBuscar: TButton;
    StyleBook1: TStyleBook;
    lvInformacoes: TListView;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
    mnuTeste: TMenuItem;
    SpeedButton1: TSpeedButton;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    mnuSair: TMenuItem;
    mnuAlterarCurriculo: TMenuItem;
    mnuCadastrarVaga: TMenuItem;
    Image2: TImage;
    Image4: TImage;
    mnuMinhasVagas: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnuSairClick(Sender: TObject);
    procedure lvInformacoesItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure mnuAlterarCurriculoClick(Sender: TObject);
    procedure mnuMinhasVagasClick(Sender: TObject);
    procedure mnuCadastrarVagaClick(Sender: TObject);
  private
    procedure ListarPessoas;
    procedure AddPessoaListView(vCodPessoa       : Integer;
                                vEmailContato    : String;
                                vTelefoneContato : String;
                                vCodUsuario      : integer;
                                vDescricao       : string;
                                vAnexo           : string;
                                vSequenca :Integer);

    procedure AddEmpresaListView(vCodPessoa       : Integer;
                                vEmailContato    : String;
                                vTelefoneContato : String;
                                vCodUsuario      : integer;
                                vDescricao       : string;
                                vAnexo           : string;
                                vSequenca :Integer);
   procedure AbrirArquivo(const CaminhoArquivo: string);
   procedure ListarEmpresa;
   procedure Candidatato(vCoVaga : Integer; vIdPessoa : Integer );
   function VerificaPessoalLiberado(var vEmailLib : boolean; vCodPessoa : integer) : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses dmContrateME, uCadInfo, uLogin, uFuncoes, uVagas;

procedure TfrmPrincipal.AddPessoaListView(vCodPessoa:Integer; vEmailContato: String; vTelefoneContato: String; vCodUsuario: integer;vDescricao: string;vAnexo: string; vSequenca :Integer);
var vPessoa : TListViewItem;
    vEmailLib, vVisualizar : Boolean;
begin
  vPessoa := lvInformacoes.items.add;

  with vPessoa do
  begin
    Height := 255;
    Tag    := vCodPessoa;

    if vSequenca <> 0 then
    begin
      Image1.MultiResBitmap.Add;
      image1.MultiResBitmap[vSequenca].Bitmap.LoadFromFile(dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_PHOTO').AsString);
    end
    else
    begin
      image1.MultiResBitmap[vSequenca].Bitmap.LoadFromFile(dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_PHOTO').AsString);
    end;

    dm_ContrateME.qryConsulta2.Close;
    dm_ContrateME.qryConsulta2.SQL.Text := ' SELECT U.* FROM CM_PESSOAL P ' +
                                           ' LEFT JOIN cm_usuarios U ON(U.CM_USUARIO_COD = P.CM_PESSOAL_CODUSUARIO) ' +
                                           ' WHERE P.CM_PESSOAL_CODIGO = ' + CampoFloat(vCodPessoa);
    dm_ContrateME.qryConsulta2.Open;
    if (Image1.MultiResBitmap[vSequenca] <> nil) then
    begin
      TListItemImage(vPessoa.Objects.FindDrawable('imgPhoto')).Bitmap := Image1.MultiResBitmap[vSequenca].Bitmap;
      TListItemImage(vPessoa.Objects.FindDrawable('imgPhoto')).OwnsBitmap := true;
    end;
    vVisualizar := VerificaPessoalLiberado(vEmailLib, vCodPessoa);
    TListItemText(vPessoa.Objects.FindDrawable('txtNome')).Text := dm_ContrateME.qryConsulta2.FindField('CM_USUARIO_NOME').AsString;

    if vEmailLib then
    begin
      TListItemText(vPessoa.Objects.FindDrawable('txtEmailContato')).Text := vEmailContato;
      TListItemText(vPessoa.Objects.FindDrawable('txtTell')).Text := vTelefoneContato;
    end
    else
    begin
      TListItemText(vPessoa.Objects.FindDrawable('txtEmailContato')).Text := 'Indisponivel no Momento';
      TListItemText(vPessoa.Objects.FindDrawable('txtTell')).Text := '';
    end;

    TListItemText(vPessoa.Objects.FindDrawable('txtDescricao')).Text := vDescricao;
    TListItemText(vPessoa.Objects.FindDrawable('txtResumo')).Text := ' Descrição:';

    if vVisualizar then
      TListItemImage(vPessoa.Objects.FindDrawable('imgBotao')).Bitmap := Image4.MultiResBitmap[0].Bitmap
    else
    begin
      Height := 205;
      vPessoa.Objects.FindDrawable('imgBotao').Visible := false;
    end;

    vPessoa.Objects.FindDrawable('imgCandidatar').Visible := FALSE;
    TListItemText(vPessoa.Objects.FindDrawable('txtAnexo')).Text := vAnexo;

  end;
end;

procedure TfrmPrincipal.Candidatato(vCoVaga, vIdPessoa: Integer);
var vCodPessoa : Integer;
begin
  try
     dm_ContrateME.qryConsulta4.Close;
     dm_ContrateME.qryConsulta4.sql.Text := 'SELECT * FROM cm_pessoal P WHERE P.CM_PESSOAL_CODUSUARIO = ' + CampoFloat(vIdPessoa);
     dm_ContrateME.qryConsulta4.Open;

     vCodPessoa := dm_ContrateME.qryConsulta4.FindField('CM_PESSOAL_CODIGO').AsInteger;

     dm_ContrateME.conexao.StartTransaction;
     dm_ContrateME.SQLExecutar.Close;
     dm_ContrateME.SQLExecutar.SQL.Text := ' INSERT INTO cm_pessoalvaga ' +
                                           '	(CM_PESSVAGA_CODVAGA, CM_PESSVAGA_CODPESSOA) ' +
                                           '	VALUES (' +CampoFloat(vCoVaga) + ',' +CampoFloat(vCodPessoa)+')';
     dm_ContrateME.SQLExecutar.ExecSQL;
     dm_ContrateME.conexao.Commit;
     MSG('Enviado com sucesso!');
  except
    on e:Exception do
    begin
      if dm_ContrateME.conexao.InTransaction then
        dm_ContrateME.conexao.Rollback;
      msg('Informações incorretas confira.',2,2);
    end;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  lblMenu.TextSettings.FontColor := $FF0F1020;
  if vpTipoConta = tEmpresa then
  begin
    ListarPessoas;
    lblMenu.Text := 'CANDIDATOS';
    mnuSair.Visible := true;
    mnuAlterarCurriculo.Visible := false;
    mnuCadastrarVaga.Visible := true;
    mnuMinhasVagas.Visible := true;
  end
  else
  begin
    ListarEmpresa;
    lblMenu.Text := 'VAGAS';

    mnuSair.Visible := true;
    mnuAlterarCurriculo.Visible := true;
    mnuCadastrarVaga.Visible := false;
    mnuMinhasVagas.Visible := false;
  end;
end;

procedure TfrmPrincipal.ListarPessoas;
var i : Integer;
    foto: TBitmap;
    foto_stream: TStream;
begin
  i := 0;
  lvInformacoes.BeginUpdate;
  lvInformacoes.Items.Clear;

  with dm_ContrateME.qryPessoas do
  begin
    dm_ContrateME.qryPessoas.Close;
    dm_ContrateME.qryPessoas.SQL.Text := ' SELECT distinct t.CM_PESSOAL_CODIGO, t.CM_PESSOAL_EMAILCONTATO, t.CM_PESSOAL_TELCONTATO,' +
                                         ' t.CM_PESSOAL_CODUSUARIO, t.CM_PESSOAL_DESCRICAO, t.CM_PESSOAL_ANEXO, t.CM_PESSOAL_PHOTO, NRO ' +
                                         ' FROM ( ' +
                                         ' SELECT DISTINCT P.*, CAST(1 AS INTEGER) ORDEM, CAST(0 AS INTEGER) NRO FROM cm_pessoallinguagem PL ' +
                                         ' INNER JOIN cm_vagalinguagem VL ON(VL.CM_VAGALING_CODLINGUA = PL.CM_PESSLING_CODLINGUA) ' +
                                         ' LEFT JOIN cm_empresavaga EV ON(EV.CM_EMPVAGA_CODIGO = VL.CM_VAGALING_CODVAGA) ' +
                                         ' LEFT JOIN cm_pessoal P ON(P.CM_PESSOAL_CODIGO = PL.CM_PESSLING_CODPESSOAL) ' +
                                         ' WHERE (EV.CM_EMPVAGA_CODUSUARIO = ' + CampoFloat(tID) + ') AND (EV.CM_EMPVAGA_CODUSUARIO <> 1) ' +

                                         ' UNION ALL ' +

                                         ' SELECT *, CAST(2 AS INTEGER) ORDEM, CAST(0 AS INTEGER) NRO  FROM cm_pessoal P ' +
                                         ' WHERE (P.CM_PESSOAL_CODUSUARIO <> 1 )' +
                                         ' ORDER BY ORDEM ) t '+
                                         '  WHERE CM_PESSOAL_CODIGO IS NOT NULL';
    dm_ContrateME.qryPessoas.Open;
    if dm_ContrateME.qryPessoas.IsEmpty then
      Exit;

    while not eof do
    begin
      AddPessoaListView(dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_CODIGO').AsInteger,
                        dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_EMAILCONTATO').AsString,
                        dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_TELCONTATO').AsString,
                        dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_CODUSUARIO').AsInteger,
                        dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_DESCRICAO').AsString,
                        dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_ANEXO').AsString,
                        i);

      inc(i);
      Next;
    end;

  end;
  lvInformacoes.EndUpdate;
end;

procedure TfrmPrincipal.lvInformacoesItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);

var vInfo : TListViewItem;
begin
  if vpTipoConta = tEmpresa then
  begin
    dm_ContrateME.qryPessoas.Locate('CM_PESSOAL_CODIGO',lvInformacoes.items[ItemIndex].Tag,[]);
    if ItemObject.Name = 'imgBotao' then
    begin
      AbrirArquivo(dm_ContrateME.qryPessoas.FindField('CM_PESSOAL_ANEXO').AsString);
    end;
  end
  else
  begin
    dm_ContrateME.qryEmpresa.Locate('CM_EMPVAGA_CODIGO',lvInformacoes.items[ItemIndex].Tag,[]);

    if ItemObject.Name = 'imgBotao' then
    begin
      AbrirArquivo(dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_ANEXO').AsString);
    end
    else if ItemObject.Name = 'imgCandidatar' then
    begin
      Candidatato(lvInformacoes.items[ItemIndex].Tag, tID);
    end;

  end;
end;

procedure TfrmPrincipal.mnuSairClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmPrincipal.mnuAlterarCurriculoClick(Sender: TObject);
VAR vfrmCadInfo : TfrmCadInfo;
begin
  inherited;
  vfrmCadInfo := TfrmCadInfo.Create(Self);
  vfrmCadInfo.lblPular.OnClick := vfrmCadInfo.Label6Click;
  vfrmCadInfo.lblPular.Text := 'Voltar';
  vfrmCadInfo.tabForm.TabIndex := 0;
  vfrmCadInfo.lblPular.Visible := false;
  vfrmCadInfo.Layout9.Visible := false;
  vfrmCadInfo.Label1.Position.y := 254;
  vfrmCadInfo.Label2.Position.Y := 460;
  vfrmCadInfo.Edit3.Position.Y  := 860;
  vfrmCadInfo.btnCriar.Text := 'Alterar Conta';
  vfrmCadInfo.PreencherInformações(tID, vpTipoConta);
  vfrmCadInfo.ShowModal;

  vfrmCadInfo.Free;
  vfrmCadInfo := nil;
end;

procedure TfrmPrincipal.mnuCadastrarVagaClick(Sender: TObject);
VAR vfrmCadInfo : TfrmCadInfo;
begin
  inherited;
  vfrmCadInfo := TfrmCadInfo.Create(Self);
  vfrmCadInfo.label6.OnClick := vfrmCadInfo.Label6Click;
  vfrmCadInfo.label6.Text := 'Voltar';
  vfrmCadInfo.tabForm.TabIndex := 1;
  vfrmCadInfo.vpModoInerir := true;
  vfrmCadInfo.ShowModal;

  vfrmCadInfo.Free;
  vfrmCadInfo := nil;
end;

procedure TfrmPrincipal.mnuMinhasVagasClick(Sender: TObject);
var vfrmVagas : TfrmVagas;
begin
  inherited;
  if vpTipoConta = tEmpresa then
  begin
    vfrmVagas := TfrmVagas.Create(Self);
    vfrmVagas.ShowModal;

  end;
end;

function TfrmPrincipal.VerificaPessoalLiberado(var vEmailLib: boolean; vCodPessoa : integer): boolean;
begin
   dm_ContrateME.qryConsulta4.Close;
   dm_ContrateME.qryConsulta4.SQL.Text := ' SELECT U.* FROM cm_pessoalvaga PV ' +
                                          ' INNER JOIN cm_empresavaga EV ON(PV.CM_PESSVAGA_CODVAGA = EV.CM_EMPVAGA_CODIGO) ' +
                                          ' INNER JOIN cm_usuarios U ON (EV.CM_EMPVAGA_CODUSUARIO = U.CM_USUARIO_COD) ' +
                                          ' WHERE PV.CM_PESSVAGA_CODPESSOA = ' + CampoFloat(vCodPessoa) +
                                          ' AND U.CM_USUARIO_COD = ' + CampoFloat(tID);
   dm_ContrateME.qryConsulta4.Open;

   if not dm_ContrateME.qryConsulta4.IsEmpty then
   begin
     vEmailLib := true;
     Result := true;
   end
   else
   begin
     Result := false;

     dm_ContrateME.qryConsulta3.Close;
     dm_ContrateME.qryConsulta3.SQL.Text := 'SELECT * FROM cm_pessoal P WHERE P.CM_PESSOAL_CODIGO = ' + CampoFloat(vCodPessoa);
     dm_ContrateME.qryConsulta3.Open;

     if (trim(dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_EMAILTODOS').AsString) = 'S') then
       vEmailLib:= true
     else
        vEmailLib := false;
   end;
end;

procedure TfrmPrincipal.AbrirArquivo(const CaminhoArquivo: string);
begin
  ShellExecute(0, 'open', PChar(CaminhoArquivo), nil, nil, 1);
end;

procedure TfrmPrincipal.ListarEmpresa;
var i : Integer;
    foto: TBitmap;
    foto_stream: TStream;
begin
  i := 0;
  lvInformacoes.BeginUpdate;
  lvInformacoes.Items.Clear;

  with dm_ContrateME.qryEmpresa do
  begin
    dm_ContrateME.qryEmpresa.Close;
    dm_ContrateME.qryEmpresa.SQL.Text :=  ' SELECT distinct CM_EMPVAGA_CODIGO, CM_EMPVAGA_EMAILCONTATO, CM_EMPVAGA_TELCONTATO, ' +
                                          ' CM_EMPVAGA_CODUSUARIO, CM_EMPVAGA_DESCRICAO, CM_EMPVAGA_ANEXO, CM_EMPVAGA_PHOTO, NRO ' +
                                          ' FROM ( ' +
                                          ' SELECT DISTINCT EV.*,CAST(1 AS INTEGER) ORDEM, CAST(0 AS INTEGER) NRO ' +
                                          ' FROM cm_vagalinguagem VL ' +
                                          ' INNER JOIN cm_empresavaga EV ON(EV.CM_EMPVAGA_CODIGO = VL.CM_VAGALING_CODVAGA) ' +
                                          ' INNER JOIN cm_pessoallinguagem PL ON(PL.CM_PESSLING_CODLINGUA = VL.CM_VAGALING_CODLINGUA) ' +
                                          ' LEFT JOIN  cm_pessoal P ON (P.CM_PESSOAL_CODIGO = PL.CM_PESSLING_CODPESSOAL) ' +
                                          ' WHERE (P.CM_PESSOAL_CODUSUARIO = 3) ' +

                                          ' UNION ALL ' +

                                          ' SELECT *, CAST(2 AS INTEGER) ORDEM, CAST(0 AS INTEGER) NRO  FROM cm_empresavaga E ' +
                                          ' WHERE (E.CM_EMPVAGA_CODUSUARIO <> 1 ) ' +
                                          ' ORDER BY ORDEM ) t ';

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

procedure TfrmPrincipal.AddEmpresaListView(vCodPessoa:Integer; vEmailContato: String; vTelefoneContato: String; vCodUsuario: integer;vDescricao: string;vAnexo: string; vSequenca :Integer);
var vEmpresa : TListViewItem;
begin
  vEmpresa := lvInformacoes.items.add;

  with vEmpresa do
  begin
    Height := 300;
    Tag    := vCodPessoa;

    if vSequenca <> 0 then
    begin
      Image1.MultiResBitmap.Add;
      image1.MultiResBitmap[vSequenca].Bitmap.LoadFromFile(dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_PHOTO').AsString);
    end
    else
    begin
      image1.MultiResBitmap[vSequenca].Bitmap.LoadFromFile(dm_ContrateME.qryEmpresa.FindField('CM_EMPVAGA_PHOTO').AsString);
    end;

    dm_ContrateME.qryConsulta2.Close;
    dm_ContrateME.qryConsulta2.SQL.Text :=' SELECT U.* FROM cm_empresavaga EV ' +
                                          ' LEFT JOIN cm_usuarios U ON(U.CM_USUARIO_COD = EV.CM_EMPVAGA_CODUSUARIO) ' +
                                          ' WHERE EV.CM_EMPVAGA_CODIGO = ' + CampoFloat(vCodPessoa);
    dm_ContrateME.qryConsulta2.Open;
    if (Image1.MultiResBitmap[vSequenca] <> nil) then
    begin
      TListItemImage(vEmpresa.Objects.FindDrawable('imgPhoto')).Bitmap := Image1.MultiResBitmap[vSequenca].Bitmap;
      TListItemImage(vEmpresa.Objects.FindDrawable('imgPhoto')).OwnsBitmap := true;
    end;
    TListItemText(vEmpresa.Objects.FindDrawable('txtNome')).Text := dm_ContrateME.qryConsulta2.FindField('CM_USUARIO_NOME').AsString;
    TListItemText(vEmpresa.Objects.FindDrawable('txtEmailContato')).Text := vEmailContato;
    TListItemText(vEmpresa.Objects.FindDrawable('txtTell')).Text := vTelefoneContato;
    TListItemText(vEmpresa.Objects.FindDrawable('txtDescricao')).Text := vDescricao;
    TListItemText(vEmpresa.Objects.FindDrawable('txtResumo')).Text := ' Descrição:';
    TListItemImage(vEmpresa.Objects.FindDrawable('imgBotao')).Bitmap := Image4.MultiResBitmap[0].Bitmap;
    TListItemImage(vEmpresa.Objects.FindDrawable('imgCandidatar')).Bitmap := Image4.MultiResBitmap[1].Bitmap;
    TListItemText(vEmpresa.Objects.FindDrawable('txtAnexo')).Text := vAnexo;

  end;
end;

end.
