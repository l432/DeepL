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

{$R *.dfm}


procedure TMainForm.BtCloseClick(Sender: TObject);
begin
 MainForm.Close;
end;

procedure TMainForm.BtDoneClick(Sender: TObject);
 const Izoom=1e-5;
 var Row:Int64;
     Task,FileNumber:word;
     Comments,SCparam,DatFile:TStringList;
     IlluminatedChar:boolean;
     T,V,I:double;
     tempStr,DatFileName,DatFileLocation,tempData:string;
     j: byte;
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
 SCparam.Add('T file kT1 Voc Jsc FF eta Vmpp Jmpp');
 DatFile:=TStringList.Create;

 Row:=0;
 Task:=0;
 FileNumber:=0;
 T:=300;
 IlluminatedChar:=False;

 repeat

  if AnsiStartsStr ('SCAPS', SCAPSFile[ROW]) then
   begin
     Task:=1;
     Inc(FileNumber);
     Inc(Row);
     Continue;
   end;

  if  ((Task=4)and
     (AnsiContainsStr(SCAPSFile[ROW],'Voc ='))) then
   begin
    tempData:='';
    for j := 0 to 5 do
     begin
      tempStr:=SCAPSFile[ROW];
      tempStr:=TwoSpaceToOne(tempStr);
      Delete(tempStr, 1, AnsiPos (' ', tempStr));
      Delete(tempStr, 1, AnsiPos (' ', tempStr));
      V:=StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
      case j of
       0:tempData:=tempData+FloatToStrF(T,ffGeneral,4,1)+' '+
         IntToStr(FileNumber)+'_'+IntToStr(Round(T))+' '+
         FloatToStrF(1/T/Kb,ffGeneral,5,2)+' ';
       1,5:V:=Izoom*V;
       2,3:V:=0.01*V;
       end;
      tempData:=tempData+FloatToStrF(V,ffExponent,4,0)+' ';
      Inc(ROW);
     end;
    SCparam.Add(tempData);
    Task:=5;
    Continue;
   end;

  if  ((Task=3)and
     (AnsiContainsStr(SCAPSFile[ROW],'v(V)'))and
     (AnsiContainsStr(SCAPSFile[ROW],'jtot(mA/cm2)'))) then
   begin
     ROW:=ROW+2;
     DatFile.Clear;
     V:=0;
     I:=0;
     while SCAPSFile[ROW]<>'' do
       begin
        tempStr:=SCAPSFile[ROW];
        tempStr:=TwoSpaceToOne(tempStr);
        if AnsiPos (' ', tempStr)=1 then
             Delete(tempStr, 1, 1);
        try
         V:=StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));
         I:=Izoom*StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
        except
        end;
        DatFile.Add((FloatToStrF(V,ffExponent,4,0)+' '+
                     FloatToStr(I)));
        Row:=ROW+1;
       end;

     DatFileName:=IntToStr(FileNumber)+'_'+IntToStr(Round(T))+'.dat';
     if FileNumber<10 then DatFileName:='0'+DatFileName;
     if IlluminatedChar then  DatFileName:='L'+DatFileName
                        else  DatFileName:='T'+DatFileName;
     DatFile.SaveToFile(DatFileLocation+DatFileName);
     Comments.Add(DatFileName);
     Comments.Add('T='+FloatToStrF(T,ffGeneral,4,1));
     Comments.Add('');
     Task:=4;
     Continue;
   end;

  if  (Task=2)and
     (AnsiStartsStr ('Temperature', SCAPSFile[ROW])) then
   begin
     tempStr:=SCAPSFile[ROW];
     tempStr:=TwoSpaceToOne(tempStr);

     Delete(tempStr, 1, AnsiPos (' ', tempStr));
     try
       T:=StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
       Task:=3;
     except

     end;
     Inc(Row);
     Continue;
   end;

  if  (Task=1)and
     (AnsiContainsStr (SCAPSFile[ROW],'in dark')or
      AnsiContainsStr (SCAPSFile[ROW],'under illumination')) then
   begin
     Task:=2;
     IlluminatedChar:=AnsiContainsStr (SCAPSFile[ROW],'under illumination');
     Inc(Row);
     Continue;
   end;


  Inc(Row);
 until (Row>=SCAPSFile.Count);


 if Comments.Count>0 then
      Comments.SaveToFile(DatFileLocation+'comments');
 Comments.Free;
 if SCparam.Count>1 then
      SCparam.SaveToFile(DatFileLocation+'SCparam.dat');
 SCparam.Free;
 DatFile.Free;

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
