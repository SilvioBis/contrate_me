unit uCadInfo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPadrao, FMX.TabControl, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  FMX.DateTimeCtrls, FMX.Objects, FMX.ListBox, System.Rtti, FMX.Grid.Style,
  FMX.Memo.Types, FMX.Memo, FMX.ScrollBox, FMX.Grid,System.IniFiles,Windows, uUsuario,
  FMX.Effects, FMX.Filter.Effects,Vcl.Graphics, Vcl.Imaging.jpeg,   Vcl.Imaging.pngimage,
  FMX.ImgList,FMX.MultiResBitmap, System.StrUtils;

type
  TfrmCadInfo = class(TfrmPadrao)
    tabForm: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    VertScrollBox: TVertScrollBox;
    Layout7: TLayout;
    Layout8: TLayout;
    Rectangle31: TRectangle;
    Rectangle32: TRectangle;
    edtTell: TEdit;
    btnCriar: TButton;
    Layout9: TLayout;
    Label17: TLabel;
    Image1: TImage;
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    cbxLinguagem: TComboBox;
    Label1: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    mmDescricao: TMemo;
    Label2: TLabel;
    btnAnexo: TButton;
    Edit3: TEdit;
    imgAdd: TImage;
    GRID: TStringGrid;
    lblPular: TLabel;
    OpenDialog1: TOpenDialog;
    CircleTransitionEffect1: TCircleTransitionEffect;
    Layout11: TLayout;
    imgFoto: TImage;
    Rectangle7: TRectangle;
    ltListaLinguagem: TStringColumn;
    VertScrollBox1: TVertScrollBox;
    Layout3: TLayout;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    CircleTransitionEffect2: TCircleTransitionEffect;
    Rectangle4: TRectangle;
    edtTelEmp: TEdit;
    Image2: TImage;
    btnCadastrarVaga: TButton;
    Layout5: TLayout;
    Label3: TLabel;
    Rectangle5: TRectangle;
    Layout6: TLayout;
    Layout10: TLayout;
    imgEmpLingAdd: TImage;
    cbxLinguagemEmp: TComboBox;
    GRIDEMP: TStringGrid;
    StringColumn1: TStringColumn;
    Label4: TLabel;
    Rectangle6: TRectangle;
    mmEmpDescricao: TMemo;
    Label5: TLabel;
    btnAnexarVaga: TButton;
    Layout12: TLayout;
    Rectangle8: TRectangle;
    imgEmpresa: TImage;
    Edit4: TEdit;
    Label6: TLabel;
    Rectangle9: TRectangle;
    ckbTodos: TCheckBox;
    Layout13: TLayout;
    Rectangle10: TRectangle;
    CircleTransitionEffect3: TCircleTransitionEffect;
    edtNomeVaga: TEdit;
    edtEmailEmp: TEdit;
    edtEmailContato: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure imgAddClick(Sender: TObject);
    procedure lblPularMouseEnter(Sender: TObject);
    procedure lblPularMouseLeave(Sender: TObject);
    procedure btnCriarClick(Sender: TObject);
    procedure btnAnexoClick(Sender: TObject);
    procedure imgFotoClick(Sender: TObject);
    procedure imgEmpresaClick(Sender: TObject);
    procedure btnAnexarVagaClick(Sender: TObject);
    procedure btnCadastrarVagaClick(Sender: TObject);
    procedure imgEmpLingAddClick(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure lblPularClick(Sender: TObject);
  private
    vpPessoalPhoto : string;
    vpPessoalAnexo : string;
    vpEmpresaPhoto : string;
    vpEmpresaAnexo : string;
    vpUsuario : tUsuario;
    vpCodigo : integer;
    { Private declarations }
    Arquivo : TIniFile;
    procedure ajustartexto;
  public
    vpModoInerir : Boolean;
    procedure PreencherInformações(vCod : integer; vUsuario : TTipoCadastro);
    { Public declarations }
  end;

var
  frmCadInfo: TfrmCadInfo;

implementation

{$R *.fmx}

uses uFuncoes, uCarregandoStatic, uPrincipal, dmContrateME;

procedure TfrmCadInfo.ajustartexto;
var i, a : integer;
    vTexto : string;
begin
  inherited;
    a:= 0;
   for I := 0 to length(mmDescricao.text) do
   begin
     if a = 30 then
     begin
       vTexto := vTexto + #13;
     end;
     vtexto := Copy(mmDescricao.Text, i,i);
     inc(a);
   end;
end;

procedure TfrmCadInfo.btnAnexarVagaClick(Sender: TObject);
 var vDiretorioCurriculo, vDiretorio : string;
     vDiretorioUsuario, vDiretoriobkp : string;
begin
  inherited;

  vDiretorio := GetCurrentDir + '\Config.ini';

  Arquivo := TIniFile.Create(vDiretorio);
  vDiretorioCurriculo := Arquivo.ReadString('PARAMETRO', 'SERVIDORVAGA', '');
  if not DirectoryExists(vDiretorioCurriculo) then
    MSG('Precisa Configurar o servidor de vagas. Chame o suporte!',2,2);

  vDiretorioUsuario := FormatFloat('00000000000', tID);

  vDiretorioCurriculo := vDiretorioCurriculo + '\' + vDiretorioUsuario + '\';
  vDiretoriobkp       :=  vDiretorioCurriculo + '\bkp';
  vpPessoalAnexo      := '';

  if btnAnexarVaga.StyleLookup = 'btnVermelhhoo' then
  begin
    if not DirectoryExists(vDiretoriobkp) then
         ForceDirectories(vDiretoriobkp);
    MoveFile(pchar(vDiretorioCurriculo + '\' + FormatDateTime('YYYYMMDDMMHHSS', NOW) + '\' + ExtractFileName(OpenDialog1.FileName)) ,pchar(vDiretoriobkp + '\' + FormatDateTime('YYYYMMDDMMHHSS', NOW) + ExtractFileExt(OpenDialog1.FileName) ));

    vpEmpresaAnexo       := vDiretoriobkp + '\' + FormatDateTime('YYYYMMDDMMHHSS', NOW) + ExtractFileExt(OpenDialog1.FileName);
    btnAnexarVaga.StyleLookup := 'btnVerde';
    btnAnexarVaga.Text        := 'Anexar minha Vaga';
  end
  else
  begin
    if OpenDialog1.Execute then
    begin
       if not DirectoryExists(vDiretorioCurriculo) then
         ForceDirectories(vDiretorioCurriculo);

       CopyFile( pchar(OpenDialog1.FileName) , pchar(vDiretorioCurriculo + '\' + FormatDateTime('YYYYMMDDMMHHSS', NOW) + '\' + ExtractFileName(OpenDialog1.FileName)),true);
       vpEmpresaAnexo :=vDiretorioCurriculo + '\' + FormatDateTime('YYYYMMDDMMHHSS', NOW) + '\' + ExtractFileName(OpenDialog1.FileName);
       btnAnexarVaga.StyleLookup := 'btnVermelhhoo';
       btnAnexarVaga.Text := 'Excluir Vaga';
    end;
  end;
end;

procedure TfrmCadInfo.btnAnexoClick(Sender: TObject);
 var vDiretorioCurriculo, vDiretorio : string;
     vDiretorioUsuario, vDiretoriobkp : string;
begin
  inherited;

  vDiretorio := GetCurrentDir + '\Config.ini';

  Arquivo := TIniFile.Create(vDiretorio);
  vDiretorioCurriculo := Arquivo.ReadString('PARAMETRO', 'SERVIDORCURRICULO', '');
  if not DirectoryExists(vDiretorioCurriculo) then
    MSG('Precisa Configurar o servidor de curriculo. Chame o suporte!',2,2);

  vDiretorioUsuario := FormatFloat('00000000000', tID);

  vDiretorioCurriculo := vDiretorioCurriculo + '\' + vDiretorioUsuario + '\';
  vDiretoriobkp       :=  vDiretorioCurriculo + '\bkp';
  vpPessoalAnexo      := '';

  if btnAnexo.StyleLookup = 'btnVermelhhoo' then
  begin
    if not DirectoryExists(vDiretoriobkp) then
         ForceDirectories(vDiretoriobkp);
    MoveFile(pchar(vDiretorioCurriculo + '\' + ExtractFileName(OpenDialog1.FileName)) ,pchar(vDiretoriobkp + '\' + FormatDateTime('YYYYMMDDMMHHSS', NOW) + ExtractFileExt(OpenDialog1.FileName) ));

    vpPessoalAnexo       := vDiretoriobkp + '\' + FormatDateTime('YYYYMMDDMMHHSS', NOW) + ExtractFileExt(OpenDialog1.FileName);
    btnAnexo.StyleLookup := 'btnVerde';
    btnAnexo.Text        := 'Anexar meu Curriculo';
  end
  else
  begin
    if OpenDialog1.Execute then
    begin
       if not DirectoryExists(vDiretorioCurriculo) then
         ForceDirectories(vDiretorioCurriculo);

       CopyFile( pchar(OpenDialog1.FileName) , pchar(vDiretorioCurriculo + '\' + ExtractFileName(OpenDialog1.FileName)),true);
       vpPessoalAnexo :=vDiretorioCurriculo + '\' + ExtractFileName(OpenDialog1.FileName);
       btnAnexo.StyleLookup := 'btnVermelhhoo';
       btnAnexo.Text := 'Excluir Curriculo';
    end;
  end;
end;

procedure TfrmCadInfo.btnCadastrarVagaClick(Sender: TObject);
var i,vCodVaga : integer;
    vNomeLingGuagem : String;
begin
  inherited;

  try
    try
      dm_ContrateME.conexao.StartTransaction;

      dm_ContrateME.SQLExecutar.Close;
      dm_ContrateME.SQLExecutar.SQL.Text := ' INSERT INTO `contrateme`.`cm_empresavaga` '   +
                                            '              (`CM_EMPVAGA_EMAILCONTATO`, '+
                                            '               `CM_EMPVAGA_TELCONTATO`, '  +
                                            '               `CM_EMPVAGA_CODUSUARIO`, '  +
                                            '               `CM_EMPVAGA_ANEXO`, '       +
                                            '               `CM_EMPVAGA_PHOTO`, '       +
                                            '               `CM_EMPVAGA_NOMEVG`,'       +
                                            '               `CM_EMPVAGA_DESCRICAO`) '   +
                                            ' VALUES ('+ CampoSTR(edtEmailEmp.Text)     + ',  ' +
                                                         CampoSTR(edtTelEmp.Text)       + ',  ' +
                                                         CampoFloat(tID)                + ',  ' +
                                                         CampoSTR(StringReplace(vpEmpresaAnexo,'\','\\',[rfReplaceAll]))       + ',  ' +
                                                         CampoSTR(StringReplace(vpEmpresaPhoto,'\','\\',[rfReplaceAll]))       + ',  ' +
                                                         CampoSTR(edtNomeVaga.Text)     + ',  ' +
                                                         CampoSTR(mmEmpDescricao.Text)  + '); ' ;
      dm_ContrateME.SQLExecutar.ExecSQL;

      dm_ContrateME.qryConsulta2.close;
      dm_ContrateME.qryConsulta2.sql.text := 'SELECT LAST_INSERT_ID()AS CODIGO;';
      dm_ContrateME.qryConsulta2.Open;

      vCodVaga := dm_ContrateME.qryConsulta2.FindField('CODIGO').AsInteger;

      i := 0;

      while not(i > (GRIDEMP.RowCount -1)) do
      begin
        vNomeLingGuagem := GRIDEMP.Cells[0, i];

        dm_ContrateME.qryConsulta.Close;
        dm_ContrateME.qryConsulta.SQL.Text := ' SELECT * FROM cm_linguagens ' +
                                              ' WHERE CM_LINGUAGEM_LINGUAGEM LIKE  ''%' + vNomeLingGuagem + '%'' '  ;
        dm_ContrateME.qryConsulta.Open;

        if not dm_ContrateME.qryConsulta.IsEmpty then
        begin
          dm_ContrateME.SQLExecutar.Close;
          dm_ContrateME.SQLExecutar.SQL.Text := ' INSERT INTO cm_vagalinguagem ' +
                                                '	(CM_VAGALING_CODVAGA, CM_VAGALING_CODLINGUA) ' +
                                                ' VALUES ('+ CampoFloat(vCodVaga) +',' +
                                                             CampoFloat(dm_ContrateME.qryConsulta.FindField('CM_LINGUAGEM_CODIGO').AsInteger) + ')';
          dm_ContrateME.SQLExecutar.ExecSQL;
        end;
        inc(i);
      end;

       dm_ContrateME.SQLExecutar.Close;
      dm_ContrateME.SQLExecutar.SQL.Text := ' UPDATE cm_usuarios ' +
                                            ' SET ' +
                                            '	 CM_USUARIO_PRMLOGIN = ''N'' '+
                                            ' WHERE CM_USUARIO_COD = ' + CampoFloat(tID);
      dm_ContrateME.SQLExecutar.ExecSQL;


      dm_ContrateME.conexao.Commit;
    except
      on e:Exception do
      begin
         if dm_ContrateME.conexao.InTransaction then
            dm_ContrateME.conexao.Rollback;

         MSG('Erro ao inserir informações ' + e.Message,2,1);
      end;
    end;
  finally
    if not vpModoInerir then
    begin
      frmPrincipal := tfrmPrincipal.Create(Self);
      frmPrincipal.ShowModal;

      FreeMem(Pointer(frmPrincipal));
      frmPrincipal := nil;
      close;
    end
    else
    begin
      MSG('Vaga cadastrada com sucesso!',3,1);
      close;
    end;
  end;
end;

procedure TfrmCadInfo.btnCriarClick(Sender: TObject);
var i,vCodPessoa : integer;
    vNomeLingGuagem : String;
    vteste : string;
begin
  inherited;
   vteste := StringReplace(vpPessoalPhoto,'\','\\',[rfReplaceAll]);
  try
    try
      dm_ContrateME.conexao.StartTransaction;

      if vpCodigo = 0 then
      begin
        dm_ContrateME.SQLExecutar.Close;
        dm_ContrateME.SQLExecutar.SQL.Text := ' INSERT INTO `contrateme`.`cm_pessoal` '   +
                                              '              (`CM_PESSOAL_EMAILCONTATO`, '+
                                              '               `CM_PESSOAL_TELCONTATO`, '  +
                                              '               `CM_PESSOAL_CODUSUARIO`, '  +
                                              '               `CM_PESSOAL_ANEXO`, '       +
                                              '               `CM_PESSOAL_PHOTO`, '       +
                                              '               `CM_PESSOAL_EMAILTODOS`, '  +
                                              '               `CM_PESSOAL_DESCRICAO`) '   +
                                              ' VALUES ('+ CampoSTR(edtEmailContato.Text) + ',  ' +
                                                           CampoSTR(edtTell.Text)         + ',  ' +
                                                           CampoFloat(tID)                + ',  ' +
                                                           CampoSTR(StringReplace(vpPessoalAnexo,'\','\\',[rfReplaceAll]))       + ',  ' +
                                                           CampoSTR(StringReplace(vpPessoalPhoto,'\','\\',[rfReplaceAll]))       + ',  ' +
                                                           ifthen(ckbTodos.IsChecked, '''S''', '''N''' ) +', '+
                                                           CampoSTR(mmDescricao.Text)     + '); ' ;
        dm_ContrateME.SQLExecutar.ExecSQL;
      end
      else
      begin
         dm_ContrateME.SQLExecutar.Close;
        dm_ContrateME.SQLExecutar.SQL.Text := ' UPDATE `contrateme`.`cm_pessoal` ' +
                                              ' SET `CM_PESSOAL_EMAILCONTATO` = ' + CampoSTR(edtEmailContato.Text) +',' +
                                              ' `CM_PESSOAL_TELCONTATO` = ' + CampoSTR(edtTell.Text) +',' +
                                              ' `CM_PESSOAL_DESCRICAO` = ' + CampoSTR(mmDescricao.Text) +',' +
                                              ' `CM_PESSOAL_EMAILTODOS` = ' + ifthen(ckbTodos.IsChecked, '''S''', '''N''' ) + ', '+
                                              ' `CM_PESSOAL_ANEXO` = ' + CampoSTR(StringReplace(vpPessoalAnexo,'\','\\',[rfReplaceAll])) +',' +
                                              ' `CM_PESSOAL_PHOTO` = '+ CampoSTR(StringReplace(vpPessoalPhoto,'\','\\',[rfReplaceAll])) +
                                              ' WHERE `CM_PESSOAL_CODUSUARIO` = ' + CampoFloat(tID);
        dm_ContrateME.SQLExecutar.ExecSQL;

        dm_ContrateME.SQLExecutar.Close;
        dm_ContrateME.SQLExecutar.SQL.Text := ' DELETE FROM `contrateme`.`cm_pessoallinguagem` ' +
                                              ' WHERE CM_PESSLING_CODPESSOAL = '+ CampoFloat(tID);
        dm_ContrateME.SQLExecutar.ExecSQL;
      end;

      if vpCodigo = 0 then
      begin
        dm_ContrateME.qryConsulta2.close;
        dm_ContrateME.qryConsulta2.sql.text := 'SELECT LAST_INSERT_ID()AS CODIGO;';
        dm_ContrateME.qryConsulta2.Open;
        vCodPessoa := dm_ContrateME.qryConsulta2.FindField('CODIGO').AsInteger;
      end
      else
      begin
        dm_ContrateME.qryConsulta2.close;
        dm_ContrateME.qryConsulta2.sql.text := 'select * from cm_pessoal where CM_PESSOAL_CODUSUARIO = '+ CampoFloat(tID);
        dm_ContrateME.qryConsulta2.Open;

        vCodPessoa := dm_ContrateME.qryConsulta2.FindField('CM_PESSOAL_CODIGO').AsInteger;
      end;

      i := 0;

      while not(i > (GRID.RowCount -1)) do
      begin
        vNomeLingGuagem := GRID.Cells[0, i];

        dm_ContrateME.qryConsulta.Close;
        dm_ContrateME.qryConsulta.SQL.Text := ' SELECT * FROM cm_linguagens ' +
                                              ' WHERE CM_LINGUAGEM_LINGUAGEM LIKE  ''%' + vNomeLingGuagem + '%'' '  ;
        dm_ContrateME.qryConsulta.Open;

        if not dm_ContrateME.qryConsulta.IsEmpty then
        begin
          dm_ContrateME.SQLExecutar.Close;
          dm_ContrateME.SQLExecutar.SQL.Text := ' INSERT INTO cm_pessoallinguagem ' +
                                                '	(CM_PESSLING_CODPESSOAL, CM_PESSLING_CODLINGUA) ' +
                                                ' VALUES ('+ CampoFloat(vCodPessoa) +',' +
                                                             CampoFloat(dm_ContrateME.qryConsulta.FindField('CM_LINGUAGEM_CODIGO').AsInteger) + ')';
          dm_ContrateME.SQLExecutar.ExecSQL;
        end;
        inc(i);
      end;
      dm_ContrateME.SQLExecutar.Close;
      dm_ContrateME.SQLExecutar.SQL.Text := ' UPDATE cm_usuarios ' +
                                            ' SET ' +
                                            '	 CM_USUARIO_PRMLOGIN = ''N'' '+
                                            ' WHERE CM_USUARIO_COD = ' + CampoFloat(tID);
      dm_ContrateME.SQLExecutar.ExecSQL;

      dm_ContrateME.conexao.Commit;
      except
      on e:Exception do
      begin
         if dm_ContrateME.conexao.InTransaction then
            dm_ContrateME.conexao.Rollback;

         MSG('Erro ao inserir informações ' + e.Message,2,0);
      end;
    end;
  finally
    if vpCodigo = 0 then
    begin
      frmPrincipal := tfrmPrincipal.Create(Self);
      frmPrincipal.ShowModal;

      FreeMem(Pointer(frmPrincipal));
      frmPrincipal := nil;
      close;
    end
    else
    begin
      MSG('Conta alterada com sucesso!',3,1);
      close;
    end;
  end;
end;

procedure TfrmCadInfo.FormCreate(Sender: TObject);
begin
  inherited;
  vpModoInerir := false;
  lblPular.OnClick := nil;
  label6.OnClick := nil;
  frmCarregandoStatic := TfrmCarregandoStatic.Create(Self);
  frmCarregandoStatic.Show;
  PreencheComboBoxLinguagem(cbxLinguagem);
  PreencheComboBoxLinguagem(cbxLinguagemEmp);
  frmCarregandoStatic.Free;
  frmCarregandoStatic := Nil;
end;

procedure TfrmCadInfo.imgFotoClick(Sender: TObject);
 var vDiretorioCurriculo, vDiretorio,vDiretorioUsuario,vDiretoriobkp : string;
begin
  inherited;
  vDiretorio := GetCurrentDir + '\Config.ini';



  Arquivo := TIniFile.Create(vDiretorio);
  vDiretorioCurriculo := Arquivo.ReadString('PARAMETRO', 'SERVIDORCURRICULO', '');
  if not DirectoryExists(vDiretorioCurriculo) then
    MSG('Precisa Configurar o servidor de curriculo. Chame o suporte!',2,2);

  vDiretorioUsuario := FormatFloat('00000000000', tID);

  vDiretorioCurriculo := vDiretorioCurriculo + '\' + vDiretorioUsuario + '\Imagem\';
  vDiretoriobkp :=  vDiretorioCurriculo + '\bkpImg';

  if OpenDialog1.Execute then
  begin
     if not DirectoryExists(vDiretoriobkp) then
         ForceDirectories(vDiretoriobkp);

     if not DirectoryExists(vDiretorioCurriculo) then
         ForceDirectories(vDiretorioCurriculo);

     if (ExtractFileExt(OpenDialog1.FileName) = '.png')
     or (ExtractFileExt(OpenDialog1.FileName) = '.jpg')
     or (ExtractFileExt(OpenDialog1.FileName) = '.jpeg') then
     begin
       try
         CopyFile( pchar(OpenDialog1.FileName) , pchar(vDiretorioCurriculo + 'photo'+ExtractFileExt(OpenDialog1.FileName)),false);

         vpPessoalPhoto := vDiretorioCurriculo + 'photo'+ExtractFileExt(OpenDialog1.FileName);
         imgFoto.MultiResBitmap[0].Bitmap.LoadFromFile(OpenDialog1.FileName);
       finally

       end;
     end;
  end;
end;

procedure TfrmCadInfo.Label6Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmCadInfo.imgAddClick(Sender: TObject);
var i : integer;
begin
  inherited;
  if cbxLinguagem.ItemIndex = -1 then
  begin
    MSG('Defina uma Linguagem!');
    Abort;
  end;

  GRID.RowCount := GRID.RowCount +1;
  i := GRID.RowCount - 1;
  GRID.Cells[0, i] := cbxLinguagem.Items[cbxLinguagem.ItemIndex];
end;

procedure TfrmCadInfo.imgEmpLingAddClick(Sender: TObject);
var i : integer;
begin
  inherited;
  if cbxLinguagemEmp.ItemIndex = -1 then
  begin
    MSG('Defina uma Linguagem!');
    Abort;
  end;

  GRIDEMP.RowCount := GRIDEMP.RowCount +1;
  i := GRIDEMP.RowCount - 1;
  GRIDEMP.Cells[0, i] := cbxLinguagemEmp.Items[cbxLinguagemEmp.ItemIndex];
end;

procedure TfrmCadInfo.imgEmpresaClick(Sender: TObject);
 var vDiretorioCurriculo, vDiretorio,vDiretorioUsuario,vDiretoriobkp : string;
begin
  inherited;
  vDiretorio := GetCurrentDir + '\Config.ini';

  Arquivo := TIniFile.Create(vDiretorio);
  vDiretorioCurriculo := Arquivo.ReadString('PARAMETRO', 'SERVIDORVAGA', '');
  if not DirectoryExists(vDiretorioCurriculo) then
    MSG('Precisa Configurar o servidor de curriculo. Chame o suporte!',2,2);

  vDiretorioUsuario := FormatFloat('00000000000', tID);

  vDiretorioCurriculo := vDiretorioCurriculo + '\' + vDiretorioUsuario + '\Imagem\';
  vDiretoriobkp :=  vDiretorioCurriculo + '\bkpImg';

  if OpenDialog1.Execute then
  begin
     if not DirectoryExists(vDiretoriobkp) then
         ForceDirectories(vDiretoriobkp);

     if not DirectoryExists(vDiretorioCurriculo) then
         ForceDirectories(vDiretorioCurriculo);

     if (ExtractFileExt(OpenDialog1.FileName) = '.png')
     or (ExtractFileExt(OpenDialog1.FileName) = '.jpg')
     or (ExtractFileExt(OpenDialog1.FileName) = '.jpeg') then
     begin
       try
         CopyFile( pchar(OpenDialog1.FileName) , pchar(vDiretorioCurriculo + FormatDateTime('YYYYMMDDMMHHSS', NOW) + ExtractFileExt(OpenDialog1.FileName)),false);

         vpEmpresaPhoto := vDiretorioCurriculo + FormatDateTime('YYYYMMDDMMHHSS', NOW) + ExtractFileExt(OpenDialog1.FileName);
         imgEmpresa.MultiResBitmap[0].Bitmap.LoadFromFile(OpenDialog1.FileName);
       finally

       end;
     end;
  end;
end;

procedure TfrmCadInfo.lblPularClick(Sender: TObject);
begin
  inherited;
  try
    try
      dm_ContrateME.SQLExecutar.Close;
      dm_ContrateME.SQLExecutar.SQL.Text := ' UPDATE cm_usuarios ' +
                                            ' SET ' +
                                            '	 CM_USUARIO_PRMLOGIN = ''N'' '+
                                            ' WHERE CM_USUARIO_COD = ' + CampoFloat(tID);
      dm_ContrateME.SQLExecutar.ExecSQL;
    except
      on e:Exception do
      begin
         if dm_ContrateME.conexao.InTransaction then
            dm_ContrateME.conexao.Rollback;

         MSG('Erro ao inserir informações ' + e.Message,2,1);
      end;
    end;
  finally
    frmPrincipal := tfrmPrincipal.Create(Self);
    frmPrincipal.ShowModal;

    frmPrincipal.Free;
    frmPrincipal := nil;
  end;
end;

procedure TfrmCadInfo.lblPularMouseEnter(Sender: TObject);
begin
  inherited;
  lblPular.TextSettings.FontColor := $FF0B16B1;
end;

procedure TfrmCadInfo.lblPularMouseLeave(Sender: TObject);
begin
  inherited;
  lblPular.TextSettings.FontColor := $FF000000;
end;

procedure TfrmCadInfo.PreencherInformações(vCod: integer; vUsuario: TTipoCadastro);
var i : integer;
begin
  I:=0;
  if (vUsuario = tPessoa) then
  begin
    tabForm.TabIndex := 0;

    dm_ContrateME.qryConsulta3.Close;
    dm_ContrateME.qryConsulta3.SQL.Text := ' SELECT * FROM cm_pessoal P ' +
                                           ' WHERE (P.CM_PESSOAL_CODUSUARIO = '+CampoFloat(vcod)+') ' +
                                           ' ORDER BY 1 DESC ' +
                                           ' LIMIT 1';
    dm_ContrateME.qryConsulta3.Open;

    vpCodigo := VCOD;
    edtEmailContato.Text := dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_EMAILCONTATO').AsString;
    edtTell.Text:= dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_TELCONTATO').AsString;
    mmDescricao.Text := dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_DESCRICAO').AsString;
    imgFoto.MultiResBitmap[0].Bitmap.LoadFromFile(dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_PHOTO').AsString);
    vpPessoalPhoto := dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_PHOTO').AsString;
    vpPessoalAnexo := dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_ANEXO').AsString;

    if not (TRim(dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_ANEXO').AsString) = '') then
    begin
      btnAnexo.StyleLookup := 'btnVermelhhoo';
      btnAnexo.Text := 'Excluir Curriculo';
    end;


    dm_ContrateME.qryConsulta4.Close;
    dm_ContrateME.qryConsulta4.SQL.Text := ' SELECT L.* FROM contrateme.cm_pessoallinguagem ' +
                                           ' LEFT JOIN contrateme.cm_linguagens L ON(L.CM_LINGUAGEM_CODIGO = CM_PESSLING_CODLINGUA) ' +
                                           ' WHERE CM_PESSLING_CODPESSOAL = ' + dm_ContrateME.qryConsulta3.FindField('CM_PESSOAL_CODIGO').AsString;;
    dm_ContrateME.qryConsulta4.Open;
    if not dm_ContrateME.qryConsulta4.IsEmpty then
    begin
      while not dm_ContrateME.qryConsulta4.Eof do
      begin
        GRID.RowCount := GRID.RowCount +1;
        i := GRID.RowCount - 1;
        GRID.Cells[0, i] := dm_ContrateME.qryConsulta4.FindField('CM_LINGUAGEM_LINGUAGEM').AsString;

        dm_ContrateME.qryConsulta4.Next;
      end;
    end;
  end;


end;

end.
