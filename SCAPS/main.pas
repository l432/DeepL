unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, StrUtils,OlegFunction,OlegType;

type
  TMainForm = class(TForm)
    BtFileSelect: TButton;
    BtDone: TButton;
    LFile: TLabel;
    LAction: TLabel;
    OpenDialog1: TOpenDialog;
    BtClose: TButton;
    procedure BtFileSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtCloseClick(Sender: TObject);
    procedure BtDoneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Directory,FileName:string;
  SCAPSFile:TStringList;

implementation

uses
  IV_Class;

{$R *.dfm}


procedure TMainForm.BtCloseClick(Sender: TObject);
begin
 MainForm.Close;
end;

procedure TMainForm.BtDoneClick(Sender: TObject);
// const Izoom=1e-5;
 var Row:Int64;
//     Task,FileNumber:word;
     Comments,SCparam,DatFile:TStringList;
//     IlluminatedChar:boolean;
     V,I:double;
     tempStr,DatFileName,DatFileLocation:string;
     j: byte;
     IVparameter:TIVparameter;
begin

 if LFile.Font.Color<>clBlue then Exit;

 if not(SetCurrentDir(Directory)) then
   begin
    MessageDlg('Current directory is not exist', mtError,[mbOk],0);
    Exit;
   end;
 DatFileLocation:=AnsiReplaceStr (FileName, '.', '_');
 try
  MkDir(DatFileLocation);
 except

 end;
 DatFileLocation:=Directory+'\'+DatFileLocation+'\';


 DecimalSeparator:='.';
 Comments:=TStringList.Create;
 SCparam:=TStringList.Create;
 DatFile:=TStringList.Create;

 IVparameter:=TIVparameter.Create;
 IVparameter.ParameterTitleDetermination(SCAPSFile);


 if IVparameter.fName.Count>0 then
  begin
   SCparam.Add(IVparameter.Title);
   for j := 0 to IVparameter.fName.Count - 1 do
    if IVparameter.fUnit[j]<>''
     then Comments.Add(IVparameter.fName[j]+' - '+IVparameter.fUnit[j])
     else Comments.Add(IVparameter.fName[j]+' - '+IVparameter.fDescription[j]);
   Comments.Add('');
  end;



 Row:=0;
 while (Row<SCAPSFile.Count) do
  begin
   if AnsiStartsStr ('SCAPS', SCAPSFile[ROW]) then
    begin
      if Row<>0 then SCparam.Add(IVparameter.DataString);
      IVparameter.Empty;
      Inc(Row);
      Continue;
    end;

   IVparameter.ParameterDetermination(SCAPSFile[ROW]);

  if ((AnsiContainsStr(SCAPSFile[ROW],'v(V)'))and
      (AnsiContainsStr(SCAPSFile[ROW],'jtot(mA/cm2)'))) then
   begin
     ROW:=ROW+2;
     DatFile.Clear;
     while SCAPSFile[ROW]<>'' do
       begin
        SCAPSFile[ROW]:=SomeSpaceToOne(SCAPSFile[ROW]);
        tempStr:=SCAPSFile[ROW];
        if AnsiStartsStr(' ',tempStr) then Delete(tempStr, 1, 1);
        try
         V:=StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));
         I:=10*SampleArea*StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
        except
         V:=0;
         I:=0;
        end;
        DatFile.Add((FloatToStrF(V,ffExponent,4,0)+' '+
                     FloatToStr(I)));
        Row:=ROW+1;
       end;

     DatFileName:=IVparameter.FileName+'.dat';
     DatFile.SaveToFile(DatFileLocation+DatFileName);
     Comments.Add(DatFileName);
     Comments.Add('T='+FloatToStrF(IVparameter.fTemperatura,ffGeneral,4,1));
     Comments.Add('');
     Continue;
   end;

   Inc(Row);
  end;

 if Comments.Count>0 then
      Comments.SaveToFile(DatFileLocation+'comments');
 Comments.Free;
 if SCparam.Count>1 then
      SCparam.SaveToFile(DatFileLocation+'SCparam.dat');
 SCparam.Free;
 DatFile.Free;
   IVparameter.Free;

 LAction.Caption:='Extraction is done';
 LAction.Font.Color:=clGreen;
end;

procedure TMainForm.BtFileSelectClick(Sender: TObject);

begin
   if OpenDialog1.Execute()
     then
       begin
       Directory:=ExtractFilePath(OpenDialog1.FileName);
       FileName:=ExtractFileName(OpenDialog1.FileName);
       FileName:=copy(FileName,1,length(FileName)-3);
       LFile.Caption:=FileName;
       LFile.Font.Color:=clblue;
       BtDone.Enabled:=True;
       LAction.Caption:='Not Yet';
       LAction.Font.Color:=clBlack;
       if FileExists(OpenDialog1.FileName) then
         begin
         SCAPSFile.Clear;
         SCAPSFile.LoadFromFile(OpenDialog1.FileName);
//         showmessage(inttostr(SCAPSFile.Count));
         end;
       end;
end;


procedure TMainForm.FormCreate(Sender: TObject);
begin
  SCAPSFile:=TStringList.Create;
  SCAPSFile.Sorted:=False;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SCAPSFile.Free;
end;

end.
