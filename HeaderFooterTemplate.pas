unit HeaderFooterTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.Bind.Components, Data.Bind.DBScope,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects,
  FMX.MultiView,
  System.IOUtils, FMX.ListBox, FMX.ScrollBox, FMX.Memo;

type
  THeaderFooterForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    TabControl1: TTabControl;
    TabItem2: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Button1: TButton;
    Button2: TButton;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    EditPas: TEdit;
    Label1: TLabel;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Label2: TLabel;
    EditLog: TEdit;
    TabItem1: TTabItem;
    TabItem3: TTabItem;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    Layout15: TLayout;
    Button3: TButton;
    Layout16: TLayout;
    Layout17: TLayout;
    Layout18: TLayout;
    Layout19: TLayout;
    Label3: TLabel;
    RegName: TEdit;
    Layout20: TLayout;
    RegEmail: TEdit;
    Label4: TLabel;
    Layout21: TLayout;
    RegPassword: TEdit;
    Label5: TLabel;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    Return: TSpeedButton;
    MultiView1: TMultiView;
    Rectangle1: TRectangle;
    Layout22: TLayout;
    List: TSpeedButton;
    Rectangle2: TRectangle;
    Label6: TLabel;
    Line2: TLine;
    Label7: TLabel;
    SpeedButton7: TSpeedButton;
    AEmail: TLabel;
    AName: TLabel;
    ListBox1: TListBox;
    TabItem4: TTabItem;
    Layout23: TLayout;
    Image1: TImage;
    Layout24: TLayout;
    ReturnFromFilms: TSpeedButton;
    Layout25: TLayout;
    Year: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Memo1: TMemo;
    Label14: TLabel;
    Label15: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ReturnClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure ListBox1Change(Sender: TObject);
    procedure ReturnFromFilmsClick(Sender: TObject);
  private
  public
    { Public declarations }
  end;

{$IFDEF AUTOREFCOUNT}

type
  TIntegerWrapper = class
  public
    Value: Integer;
    constructor Create(AValue: Integer);
  end;

var
  HeaderFooterForm: THeaderFooterForm;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

constructor TIntegerWrapper.Create(AValue: Integer);
begin
  Value := AValue;
end;
{$ENDIF}

procedure THeaderFooterForm.Button1Click(Sender: TObject);
var
  login, password, name, s: string;
  id: Integer;
begin
  ListBox1.Clear;
  FDConnection1.Connected := true;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('Select id_film, Name_film from films');
  FDQuery1.Active := true;
  while not FDQuery1.Eof do
  begin
    ListBox1.ItemHeight := 60;
    s := '    ' + FDQuery1.Fields[1].asString;
    id := FDQuery1.Fields[0].AsInteger;
    ListBox1.Items.AddObject(s, TIntegerWrapper.Create(id));
    FDQuery1.Next;
  end;
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('Select user_email, user_password, user_name from users');
  FDQuery1.Active := true;
  while not FDQuery1.Eof do
  begin
    login := FDQuery1.Fields[0].asString;
    password := FDQuery1.Fields[1].asString;
    name := FDQuery1.FieldList[2].asString;
    if (EditLog.Text = login) and (EditPas.Text = password) then
    begin
      EditLog.Text := '';
      EditPas.Text := '';
      AName.Text := name;
      AEmail.Text := login;
      TabControl1.TabIndex := 2;
      Layout22.Visible := true;
      exit;
    end;
    FDQuery1.Next;
  end;
  showmessage('������ �����!');
  FDQuery1.Close;
end;

procedure THeaderFooterForm.Button2Click(Sender: TObject);
begin
  Return.Visible := true;
  EditLog.Text := '';
  EditPas.Text := '';
  TabControl1.TabIndex := 1;
end;

procedure THeaderFooterForm.Button3Click(Sender: TObject);
var
  email: string;
begin
  if RegName.Text = '' then
  begin
    showmessage('��� �� �������!');
    exit;
  end
  else if RegEmail.Text = '' then
  begin
    showmessage('����� �� �������!');
    exit;
  end
  else if RegPassword.Text = '' then
  begin
    showmessage('������ �� ������!');
    exit;
  end;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('Select user_email from users');
  FDQuery1.Active := true;
  while not FDQuery1.Eof do
  begin
    email := FDQuery1.Fields[0].asString;
    if RegEmail.Text = email then
    begin
      showmessage('������ ����� ��� ����������������!');
      exit;
    end;
    FDQuery1.Next;
  end;
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add
    ('Insert into users (user_name, user_email, user_password) values (:un, :ue, :up)');
  FDQuery1.ParamByName('un').Value := RegName.Text;
  FDQuery1.ParamByName('ue').Value := RegEmail.Text;
  FDQuery1.ParamByName('up').Value := RegPassword.Text;
  FDQuery1.ExecSQL;
  FDQuery1.Close;
  showmessage('������������ ���������������!');
  RegName.Text := '';
  RegEmail.Text := '';
  RegPassword.Text := '';
  TabControl1.TabIndex := 0;
  Return.Visible := false;
end;

procedure THeaderFooterForm.FDConnection1BeforeConnect(Sender: TObject);
begin
{$IFDEF ANDROID}
  FDConnection1.Params.Values['Database'] :=
    TPath.Combine(TPath.GetDocumentsPath, 'movie.db');
{$ENDIF}
end;

procedure THeaderFooterForm.ListBox1Change(Sender: TObject);
var
  id: Integer;
  BlobStream: TStream;
begin
  Layout22.Visible := false;
  Layout24.Visible := true;
  id := TIntegerWrapper(ListBox1.Items.Objects[ListBox1.ItemIndex]).Value;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add
    ('Select Year_of_publishing, Studio, Budget, Age_limit, Time_Film, Country, Film_description, Picture, genre_name, MN, N from films, genres, producers where films.id_genre = genres.id_genre and films.id_producer = producers.id_producer and id_film = '
    + inttostr(id));
  FDQuery1.Active := true;
  Label8.Text := Label8.Text + '      ' + FDQuery1.Fields[0].asString;
  Label10.Text := Label10.Text + '      ' + FDQuery1.Fields[1].asString;
  Label11.Text := Label11.Text + '      ' + FDQuery1.Fields[2].asString + '$';
  Label12.Text := Label12.Text + '      ' + FDQuery1.Fields[3].asString;
  Label13.Text := Label13.Text + '      ' + FDQuery1.Fields[4].asString;
  Label9.Text := Label9.Text + '      ' + FDQuery1.Fields[5].asString;
  Label14.Text := Label14.Text + '      ' + FDQuery1.Fields[8].asString;
  Label15.Text := Label15.Text + '      ' + FDQuery1.Fields[9].asString + ' ' +
    FDQuery1.Fields[10].asString;
  Memo1.Lines.Add(FDQuery1.Fields[6].asString);
  BlobStream := FDQuery1.CreateBlobStream(FDQuery1.Fields[7], bmRead);
  Image1.Bitmap.LoadFromStream(BlobStream);
  BlobStream.Free;
  FDQuery1.Close;
  TabControl1.TabIndex := 3;
end;

procedure THeaderFooterForm.ReturnClick(Sender: TObject);
begin
  Return.Visible := false;
  RegName.Text := '';
  RegEmail.Text := '';
  RegPassword.Text := '';
  TabControl1.TabIndex := 0;
end;

procedure THeaderFooterForm.ReturnFromFilmsClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Label8.Text := '���';
  Label10.Text := '������';
  Label11.Text := '������';
  Label12.Text := '�������';
  Label13.Text := '�����';
  Label9.Text := '������';
  Label14.Text := '����';
  Label15.Text := '��������';
  Layout24.Visible := false;
  Layout22.Visible := true;
  TabControl1.TabIndex := 2;
end;

procedure THeaderFooterForm.SpeedButton7Click(Sender: TObject);
begin
  Layout22.Visible := false;
  AName.Text := '';
  AEmail.Text := '';
  MultiView1.HideMaster;
  TabControl1.TabIndex := 0;
end;

end.
