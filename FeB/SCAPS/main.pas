unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, StrUtils,OlegFunction,OlegType,OlegShowTypes, 
  IniFiles,OlegMaterialSamples,Math,SomeFunction, OlegVector, OlegDefectsSi, 
  IV_Class, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    BtFileSelect: TButton;
    LFile: TLabel;
    OpenDialog1: TOpenDialog;
    BtClose: TButton;
    GBTemp: TGroupBox;
    LTemp_start: TLabel;
    STTemp_start: TStaticText;
    STTemp_Finish: TStaticText;
    LTemp_Finish: TLabel;
    STTemp_Step: TStaticText;
    LTemp_Step: TLabel;
    GBBoron: TGroupBox;
    STBoron: TStaticText;
    BDatesDat: TButton;
    BFeB_x: TButton;
    GBFerum: TGroupBox;
    LFe_Lo: TLabel;
    LFe_Hi: TLabel;
    LFe_steps: TLabel;
    STFe_Lo: TStaticText;
    STFe_Hi: TStaticText;
    STFe_steps: TStaticText;
    BDatesDatCorrect: TButton;
    GBFinal: TGroupBox;
    BResult: TButton;
    LBase_Conc: TLabel;
    LBase_Thick: TLabel;
    STBase_Thick: TStaticText;
    GBBSF: TGroupBox;
    LSBF_Conc: TLabel;
    LSBF_Thick: TLabel;
    STSBF_Con: TStaticText;
    STSBF_Thick: TStaticText;
    GBEmiter: TGroupBox;
    LEmiter_Conc: TLabel;
    LEmiter_Thick: TLabel;
    STEmiter_Con: TStaticText;
    STEmiter_Thick: TStaticText;
    BScapsFileCreate: TButton;
    GBFolderSelect: TGroupBox;
    ST_SCAPSF: TStaticText;
    B_SCAPSFSelect: TButton;
    L_SCAPSF: TLabel;
    ST_ResF: TStaticText;
    L_ResF: TLabel;
    B_ResFSelect: TButton;
    OpenDialog2: TOpenDialog;
    BAllDatesDat: TButton;
    RGIllumination: TRadioGroup;
    procedure BtFileSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtCloseClick(Sender: TObject);
    procedure BDatesDatClick(Sender: TObject);
    procedure BFeB_xClick(Sender: TObject);
    procedure BDatesDatCorrectClick(Sender: TObject);
    procedure BResultClick(Sender: TObject);
    procedure BScapsFileCreateClick(Sender: TObject);
    procedure B_SCAPSFSelectClick(Sender: TObject);
    procedure B_ResFSelectClick(Sender: TObject);
    procedure BAllDatesDatClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    TempStart,TempFinish,TempStep: TIntegerParameterShow;
    FeLow,FeHi:TDoubleParameterShow;
    FeStepNumber: TIntegerParameterShow;
    Boron,EmiterCon,BSFCon:TDoubleParameterShow;
    BaseThick:TIntegerParameterShow;
    EmiterThick,BSFThick:TDoubleParameterShow;

    ConfigFile:TIniFile;
    SCAPS_Folder,Result_Folder:string;
    IVparameter:TIVparameter;
    Procedure FoldersToForm();
    {��������� �� ����� ����������� ���������}    
//    Direc:string;
    function NBoronToString():string;
//    function NumberToString(Number:double;DigitNumber:word=4):string;
//    function EditString(str:string):string;
    function BaseThickToString():string;
    function Nfeb(Nb,T,Ef:double):double;
    {��������� ������ ��� FeB �� ��������� �� ��������
    ������� Fe,
    Nb - ������������ ����, []=��-3
    � - �����������
    Ef - ��������� ���� ���� ������� �������� ����}
    procedure StringReplaceMy(StringList:TStringList; Str:string; IndexOfString:integer);
    function PartOfFileNameCreate(T:integer):string;
    procedure SetCurrentFolders;
    procedure SetTemperatureFolders(T: Integer);
    procedure AdDataFromDatesDat(FullFilename:string);
    function SearchInFolders(StartFolder:string):string;
    function DatFileLocationCreateAndDetermine(InnerDir, Tdir, Ddir, Bdir: string):string;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Directory,FileName:string;
  SCAPSFile:TStringList;

implementation

uses
  ResultAll;

{$R *.dfm}


procedure TMainForm.BtCloseClick(Sender: TObject);
begin
 MainForm.Close;
end;

//procedure TMainForm.BtDoneClick(Sender: TObject);
// var Row:Int64;
//     Comments,SCparam,DatFile,DatFile_srh:TStringList;
//     V,I,I_srh,d,Na:double;
//     tempStr,DatFileName,DatFileLocation,DatFileLocation2,
//     Tdir,Ddir,Bdir,tempStr2:string;
//     j: byte;
////     IVparameter:TIVparameter;
//begin
//
// if LFile.Font.Color<>clBlue then Exit;
//
// if not(SetCurrentDir(Directory)) then
//   begin
//    MessageDlg('Current directory is not exist', mtError,[mbOk],0);
//    Exit;
//   end;
// DatFileLocation:=AnsiReplaceStr (FileName, '.', '_');
// DatFileLocation2:=DatFileLocation;
//
//// CreateDirSafety(DatFileLocation);
//
// DatFileLocation:=Directory+'\'+DatFileLocation+'\';
//
// FormatSettings.DecimalSeparator:='.';
//// DecimalSeparator:='.';
// Comments:=TStringList.Create;
// SCparam:=TStringList.Create;
// DatFile:=TStringList.Create;
// DatFile_srh:=TStringList.Create;
//
// IVparameter.Clear;
// IVparameter.ParameterTitleDetermination(SCAPSFile);
//
//
// if IVparameter.fName.Count>0 then
//  begin
//   SCparam.Add(IVparameter.Title);
//   StringReplaceMy(SCparam,SCparam[SCparam.Count-1]+' d N_B',
//                   SCparam.Count-1);
//   for j := 0 to IVparameter.fName.Count - 1 do
//    if IVparameter.fUnit[j]<>''
//     then Comments.Add(IVparameter.fName[j]+' - '+IVparameter.fUnit[j])
//     else Comments.Add(IVparameter.fName[j]+' - '+IVparameter.fDescription[j]);
//   Comments.Add('');
//  end;
//
//  IVparameter.SCAPSFileNameDetermination(SCAPSFile);
//  if AnsiPos('FeB',IVparameter.fSCAPSFileName)>0
//    then  tempStr2:='FeB'
//    else  tempStr2:='Fe';
//  IVparameter.fSCAPSFileName:= StringReplace(IVparameter.fSCAPSFileName,
//            'FeB', 'Fe',[rfIgnoreCase]);
//  Tdir:='';
//  Ddir:='';
//  Bdir:='';
//  Tdir:=Copy(IVparameter.fSCAPSFileName,
//                AnsiPos('T',IVparameter.fSCAPSFileName),4);
//  Ddir:=Copy(IVparameter.fSCAPSFileName,
//                AnsiPos('D',IVparameter.fSCAPSFileName),3);
//  tempstr:=Ddir;
//  Delete(tempstr, 1, 1);
//  tempstr:=tempstr+'0';
//  d:=strtoint(tempstr)*1e-6;
//  Bdir:=Copy(IVparameter.fSCAPSFileName,
//                AnsiPos('B',IVparameter.fSCAPSFileName),9);
//  tempstr:=Bdir;
//  Delete(tempstr, 1, 1);
//  tempstr:=AnsiReplaceStr(tempstr,'p','.');
//  Na:=StrToFloat(tempStr);
//
//  if  (Tdir<>'')and(Ddir<>'')and(Bdir<>'')
//      and SetCurrentDir(Result_Folder)   then
//    begin
//     tempSTR:=Result_Folder;
//     while not(SetCurrentDir(tempSTR+'\'+Ddir)) do
//        MkDir(Ddir);
//     tempStr:=tempStr+'\'+Ddir;
//     while not(SetCurrentDir(tempSTR+'\'+Bdir)) do
//        MkDir(Bdir);
//     tempStr:=tempStr+'\'+Bdir;
//     while not(SetCurrentDir(tempSTR+'\'+Tdir)) do
//        MkDir(Tdir);
//     tempStr:=tempStr+'\'+Tdir;
//     while not(SetCurrentDir(tempSTR+'\iv')) do
//        MkDir('iv');
//     tempStr:=tempStr+'\iv';
////     if AnsiPos('FeB',IVparameter.fSCAPSFileName)>0
////        then  tempStr2:='FeB'
////        else  tempStr2:='Fe';
//     while not(SetCurrentDir(tempSTR+'\'+tempStr2)) do
//        MkDir(tempStr2);
//     tempStr:=tempStr+'\'+tempStr2+'\';
//     DatFileLocation:=tempStr;
//     DatFileLocation2:=tempStr2;
//    end;
//
// Row:=0;
// while (Row<SCAPSFile.Count) do
//  begin
//   if AnsiStartsStr ('SCAPS', SCAPSFile[ROW]) then
//    begin
//      if Row<>0 then
//       begin
//       SCparam.Add(IVparameter.DataString);
//       StringReplaceMy(SCparam,SCparam[SCparam.Count-1]
//                       +' '
//                       +FloatToStrF(d,ffExponent,4,0)+
//                       ' '
//                       +FloatToStrF(Na,ffExponent,4,0),
//                   SCparam.Count-1);
//       end;
//      IVparameter.Empty;
//      Inc(Row);
//      Continue;
//    end;
//
//   IVparameter.ParameterDetermination(SCAPSFile[ROW],FeLow.Data,FeHi.Data,FeStepNumber.Data);
//
//
//
//  if ((AnsiContainsStr(SCAPSFile[ROW],'v(V)'))and
////      (AnsiContainsStr(SCAPSFile[ROW],'jtot(mA/cm2)'))) then
//     (AnsiContainsStr(SCAPSFile[ROW],' jbulk(mA/cm2)'))and
//      (AnsiContainsStr(SCAPSFile[ROW],'j_SRH'))) then
//    begin
//     ROW:=ROW+2;
//     DatFile.Clear;
//     DatFile_srh.Clear;
//    while SCAPSFile[ROW]<>'' do
//       begin
//        SCAPSFile[ROW]:=SomeSpaceToOne(SCAPSFile[ROW]);
//        tempStr:=SCAPSFile[ROW];
//        if AnsiStartsStr(' ',tempStr) then Delete(tempStr, 1, 1);
//        try
//         V:=StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//
//         I:=10*SampleArea*StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
//
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//         Delete(tempStr, 1, AnsiPos (' ', tempStr));
//
//         I_srh:=10*SampleArea*StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
//
//        except
//         V:=0;
//         I:=0;
//
//         I_srh:=0;
//        end;
//        DatFile.Add((FloatToStrF(V,ffExponent,4,0)+' '+
//                     FloatToStr(I)));
//        DatFile_srh.Add((FloatToStrF(V,ffExponent,4,0)+' '+
//                     FloatToStr(I_srh)));
//        Row:=ROW+1;
//       end;
//
//
//
//
//     DatFileName:=IVparameter.FileName+'.dat';
//     DatFile.SaveToFile(DatFileLocation+DatFileName);
//     Comments.Add(DatFileName);
//     Comments.Add('T='+FloatToStrF(IVparameter.fTemperatura,ffGeneral,4,1));
//     Comments.Add('');
//
//     DatFileName:=IVparameter.FileName+'_srh.dat';
//     DatFile_srh.SaveToFile(DatFileLocation+DatFileName);
//     Comments.Add(DatFileName);
//     Comments.Add('T='+FloatToStrF(IVparameter.fTemperatura,ffGeneral,4,1));
//     Comments.Add('');
//     Continue;
//   end;
//
//   Inc(Row);
//  end;
//
// SCparam.Add(IVparameter.DataString);
// StringReplaceMy(SCparam,SCparam[SCparam.Count-1]
//                       +' '
//                       +FloatToStrF(d,ffExponent,4,0)+
//                       ' '
//                       +FloatToStrF(Na,ffExponent,4,0),
//                   SCparam.Count-1);
//
// if Comments.Count>0 then
//      Comments.SaveToFile(DatFileLocation+'comments');
// Comments.Free;
// if SCparam.Count>1 then
////      SCparam.SaveToFile(DatFileLocation+'SCparam.dat');
////      SCparam.SaveToFile(DatFileLocation+DatFileLocation2+'.dat');
//      SCparam.SaveToFile(DatFileLocation+DatFileLocation2+'.txt');
//
// SCparam.Free;
// DatFile.Free;
////   IVparameter.Free;
//
// LAction.Caption:='Extraction is done';
// LAction.Font.Color:=clGreen;
//end;

function DirFromFileName(Filename,Labels:string;Len:word):string;
begin
  Result:='';
  Result:=Copy(FileName,
                AnsiPos(Labels,FileName),Len);
end;

function d_determine(DirName:string):double;
begin
  Delete(DirName, 1, 1);
  DirName:=DirName+'0';
  Result:=strtoint(DirName)*1e-6;
end;

function N_B_determine(DirName:string):double;
begin
  Delete(DirName, 1, 1);
  DirName:=AnsiReplaceStr(DirName,'p','.');
  Result:=StrToFloat(DirName);
end;

procedure TMainForm.BtFileSelectClick(Sender: TObject);
var Row:Int64;
    Comments,SCparam,DatFile,DatFile_srh:TStringList;
    DatFileLocation,
    Tdir,Ddir,Bdir,InnerDir,DatFileName,ParamSyffix:string;
    V,I,I_srh:double;
    j:integer;
    VoltageColumnNumber,CurrentColumnNumber,
    CurrentSRHColumnNumber:word;
begin
   OpenDialog1.InitialDir:=SCAPS_Folder+'\results';
   OpenDialog1.FileName:='';
   OpenDialog1.Filter:='Scaps files (*.iv)|*.iv';
   if OpenDialog1.Execute()
     then
       begin
       FileName:=ExtractFileName(OpenDialog1.FileName);
       FileName:=copy(FileName,1,length(FileName)-3);
       LFile.Caption:=FileName;
       if FileExists(OpenDialog1.FileName) then
         begin
         SCAPSFile.Clear;
         SCAPSFile.LoadFromFile(OpenDialog1.FileName);
         end;
       end;

 SetCurrentDir(ExtractFilePath(OpenDialog1.FileName));

 FormatSettings.DecimalSeparator:='.';
 Comments:=TStringList.Create;
 SCparam:=TStringList.Create;
 DatFile:=TStringList.Create;
 DatFile_srh:=TStringList.Create;

 IVparameter.Clear;
 IVparameter.ParameterTitleDetermination(SCAPSFile);

 if IVparameter.fName.Count>0 then
  begin
   SCparam.Add(IVparameter.Title+' d N_B');
   for j := 0 to IVparameter.fName.Count - 1 do
    if IVparameter.fUnit[j]<>''
     then Comments.Add(IVparameter.fName[j]+' - '+IVparameter.fUnit[j])
     else Comments.Add(IVparameter.fName[j]+' - '+IVparameter.fDescription[j]);
   Comments.Add('');
  end;

  IVparameter.SCAPSFileNameDetermination(SCAPSFile);
  if AnsiPos('FeB',IVparameter.fSCAPSFileName)>0
    then  InnerDir:='FeB'
    else  InnerDir:='Fe';
  IVparameter.fSCAPSFileName:= StringReplace(IVparameter.fSCAPSFileName,
            'FeB', 'Fe',[rfIgnoreCase]);

  Tdir:=DirFromFileName(IVparameter.fSCAPSFileName,'T',4);
  Ddir:=DirFromFileName(IVparameter.fSCAPSFileName,'D',3);
  Bdir:=DirFromFileName(IVparameter.fSCAPSFileName,'B',9);
  ParamSyffix:=' '+FloatToStrF(d_determine(Ddir),ffExponent,4,0)
               +' '+FloatToStrF(N_B_determine(Bdir),ffExponent,4,0);


  DatFileLocation := DatFileLocationCreateAndDetermine(InnerDir, Tdir, Ddir, Bdir);

 Row:=0;
 while (Row<SCAPSFile.Count) do
  begin
   if AnsiStartsStr ('SCAPS', SCAPSFile[ROW]) then
    begin
      if Row<>0 then
       SCparam.Add(IVparameter.DataString+ParamSyffix);

      IVparameter.Empty;
      Inc(Row);
      Continue;
    end;

   IVparameter.ParameterDetermination(SCAPSFile[ROW],FeLow.Data,FeHi.Data,FeStepNumber.Data);

  if ((AnsiContainsStr(SCAPSFile[ROW],'v(V)'))and
      (AnsiContainsStr(SCAPSFile[ROW],'jtot(mA/cm2)')) and
     (AnsiContainsStr(SCAPSFile[ROW],' jbulk(mA/cm2)'))and
      (AnsiContainsStr(SCAPSFile[ROW],'j_SRH(mA/cm2)'))) then
    begin
     VoltageColumnNumber:=SubstringNumberFromRow('v(V)',SCAPSFile[ROW]);
     CurrentSRHColumnNumber:=SubstringNumberFromRow('j_SRH(mA/cm2)',SCAPSFile[ROW]);
     if RGIllumination.ItemIndex=0 then
      begin
        CurrentColumnNumber:=SubstringNumberFromRow('jbulk(mA/cm2)',SCAPSFile[ROW]);
        DatFile_srh.Clear;
      end                          else
        CurrentColumnNumber:=SubstringNumberFromRow('jtot(mA/cm2)',SCAPSFile[ROW]);
     ROW:=ROW+2;
     DatFile.Clear;
    while SCAPSFile[ROW]<>'' do
       begin
        V:=FloatDataFromRow(SCAPSFile[ROW],VoltageColumnNumber);
        I_srh:=0;
        if RGIllumination.ItemIndex=0 then
         begin
           I:=10*SampleArea*FloatDataFromRow(SCAPSFile[ROW],CurrentColumnNumber);
           I_srh:=10*SampleArea*FloatDataFromRow(SCAPSFile[ROW],CurrentSRHColumnNumber);
         end                           else
           I:=FloatDataFromRow(SCAPSFile[ROW],CurrentColumnNumber);

        DatFile.Add((FloatToStrF(V,ffExponent,4,0)+' '+
                     FloatToStr(I)));
        if RGIllumination.ItemIndex=0 then
          DatFile_srh.Add((FloatToStrF(V,ffExponent,4,0)+' '+
                           FloatToStr(I_srh)));
        Row:=ROW+1;
       end;




     DatFileName:=IVparameter.FileName+'.dat';
     DatFile.SaveToFile(DatFileLocation+DatFileName);
     Comments.Add(DatFileName);
     Comments.Add('T='+FloatToStrF(IVparameter.fTemperatura,ffGeneral,4,1));
     Comments.Add('');

     if RGIllumination.ItemIndex=0 then
      begin
       DatFileName:=IVparameter.FileName+'_srh.dat';
       DatFile_srh.SaveToFile(DatFileLocation+DatFileName);
       Comments.Add(DatFileName);
       Comments.Add('T='+FloatToStrF(IVparameter.fTemperatura,ffGeneral,4,1));
       Comments.Add('');
      end;
     Continue;
   end;

   Inc(Row);
  end;

 SCparam.Add(IVparameter.DataString+ParamSyffix);

 if Comments.Count>0 then
      Comments.SaveToFile(DatFileLocation+'comments.dat');
 Comments.Free;
 if SCparam.Count>1 then
      SCparam.SaveToFile(DatFileLocation+InnerDir+'.txt');

 SCparam.Free;
 DatFile.Free;
 DatFile_srh.Free;
end;



procedure TMainForm.Button1Click(Sender: TObject);
begin
 ShowArrarOfString(ParametersPsevdo);
end;

procedure TMainForm.B_ResFSelectClick(Sender: TObject);
begin
   if SelectDirectory('Choose Result Directory','', Result_Folder)
   then FoldersToForm;
end;

procedure TMainForm.B_SCAPSFSelectClick(Sender: TObject);
begin
  if SelectDirectory('Choose SCAPS Directory','', SCAPS_Folder)
   then FoldersToForm;
end;

function TMainForm.DatFileLocationCreateAndDetermine(InnerDir, Tdir, Ddir,
  Bdir: string): string;
var
  tempStr: string;
begin
  if (Tdir <> '') and (Ddir <> '') and (Bdir <> '') and SetCurrentDir(Result_Folder) then
  begin
    tempSTR := Result_Folder+ '\' + Ddir;
    while not (SetCurrentDir(tempSTR)) do
      MkDir(Ddir);
    tempStr := tempStr + '\' + Bdir;
    while not (SetCurrentDir(tempSTR)) do
      MkDir(Bdir);
    tempStr := tempStr + '\' + Tdir;
    while not (SetCurrentDir(tempSTR)) do
      MkDir(Tdir);
    tempStr := tempStr + '\iv';
    while not (SetCurrentDir(tempSTR)) do
      MkDir('iv');
    tempStr := tempStr + '\' + InnerDir;
    while not (SetCurrentDir(tempSTR)) do
      MkDir(InnerDir);
    Result := tempStr + '\';
  end;

end;

//function TMainForm.EditString(str: string): string;
//begin
//  Result:=AnsiReplaceStr(str,'.','p');
//  Result:=AnsiReplaceStr(Result,'+','');
//  while AnsiPos ('0E', Result)>5 do
//      Result:=AnsiReplaceStr(Result,'0E','E');
//  while AnsiPos ('0e', Result)>5 do
//      Result:=AnsiReplaceStr(Result,'0e','e');
//end;

procedure TMainForm.BResultClick(Sender: TObject);
// const DirecName:array[1..3]of string=('Iron','Boron','Temperature');
//   ShortDirecName:array[1..3]of string=('Fe','B','T');

 var  ResultFile{,SimpleDataFile,MatrixDataFile}:TStringList;
//      ArrayKeyStringList,AKSL2,AKSL3:TArrayKeyStringList;
//      Number,Number2:word;
//      I,j:integer;
//      Key,KeyString:string;
//      DirectoryN,DirectoryN2:string;
      ArrKeyStrList:TArrKeyStrList;

begin

 OpenDialog1.InitialDir :=Result_Folder;
 OpenDialog1.FileName:='';
 OpenDialog1.Filter:='Result file (ResultAll.dat)|*.dat';
   if OpenDialog1.Execute()
     then
       begin
        ResultFile:=TStringList.Create;
//        SimpleDataFile:=TStringList.Create;
//        MatrixDataFile:=TStringList.Create;
        Directory:=ExtractFilePath(OpenDialog1.FileName);
        ResultFile.LoadFromFile(OpenDialog1.FileName);
        ArrKeyStrList:=TArrKeyStrList.Create(ResultFile);
        ArrKeyStrList.SaveData;
        ArrKeyStrList.Free;

//        ResultFile.Delete(0);
//        ArrayKeyStringList:=TArrayKeyStringList.Create;
//        AKSL2:=TArrayKeyStringList.Create;
//        AKSL3:=TArrayKeyStringList.Create;
//        for Number := 1 to 3 do
//        begin
////        Number:=3;
//          ArrayKeyStringList.Clear;
//          ArrayKeyStringList.AddKeysFromStringList(ResultFile,Number);
//          ArrayKeyStringList.SortingByKeyValue;
//
//          CreateDirSafety(DirecName[Number]);
//
//          SetCurrentDir(Directory+'/'+DirecName[Number]);
//          DirectoryN:=GetCurrentDir;
//
//          ArrayKeyStringList.CreateDirByKeys(ShortDirecName[Number]);
//
//          for I := 0 to ArrayKeyStringList.Count-1 do
//            begin
//
//              SetCurrentDir(DirectoryN
//                  +'/'+ShortDirecName[Number]
//                  +EditString(ArrayKeyStringList.Keys[i]));
//              DirectoryN2:=GetCurrentDir;
//              MatrixDataFile.Clear;
//
//              for Number2 := 1 to 2 do
//                begin
//                AKSL2.Clear;
//                AKSL2.AddKeysFromStringList(ArrayKeyStringList.StringLists[i],Number2);
//                AKSL2.SortingByKeyValue;
//
//                CreateDirSafety(SubDirectoryName(Number,Number2));
//                SetCurrentDir(DirectoryN2+'/'+SubDirectoryName(Number,Number2));
////                AKSL2.CreateDirByKeys(SubDirectorySault(Number,Number2));
//                for j := 0 to AKSL2.Count-1 do
//                 begin
//                  AKSL3.Clear;
//                  AKSL3.AddKeysFromStringList(AKSL2.StringLists[j],1);
//                  AKSL3.SortingByKeyValue;
//                  AKSL3.DataConvert;
//                  SimpleDataFile.Clear;
//                  AKSL3.KeysAndListsToStringList(SimpleDataFile);
//                  if Number2=1 then
//                    KeysAndStringListToStringList(LogKey(AKSL2.Keys[j]),SimpleDataFile,MatrixDataFile);
//                  SimpleDataFile.Insert(0,DataFileHeader(Number,Number2));
//                  SimpleDataFile.SaveToFile(DataFileName(Number,Number2,
//                                        ArrayKeyStringList.Keys[i],
//                                        AKSL2.Keys[j]));
//                 end;
//                SetCurrentDir(DirectoryN2);
//                end;
//
//              SetCurrentDir(DirectoryN);
//              MatrixDataFile.Insert(0,MatrixFileHeader(Number));
//              MatrixDataFile.SaveToFile(MatrixFileName(Number,ArrayKeyStringList.Keys[i]));
//
//            end;
//
//
//         SetCurrentDir(Directory);
//        end;
//
////          AKSL2.StringLists[0].Add(AKSL2.Keys[0]);
////          AKSL2.StringLists[0].SaveToFile('temp.dat');
////          SimpleDataFile.SaveToFile('temp.dat');
////          AKSL3.StringLists[0].Add(AKSL3.Keys[0]);
////          AKSL3.StringLists[0].SaveToFile('temp3.dat');
//
//
////         ArrayKeyStringList.StringLists[1].SaveToFile('temp.dat');
////        showmessage(inttostr(ArrayKeyStringList.StringLists[10].Count));
////        showmessage(inttostr(ArrayKeyStringList.Count));
//        AKSL3.Free;
//        AKSL2.Free;
//        ArrayKeyStringList.Free;
//        SimpleDataFile.Free;
//        MatrixDataFile.Free;


        ResultFile.Free;
       end;
end;


procedure TMainForm.BScapsFileCreateClick(Sender: TObject);
 var FeScaps,FeBScaps:TStringList;
     T:integer;
     fileName,fileName2,tempStr,tempBegin,tempMidle,tempEnd:string;
     dFei,dFeBd,dFeBa:TDefect;
  I: Integer;
begin
  SetCurrentFolders;

 FeScaps:=TStringList.Create;
 FeBScaps:=TStringList.Create;
 dFei:=TDefect.Create(Fei);
 dFeBd:=TDefect.Create(FeB_don);
 dFeBa:=TDefect.Create(FeB_ac);

 T:=TempStart.Data;

// ��� SCAPS 3.10 ������ ������� ���� 92 �������� �� 2

 repeat
 FeScaps.Clear;
 SetCurrentDir(ExtractFilePath(Application.ExeName));
 fileName:='Fe'+PartOfFileNameCreate(T)+'.scaps';
 fileName2:='FeB'+PartOfFileNameCreate(T)+'.scaps';

 FeScaps.LoadFromFile('FeSample.scaps');
 FeBScaps.LoadFromFile('FeBSample.scaps');
 tempStr:='> '+SCAPS_Folder+'\def\'+fileName;
 StringReplaceMy(FeScaps,tempStr,3);
 tempStr:='> '+SCAPS_Folder+'\def\'+fileName2;
 StringReplaceMy(FeBScaps,tempStr,3);


// tempBegin:='Sn :  ';
// tempEnd:=' [m/s]';
// tempstr:=LowerCase(floattostrF(3.2*BSFCon.Data/1e16+0.3,ffExponent,4,2));
// tempstr:=tempBegin+tempstr+tempEnd;
// StringReplaceMy(FeScaps,tempStr,135);

 tempBegin:='d : ';
 tempEnd:=' [m]';
 tempstr:=LowerCase(floattostrF(BSFThick.Data*1e-6,ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,146);
 StringReplaceMy(FeBScaps,tempStr,158);
 tempstr:=LowerCase(floattostrF(BaseThick.Data*1e-6,ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,203);
 StringReplaceMy(FeBScaps,tempStr,232);
 tempstr:=LowerCase(floattostrF(EmiterThick.Data*1e-6,ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,260);
 StringReplaceMy(FeBScaps,tempStr,306);


 tempBegin:='Relative electron mass :	  ';
 tempMidle:='	  1.0000e+00	  1.0000e+00	  1.0000e+00	  1.0000e+00	  ';
 tempEnd:='	 1	 0	[-]';
 tempstr:=LowerCase(floattostrF( Silicon.Meff_e(T),ffExponent,5,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	  '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,148);
 StringReplaceMy(FeScaps,tempStr,205);
 StringReplaceMy(FeScaps,tempStr,262);
 StringReplaceMy(FeBScaps,tempStr,160);
 StringReplaceMy(FeBScaps,tempStr,234);
 StringReplaceMy(FeBScaps,tempStr,308);

 tempBegin:='Relative hole mass :	  ';
 tempstr:=LowerCase(floattostrF(Silicon.Meff_h(T),ffExponent,5,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	  '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,149);
 StringReplaceMy(FeScaps,tempStr,206);
 StringReplaceMy(FeScaps,tempStr,263);
 StringReplaceMy(FeBScaps,tempStr,161);
 StringReplaceMy(FeBScaps,tempStr,235);
 StringReplaceMy(FeBScaps,tempStr,309);


 tempBegin:='v_th_n :	 ';
 tempMidle:='	 1.000e+05	 1.000e+01	 1.000e+01	 1.000e+01	 ';
 tempEnd:='	 1	 0	[m/s]';
 tempstr:=LowerCase(floattostrF(Silicon.Vth_n(T),ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,151);
 StringReplaceMy(FeScaps,tempStr,208);
 StringReplaceMy(FeScaps,tempStr,265);
 StringReplaceMy(FeBScaps,tempStr,163);
 StringReplaceMy(FeBScaps,tempStr,237);
 StringReplaceMy(FeBScaps,tempStr,311);

 tempBegin:='v_th_p :	 ';
 tempstr:=LowerCase(floattostrF(Silicon.Vth_p(T),ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,152);
 StringReplaceMy(FeScaps,tempStr,209);
 StringReplaceMy(FeScaps,tempStr,266);
 StringReplaceMy(FeBScaps,tempStr,164);
 StringReplaceMy(FeBScaps,tempStr,238);
 StringReplaceMy(FeBScaps,tempStr,312);

 tempBegin:='Eg :	  ';
 tempMidle:='	  1.200000	  0.500000	  1.000000	  1.000000	  ';
 tempEnd:='	 1	 0	[eV]';
 tempstr:=LowerCase(floattostrF( Silicon.Eg(T)-Silicon.BGN(BSFCon.Data*1e6,False),ffFixed,7,6));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+' 	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,155);
 StringReplaceMy(FeBScaps,tempStr,167);
 tempstr:=LowerCase(floattostrF(Silicon.Eg(T)-Silicon.BGN(Boron.Data*1e6,False),ffFixed,7,6));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	  '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,212);
 StringReplaceMy(FeBScaps,tempStr,241);
 tempstr:=LowerCase(floattostrF(Silicon.Eg(T)-Silicon.BGN(EmiterCon.Data*1e6,True),ffFixed,7,6));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	  '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,269);
 StringReplaceMy(FeBScaps,tempStr,315);

 tempBegin:='Nc :	 ';
 tempMidle:='	 1.000000e+25	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
 tempEnd:='	 1	 0	[/m^3]';
 tempstr:=LowerCase(floattostrF( Silicon.Nc(T)*Power((300/T),1.5),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,156);
 StringReplaceMy(FeScaps,tempStr,213);
 StringReplaceMy(FeScaps,tempStr,270);
 StringReplaceMy(FeBScaps,tempStr,168);
 StringReplaceMy(FeBScaps,tempStr,242);
 StringReplaceMy(FeBScaps,tempStr,316);

 tempBegin:='Nv :	 ';
 tempMidle:='	 1.000000e+25	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
 tempEnd:='	 1	 0	[/m^3]';
 tempstr:=LowerCase(floattostrF( Silicon.Nv(T)*Power((300/T),1.5),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,157);
 StringReplaceMy(FeScaps,tempStr,214);
 StringReplaceMy(FeScaps,tempStr,271);
 StringReplaceMy(FeBScaps,tempStr,169);
 StringReplaceMy(FeBScaps,tempStr,243);
 StringReplaceMy(FeBScaps,tempStr,317);

 tempBegin:='mu_n :	 ';
 tempMidle:='	 5.000000e-03	 1.000000e-03	 1.000000e+00	 1.000000e+00	 ';
 tempEnd:='	 1	 0	[m^2/Vs]';
 tempstr:=LowerCase(floattostrF(Silicon.mu_n(T,BSFCon.Data*1e6,False),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,158);
 StringReplaceMy(FeBScaps,tempStr,170);
 tempstr:=LowerCase(floattostrF( Silicon.mu_n(T,Boron.Data*1e6,False),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,215);
 StringReplaceMy(FeBScaps,tempStr,244);
 tempstr:=LowerCase(floattostrF( Silicon.mu_n(T,EmiterCon.Data*1e6,True),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,272);
 StringReplaceMy(FeBScaps,tempStr,318);

 tempBegin:='mu_p :	 ';
 tempstr:=LowerCase(floattostrF(Silicon.mu_p(T,BSFCon.Data*1e6,True),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,159);
 StringReplaceMy(FeBScaps,tempStr,171);
 tempstr:=LowerCase(floattostrF( Silicon.mu_p(T,Boron.Data*1e6,True),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,216);
 StringReplaceMy(FeBScaps,tempStr,245);
 tempstr:=LowerCase(floattostrF( Silicon.mu_p(T,EmiterCon.Data*1e6,False),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,273);
 StringReplaceMy(FeBScaps,tempStr,319);

 tempBegin:='K_rad :	 ';
 tempMidle:='	 0.000000e+00	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
 tempEnd:='	 1	 0	[m^3/s]';
 tempstr:=LowerCase(floattostrF( Silicon.Brad(T),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,160);
 StringReplaceMy(FeScaps,tempStr,217);
 StringReplaceMy(FeScaps,tempStr,274);
 StringReplaceMy(FeBScaps,tempStr,172);
 StringReplaceMy(FeBScaps,tempStr,246);
 StringReplaceMy(FeBScaps,tempStr,320);

 tempBegin:='c_n_auger :	 ';
 tempMidle:='	 0.000000e+00	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
 tempEnd:='	 1	 0	[m^6/s]';
 tempstr:=LowerCase(floattostrF(Silicon.Cn_Auger(Silicon.MinorityN(BSFCon.Data*1e6),T),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,161);
 StringReplaceMy(FeBScaps,tempStr,173);
 tempstr:=LowerCase(floattostrF( Silicon.Cn_Auger(Silicon.MinorityN(Boron.Data*1e6),T),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,218);
 StringReplaceMy(FeBScaps,tempStr,247);
 tempstr:=LowerCase(floattostrF( Silicon.Cn_Auger(EmiterCon.Data*1e6,T),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,275);
 StringReplaceMy(FeBScaps,tempStr,321);


 tempBegin:='c_p_auger :	 ';
 tempstr:=LowerCase(floattostrF(Silicon.Cp_Auger(BSFCon.Data*1e6,T),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,162);
 StringReplaceMy(FeBScaps,tempStr,174);
 tempstr:=LowerCase(floattostrF( Silicon.Cp_Auger(Boron.Data*1e6,T),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,219);
 StringReplaceMy(FeBScaps,tempStr,248);
 tempstr:=LowerCase(floattostrF( Silicon.Cp_Auger(Silicon.MinorityN(EmiterCon.Data*1e6),T),ffExponent,7,2));
 tempstr:=tempBegin+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,276);
 StringReplaceMy(FeBScaps,tempStr,322);

 tempBegin:='Na(uniform) :	 ';
 tempMidle:='	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
 tempEnd:='	 0	 2	[/m^3]';
 tempstr:=LowerCase(floattostrF(BSFCon.Data*1e6,ffExponent,7,2));
 tempstr:=tempBegin+tempstr+'	 '+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,163);
 StringReplaceMy(FeBScaps,tempStr,175);
 tempstr:=LowerCase(floattostrF(Boron.Data*1e6,ffExponent,7,2));
 tempstr:=tempBegin+tempstr+'	 '+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,220);
 StringReplaceMy(FeBScaps,tempStr,249);
 tempBegin:='Nd(uniform) :	 ';
 tempstr:=LowerCase(floattostrF(EmiterCon.Data*1e6,ffExponent,7,2));
 tempstr:=tempBegin+tempstr+'	 '+tempstr+tempMidle+tempstr+'	 '+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,278);
 StringReplaceMy(FeBScaps,tempStr,324);

 tempBegin:='sigma_n : ';
 tempEnd:='	[m^2]';
 tempstr:=LowerCase(floattostrf(dFei.Sn(T),ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,188);
 StringReplaceMy(FeScaps,tempStr,245);
 StringReplaceMy(FeBScaps,tempStr,217);
 StringReplaceMy(FeBScaps,tempStr,291);
 tempstr:=LowerCase(floattostrf(dFeBd.Sn(T),ffExponent,4,2))+' '+
          LowerCase(floattostrf(dFeBa.Sn(T),ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeBScaps,tempStr,201);
 StringReplaceMy(FeBScaps,tempStr,275);


 tempBegin:='sigma_p : ';
 tempstr:=LowerCase(floattostrf(dFei.Sp(T),ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeScaps,tempStr,189);
 StringReplaceMy(FeScaps,tempStr,246);
 StringReplaceMy(FeBScaps,tempStr,218);
 StringReplaceMy(FeBScaps,tempStr,292);
 tempstr:=LowerCase(floattostrf(dFeBd.Sp(T),ffExponent,4,2))+' '+
          LowerCase(floattostrf(dFeBa.Sp(T),ffExponent,4,2));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeBScaps,tempStr,202);
 StringReplaceMy(FeBScaps,tempStr,276);

 tempBegin:='Et :   ';
 tempEnd:='	[eV]';
 tempstr:=LowerCase(floattostrf(Silicon.Eg(T)-Silicon.BGN(BSFCon.Data*1e6,False)-dFeBd.Et,ffFixed,5,3))
          +'	  '+LowerCase(floattostrf(dFeBa.Et,ffFixed,5,3));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeBScaps,tempStr,203);
 tempstr:=LowerCase(floattostrf(Silicon.Eg(T)-Silicon.BGN(Boron.Data*1e6,False)-dFeBd.Et,ffFixed,5,3))
          +'	  '+LowerCase(floattostrf(dFeBa.Et,ffFixed,5,3));
 tempstr:=tempBegin+tempstr+tempEnd;
 StringReplaceMy(FeBScaps,tempStr,277);


 // Et :   1.024	  0.260	[eV]

 tempBegin:='Temperature :   ';
 tempEnd:=' K';
 tempstr:=LowerCase(floattostrf(T*1.0,ffFixed,5,2));
 StringReplaceMy(FeScaps,tempBegin+tempstr+tempEnd,314);
 StringReplaceMy(FeBScaps,tempBegin+tempstr+tempEnd,360);
 tempBegin:='Secondworkpoint Temperature :   ';
 StringReplaceMy(FeScaps,tempBegin+tempstr+tempEnd,327);
 StringReplaceMy(FeBScaps,tempBegin+tempstr+tempEnd,373);

 case RGIllumination.ItemIndex of
  0:begin
     StringReplaceMy(FeScaps,'dark :  1',318);
     StringReplaceMy(FeScaps,'incident spectrum from file :AM1_5G 1 sun.spe',320);
     StringReplaceMy(FeScaps,'IV_stopV :     0.4500 V',341);
     StringReplaceMy(FeScaps,'IV_points :  46',342);
     StringReplaceMy(FeScaps,'stop after Voc :  0',345);
     StringReplaceMy(FeBScaps,'dark :  1',364);
     StringReplaceMy(FeBScaps,'incident spectrum from file :AM1_5G 1 sun.spe',366);
     StringReplaceMy(FeBScaps,'IV_stopV :     0.4500 V',387);
     StringReplaceMy(FeBScaps,'IV_points :  46',388);
     StringReplaceMy(FeBScaps,'stop after Voc :  0',391);
    end;
  1:begin
     StringReplaceMy(FeScaps,'dark :  0',318);
     StringReplaceMy(FeScaps,'incident spectrum from file :AM1.5G ed2 1 sun.spe',320);
     StringReplaceMy(FeScaps,'IV_stopV :     0.7500 V',341);
     StringReplaceMy(FeScaps,'IV_points :  76',342);
      StringReplaceMy(FeScaps,'stop after Voc :  1',345);
     StringReplaceMy(FeBScaps,'dark :  0',364);
     StringReplaceMy(FeBScaps,'incident spectrum from file :AM1.5G ed2 1 sun.spe',366);
     StringReplaceMy(FeBScaps,'IV_stopV :     0.7500 V',387);
     StringReplaceMy(FeBScaps,'IV_points :  76',388);
     StringReplaceMy(FeBScaps,'stop after Voc :  1',391);
    end;
  2:begin
     StringReplaceMy(FeScaps,'dark :  0',318);
     StringReplaceMy(FeScaps,'incident spectrum from file :940nmSim.spe',320);
     StringReplaceMy(FeScaps,'IV_stopV :     0.7500 V',341);
     StringReplaceMy(FeScaps,'IV_points :  76',342);
      StringReplaceMy(FeScaps,'stop after Voc :  1',345);
     StringReplaceMy(FeBScaps,'dark :  0',364);
     StringReplaceMy(FeBScaps,'incident spectrum from file :940nmSim.spe',366);
     StringReplaceMy(FeBScaps,'IV_stopV :     0.7500 V',387);
     StringReplaceMy(FeBScaps,'IV_points :  76',388);
     StringReplaceMy(FeBScaps,'stop after Voc :  1',391);
    end;
 end;



 tempBegin:='startvalue :   ';
 tempstr:=LowerCase(floattostrf(FeLow.Data,ffExponent,9,2));
 StringReplaceMy(FeScaps,'minimum value :   '+tempstr,418);
  StringReplaceMy(FeScaps,'minimum value :   '+tempstr,429);
 tempstr:=tempBegin+tempStr;
 StringReplaceMy(FeScaps,tempstr,379);
 StringReplaceMy(FeScaps,tempstr,392);
 tempBegin:='stopvalue :   ';
 tempstr:=LowerCase(floattostrf(FeHi.Data,ffExponent,9,2));
 StringReplaceMy(FeScaps,'maximum value :   '+tempstr,419);
 StringReplaceMy(FeScaps,'maximum value :   '+tempstr,430);
 tempstr:=tempBegin+tempStr;
 StringReplaceMy(FeScaps,tempstr,380);
 StringReplaceMy(FeScaps,tempstr,393);
 tempBegin:='number of steps :   ';
 tempstr:=LowerCase(inttostr(FeStepNumber.Data));
 tempstr:=tempBegin+tempStr;
 StringReplaceMy(FeScaps,tempstr,381);
 StringReplaceMy(FeScaps,tempstr,394);


// ----------------------------------------------
 for I := 0 to round(FloatDataFromRow(FeBScaps[522],6)) - 1 do
       FeBScaps.Delete(524);
 for I := FeStepNumber.Data - 1 downto 0 do
       begin
        tempBegin:=inttostr(i);
        if i<10 then
             begin
              tempstr:='0'+tempBegin;
              tempBegin:=' '+tempBegin;
             end
                else
             tempstr:=tempBegin;
        FeBScaps.Insert(524,'file  '+tempBegin+':F'+tempstr+'.grd');
       end;

 tempBegin:='number of file names :   ';
 tempstr:=LowerCase(inttostr(FeStepNumber.Data));
 tempstr:=tempBegin+tempStr;
 StringReplaceMy(FeBScaps,tempstr,522);



 for I := 0 to round(FloatDataFromRow(FeBScaps[490],6)) - 1 do
       FeBScaps.Delete(492);
 for I := FeStepNumber.Data - 1 downto 0 do
       begin
        tempBegin:=inttostr(i);
        if i<10 then
             begin
              tempstr:='0'+tempBegin;
              tempBegin:=' '+tempBegin;
             end
                else
             tempstr:=tempBegin;
        FeBScaps.Insert(492,'file  '+tempBegin+':B'+tempstr+'.grd');
       end;

 tempBegin:='number of file names :   ';
 tempstr:=LowerCase(inttostr(FeStepNumber.Data));
 tempstr:=tempBegin+tempStr;
 StringReplaceMy(FeBScaps,tempstr,490);

  for I := 0 to round(FloatDataFromRow(FeBScaps[458],6)) - 1 do
       FeBScaps.Delete(460);
 for I := FeStepNumber.Data - 1 downto 0 do
       begin
        tempBegin:=inttostr(i);
        if i<10 then
             begin
              tempstr:='0'+tempBegin;
              tempBegin:=' '+tempBegin;
             end
                else
             tempstr:=tempBegin;
        FeBScaps.Insert(460,'file  '+tempBegin+':S'+tempstr+'.grd');
       end;

 tempBegin:='number of file names :   ';
 tempstr:=LowerCase(inttostr(FeStepNumber.Data));
 tempstr:=tempBegin+tempStr;
 StringReplaceMy(FeBScaps,tempstr,458);

 for I := 0 to round(FloatDataFromRow(FeBScaps[426],6)) - 1 do
       FeBScaps.Delete(428);
 for I := FeStepNumber.Data - 1 downto 0 do
       begin
        tempBegin:=inttostr(i);
        if i<10 then
             begin
              tempstr:='0'+tempBegin;
              tempBegin:=' '+tempBegin;
             end
                else
             tempstr:=tempBegin;
        FeBScaps.Insert(428,'file  '+tempBegin+':P'+tempstr+'.grd');
       end;

 tempBegin:='number of file names :   ';
 tempstr:=LowerCase(inttostr(FeStepNumber.Data));
 tempstr:=tempBegin+tempStr;
 StringReplaceMy(FeBScaps,tempstr,426);
// -----------------------------------------------------------------

// FeScaps.Insert(146,tempStr);
 if SetCurrentDir(SCAPS_Folder+'\def') then
    begin
    FeScaps.SaveToFile(fileName);
    FeBScaps.SaveToFile(fileName2);
    end;

  SetTemperatureFolders(T);
  FeScaps.SaveToFile(fileName);
  FeBScaps.SaveToFile(fileName2);

 StringReplaceMy(FeScaps,'d : 1.000e-05 [m]',203);
 StringReplaceMy(FeScaps,'IV_calculate :  0',344);

 for I := 412 to 433 do FeScaps.Delete(412);
 for I := 370 to 395 do FeScaps.Delete(370);
 for I := 233 to 248 do FeScaps.Delete(233);
 for I := 176 to 191 do FeScaps.Delete(176);

 fileName:='D1'+'T'+inttostr(T)+NBoronToString+'.scaps';
 if SetCurrentDir(SCAPS_Folder+'\def') then
    FeScaps.SaveToFile(fileName);

  tempStr:=Result_Folder+'\'+BaseThickToString+'\'+NBoronToString;
  SetCurrentDir(tempSTR+'\'+'T'+inttostr(T));
  FeScaps.SaveToFile(fileName);

 T:=T+TempStep.Data;
 until (T>TempFinish.Data);

 dFei.Free;
 dFeBd.Free;
 dFeBa.Free;
 FeScaps.Free;
end;

procedure TMainForm.AdDataFromDatesDat(FullFilename: string);
 var
    DatesDatFile,ResultFile,TxtFile,
    nDat,n_srhDat:TStringList;
    SR : TSearchRec;
    i,j:integer;
    fl_name,tempString,FillString,AllResultTitle:string;
    SRH_file,FeBdata,RowIsFound,DarkIV,FeBdataInFile,FedataInFile:boolean;
    ParameterNumbers,ExtractedDataNumbers,ExtractedDataNumbersFeB:TArrInteger;
begin
       Directory:=ExtractFilePath(FullFilename);
       SetCurrentDir(Directory);
       DatesDatFile:=TStringList.Create;
       ResultFile:=TStringList.Create;
       TxtFile:=TStringList.Create;
       nDat:=TStringList.Create;
       n_srhDat:=TStringList.Create;
       DatesDatFile.LoadFromFile(FullFilename);
       DarkIV:=RGIllumination.ItemIndex=0;

   try
       if DarkIV then
         begin
         if FindFirst('*.txt', faAnyFile, SR) = 0 then
           TxtFile.LoadFromFile(SR.Name)
                                                  else
           begin
              showmessage('.txt file is absent');
              Exit;
           end;

         FeBdata:=(AnsiPos('FeB',SR.Name)>0);
         end                           else

         FeBdata:=(AnsiPos('FeB',ExtractFileName(FullFilename))>0);

       if DarkIV then
        begin
         if not(NumberDetermine(ParametersPsevdo,TxtFile[0], ParameterNumbers))
            or not(NumberDetermine(ExtractedDataDarkPsevdo,DatesDatFile[0], ExtractedDataNumbers))
                then
                raise Exception.Create('Wrong file format');
        end                          else
        begin
         if not(NumberDetermine(ParametersPsevdo,DatesDatFile[0], ParameterNumbers))
            or not(NumberDetermine(ExtractedDataLightPsevdo,DatesDatFile[0], ExtractedDataNumbers))
                then
                raise Exception.Create('Wrong file format');
        end;

       if DarkIV then
       begin
       nDat.Add(NewStringFromStringArray(ParametersNames)
                +' '+NewStringFromStringArray(ExtractedDataDarkNames)
                +' '+NewStringFromStringArray(ExtractedDataDarkNames,'_SRH'));
       for I := 1 to DatesDatFile.Count - 1 do
         begin
          fl_name:=StringDataFromRow(DatesDatFile[i],2);
          fl_name:=Copy(fl_name,1,AnsiPos ('.dat', fl_name)-1);
          SRH_file:=(AnsiPos ('_srh', fl_name)>0);
          if SRH_file then fl_name:=Copy(fl_name,1,AnsiPos ('_srh', fl_name)-1);
          for j:=1 to TxtFile.Count - 1 do
            if AnsiPos(fl_name,TxtFile[j])>0 then
             begin
              tempString:=NewStringByNumbers(TxtFile[j],ParameterNumbers)
                          +' '+NewStringByNumbers(DatesDatFile[i],ExtractedDataNumbers);
              Break;
             end;
          if SRH_file then  n_srhDat.Add(tempString)
                      else  nDat.Add(tempString);
         end;
       end         else
       begin
       nDat.Add(NewStringFromStringArray(ParametersNames)
                +' '+NewStringFromStringArray(ExtractedDataLightNames));
       for I := 1 to DatesDatFile.Count - 1 do
         begin
           nDat.Add(NewStringByNumbers(DatesDatFile[i],ParameterNumbers)
                          +' '+NewStringByNumbers(DatesDatFile[i],ExtractedDataNumbers));
         end;
       end;

       DatesDatFile.Clear;

       if DarkIV then
        begin
        if FeBdata then DatesDatFile.Add('N_Fe N_B T d n_FeB n_FeB_SRH')
                   else DatesDatFile.Add('N_Fe N_B T d n_Fe n_Fe_SRH');
        end       else
        if FeBdata then DatesDatFile.Add(NewStringFromStringArray(ParametersNames)
                          +' '+NewStringFromStringArray(ExtractedDataLightNames,'_FeB'))
                   else DatesDatFile.Add(NewStringFromStringArray(ParametersNames)
                          +' '+NewStringFromStringArray(ExtractedDataLightNames,'_Fe'));
        if DarkIV then
        begin
        for I := 1 to nDat.Count - 1 do
         begin
           tempString:=DeleteStringDataFromRow(nDat[i],5);
          for j := 0 to n_srhDat.Count - 1 do
           if AnsiPos(tempString,n_srhDat[j])>0 then
            begin
            DatesDatFile.Add(nDat[i]+' '+StringDataFromRow(n_srhDat[j],5));
            Break;
            end;
         end;
        end       else
        begin
         for I := 1 to nDat.Count - 1 do  DatesDatFile.Add(nDat[i]);
        end;

        SetCurrentDir(DeleteLastDir(DeleteLastDir(Directory)));
        tempString:='D'+IntToStr(round(strtofloat(StringDataFromRow(DatesDatFile[2],4))*1e5))
        +'T'+StringDataFromRow(DatesDatFile[2],3)
        +'B'+NumberToString(strtofloat(StringDataFromRow(DatesDatFile[2],2)));
        if FeBdata then DatesDatFile.SaveToFile('FB'+tempString+'.dat')
                   else DatesDatFile.SaveToFile('Fe'+tempString+'.dat');


       SetCurrentDir(Result_Folder);
       if FindFirst('ResultAll.dat', faAnyFile, SR) <> 0 then
         DatesDatFile.SaveToFile('ResultAll.dat')
                                                         else
         begin
          ResultFile.LoadFromFile(SR.Name);

          ParameterNumbers:=[1,2,3,4];
          if DarkIV then
           begin
            FeBdataInFile:=AnsiPos('n_FeB',ResultFile[0])>0;
            FedataInFile:=AnsiPos('n_Fe ',ResultFile[0])>0;
            FillString:=' 1 1 ';
            ExtractedDataNumbers:=[5,6];
            ExtractedDataNumbersFeB:=[7,8];
            AllResultTitle:='N_Fe N_B T d n_Fe n_Fe_SRH n_FeB n_FeB_SRH';
           end      else
           begin
            FeBdataInFile:=AnsiPos('Jsc_FeB',ResultFile[0])>0;
            FedataInFile:=AnsiPos('Jsc_Fe ',ResultFile[0])>0;
            FillString:=' 0 0 0 0 ';
            ExtractedDataNumbers:=[5,6,7,8];
            ExtractedDataNumbersFeB:=[9,10,11,12];
            AllResultTitle:=NewStringFromStringArray(ParametersNames)
                            +' '+NewStringFromStringArray(ExtractedDataLightNames,'_Fe')
                            +' '+NewStringFromStringArray(ExtractedDataLightNames,'_FeB')
                            +' '+NewStringFromStringArray(ExtractedDataLightNames,'_e');
           end;

          if (FeBdataInFile)and(FedataInFile) then
             begin
               while DatesDatFile.Count>1 do
                begin
                 tempString:=NewStringByNumbers(DatesDatFile[1],ParameterNumbers);
                 RowIsFound:=false;
                 for I := 1 to ResultFile.Count - 1 do
                   begin
                     if AnsiPos(tempString,ResultFile[i])>0 then
                      begin
                         if FeBdata then tempString:=tempString+' '
                                          +NewStringByNumbers(ResultFile[i],ExtractedDataNumbers)+' '
                                          +NewStringByNumbers(DatesDatFile[1],ExtractedDataNumbers)
                                    else tempString:=DatesDatFile[1]+' '
                                          +NewStringByNumbers(ResultFile[i],ExtractedDataNumbersFeB);
                        tempString:=SomeSpaceToOne(tempString);
                        if not(DarkIV) then delIllumParamCalculate(tempString);
                        StringReplaceMy(ResultFile,tempString,i);
                        RowIsFound:=true;
                        Break;
                      end; //if AnsiPos(tempString,ResultFile[i])>0 then
                   end;//for I := 1 to ResultFile.Count - 1 do
                 if not(RowIsFound) then
                    begin
                    if FeBdata then  tempString:=tempString+FillString
                                         +NewStringByNumbers(DatesDatFile[1],ExtractedDataNumbers)
                               else tempString:=DatesDatFile[1]+FillString;
                     if not(DarkIV) then delIllumParamCalculate(tempString);
                     ResultFile.Add(tempString);
                    end;
                 DatesDatFile.Delete(1);
                end; //while DatesDatFile.Count>1 do
             end;
          if (FeBdataInFile)and(not(FedataInFile)) then
             begin
              if not(FeBdata) then
                begin
                 StringReplaceMy(ResultFile,AllResultTitle,0);
                 for I := 1 to ResultFile.Count - 1 do
                   begin
                    tempString:=NewStringByNumbers(ResultFile[i],ParameterNumbers)
                                +FillString
                                +NewStringByNumbers(ResultFile[i],ExtractedDataNumbers);
                      if not(DarkIV) then delIllumParamCalculate(tempString);
                      StringReplaceMy(ResultFile,tempString,i);
                   end;
                end;
              while DatesDatFile.Count>1 do
                begin
                 tempString:=NewStringByNumbers(DatesDatFile[1],ParameterNumbers);
                 RowIsFound:=false;
                 for I := 1 to ResultFile.Count - 1 do
                   begin
                     if AnsiPos(tempString,ResultFile[i])>0 then
                      begin
                         if FeBdata then tempString:=DatesDatFile[1]
                                    else tempString:=DatesDatFile[1]+' '
                                         +NewStringByNumbers(ResultFile[i],ExtractedDataNumbersFeB);
                        tempString:=SomeSpaceToOne(tempString);
                        if not(DarkIV)and(not(FeBdata)) then delIllumParamCalculate(tempString);
                        StringReplaceMy(ResultFile,tempString,i);
                        RowIsFound:=true;
                        Break;
                      end; //if AnsiPos(tempString,ResultFile[i])>0 then
                   end;//for I := 1 to ResultFile.Count - 1 do
                 if not(RowIsFound) then
                   begin
                    if FeBdata then tempString:=DatesDatFile[1]
                               else tempString:=DatesDatFile[1]+FillString;
                    if not(DarkIV)and(not(FeBdata)) then delIllumParamCalculate(tempString);
                    ResultFile.Add(tempString);
                   end;
                 DatesDatFile.Delete(1);
                end; //while DatesDatFile.Count>1 do
             end;
          if (not(FeBdataInFile))and(FedataInFile) then
             begin
              if FeBdata then
                begin
                 StringReplaceMy(ResultFile,AllResultTitle,0);
                end;
               while DatesDatFile.Count>1 do
                begin
                 tempString:=NewStringByNumbers(DatesDatFile[1],ParameterNumbers);
                 RowIsFound:=false;
                 for I := 1 to ResultFile.Count - 1 do
                   begin
                     if AnsiPos(tempString,ResultFile[i])>0 then
                      begin
                         if FeBdata then tempString:=tempString+' '
                                          +NewStringByNumbers(ResultFile[i],ExtractedDataNumbers)+' '
                                          +NewStringByNumbers(DatesDatFile[1],ExtractedDataNumbers)
                                    else tempString:=DatesDatFile[1];
                        tempString:=SomeSpaceToOne(tempString);
                        if not(DarkIV)and(FeBdata) then delIllumParamCalculate(tempString);
                        StringReplaceMy(ResultFile,tempString,i);
                        RowIsFound:=true;
                        Break;
                      end; //if AnsiPos(tempString,ResultFile[i])>0 then
                   end;//for I := 1 to ResultFile.Count - 1 do
                 if not(RowIsFound) then
                    begin
                     if FeBdata then tempString:=tempString+FillString
                                       +NewStringByNumbers(DatesDatFile[1],ExtractedDataNumbers)
                                else tempString:=DatesDatFile[1];
                     if not(DarkIV)and(FeBdata) then delIllumParamCalculate(tempString);
                     ResultFile.Add(tempString);
                    end;
                 DatesDatFile.Delete(1);
                end; //while DatesDatFile.Count>1 do
             end;
          ResultFile.SaveToFile('ResultAll.dat');
         end;
   finally
        FindClose(SR);
        TxtFile.Free;
        DatesDatFile.Free;
        ResultFile.Free;
        nDat.Free;
        n_srhDat.Free;
   end;
end;

procedure TMainForm.BAllDatesDatClick(Sender: TObject);
begin
// AdDataFromDatesDat('D:\Samples\DeepL\FeB\ResultsOlegNew\D15\B1p000e15\T290\iv\Fe\dates.dat');
 SearchInFolders(Result_Folder);
end;

function TMainForm.BaseThickToString: string;
begin
   Result:='D'+IntToStr(round(BaseThick.Data/10));
end;

procedure TMainForm.BDatesDatClick(Sender: TObject);
// var
//    DatesDatFile,ResultFile,TxtFile,
//    nDat,n_srhDat:TStringList;
//    SR : TSearchRec;
//    i,j:integer;
//    fl_name,tempString:string;
//    SRH_file,FeBdata,RowIsFound:boolean;
//    N_FeNumber,N_BNumber,TNumber,dNumber,nNumber:integer;
begin
 OpenDialog2.Filter:='Shottky result file (dates.dat)|dates.dat';
   if OpenDialog2.Execute()
     then
       begin
//         showmessage(OpenDialog2.FileName);
         AdDataFromDatesDat(OpenDialog2.FileName);
//       Directory:=ExtractFilePath(OpenDialog2.FileName);
//       DatesDatFile:=TStringList.Create;
//       ResultFile:=TStringList.Create;
//       TxtFile:=TStringList.Create;
//       nDat:=TStringList.Create;
//       n_srhDat:=TStringList.Create;
//       DatesDatFile.LoadFromFile(OpenDialog2.FileName);
//
//       if FindFirst('*.txt', faAnyFile, SR) = 0 then
//         TxtFile.LoadFromFile(SR.Name)
//                                                else
//         begin
//            showmessage('.txt file is absent');
//            Exit;
//         end;
//       FeBdata:=(AnsiPos('FeB',SR.Name)>0);
//
//       nNumber:=SubstringNumberFromRow('n2',DatesDatFile[0]);
//       N_FeNumber:=SubstringNumberFromRow('TDD',TxtFile[0]);
//       N_BNumber:=SubstringNumberFromRow('N_B',TxtFile[0]);
//       TNumber:=SubstringNumberFromRow('T',TxtFile[0]);
//       dNumber:=SubstringNumberFromRow('d',TxtFile[0]);
//
//       if (nNumber=0)or
//          (N_FeNumber=0)or
//          (N_BNumber=0)or
//          (TNumber=0)or
//          (dNumber=0)
//          then
//         begin
//            showmessage('Wrong file format');
//            Exit;
//         end;
//
//       nDat.Add('N_Fe N_B T d n n_SRH');
//       for I := 1 to DatesDatFile.Count - 1 do
//         begin
//          fl_name:=StringDataFromRow(DatesDatFile[i],2);
//          fl_name:=Copy(fl_name,1,AnsiPos ('.dat', fl_name)-1);
//          SRH_file:=(AnsiPos ('_srh', fl_name)>0);
//          if SRH_file then fl_name:=Copy(fl_name,1,AnsiPos ('_srh', fl_name)-1);
//          for j:=1 to TxtFile.Count - 1 do
//            if AnsiPos(fl_name,TxtFile[j])>0 then
//             begin
//              tempString:=StringDataFromRow(TxtFile[j],N_FeNumber)+
//                          ' '+StringDataFromRow(TxtFile[j],N_BNumber) +
//                          ' '+StringDataFromRow(TxtFile[j],TNumber)+
//                          ' '+StringDataFromRow(TxtFile[j],dNumber)+
//                          ' '+StringDataFromRow(DatesDatFile[i],nNumber);
//              Break;
//             end;
//          if SRH_file then  n_srhDat.Add(tempString)
//                      else  nDat.Add(tempString);
//         end;
//        DatesDatFile.Clear;
//        if FeBdata then DatesDatFile.Add('N_Fe N_B T d n_FeB n_FeB_SRH')
//                   else DatesDatFile.Add('N_Fe N_B T d n_Fe n_Fe_SRH');
//        for I := 1 to nDat.Count - 1 do
//         begin
//          tempString:=StringDataFromRow(nDat[i],1)+
//                      ' '+StringDataFromRow(nDat[i],2)+
//                      ' '+StringDataFromRow(nDat[i],3)+
//                      ' '+StringDataFromRow(nDat[i],4);
//          for j := 0 to n_srhDat.Count - 1 do
//           if AnsiPos(tempString,n_srhDat[j])>0 then
//            begin
//            DatesDatFile.Add(nDat[i]+' '+StringDataFromRow(n_srhDat[j],5));
//            Break;
//            end;
//         end;
//
//        Delete(Directory,Length(Directory),1);
//        tempString:='';
//        for I := Length(Directory) downto 1 do
//          tempString:=tempString+Directory[i];
//        Delete(tempString,1,AnsiPos ('\', tempString)-1);
//        Directory:='';
//        for I := Length(tempString) downto 1 do
//          Directory:=Directory+tempString[i];
//        Delete(Directory,Length(Directory),1);
//        tempString:='';
//        for I := Length(Directory) downto 1 do
//          tempString:=tempString+Directory[i];
//        Delete(tempString,1,AnsiPos ('\', tempString)-1);
//        Directory:='';
//        for I := Length(tempString) downto 1 do
//          Directory:=Directory+tempString[i];
//
//        SetCurrentDir(Directory);
//
//        tempString:='D'+IntToStr(round(strtofloat(StringDataFromRow(DatesDatFile[2],4))*1e5))
//        +'T'+StringDataFromRow(DatesDatFile[2],3)
//        +'B'+NumberToString(strtofloat(StringDataFromRow(DatesDatFile[2],2)));
//        if FeBdata then DatesDatFile.SaveToFile('FB'+tempString+'.dat')
//                   else DatesDatFile.SaveToFile('Fe'+tempString+'.dat');
//
//
//       SetCurrentDir(Result_Folder);
//       if FindFirst('ResultAll.dat', faAnyFile, SR) <> 0 then
//         begin
//           DatesDatFile.SaveToFile('ResultAll.dat');
//         end
//                                                         else
//         begin
//          ResultFile.LoadFromFile(SR.Name);
//          if (AnsiPos('n_FeB',ResultFile[0])>0)and(AnsiPos('n_Fe ',ResultFile[0])>0) then
//             begin
//               while DatesDatFile.Count>1 do
//                begin
//                 tempString:=StringDataFromRow(DatesDatFile[1],1)+
//                      ' '+StringDataFromRow(DatesDatFile[1],2)+
//                      ' '+StringDataFromRow(DatesDatFile[1],3)+
//                      ' '+StringDataFromRow(DatesDatFile[1],4);
//                 RowIsFound:=false;
//                 for I := 1 to ResultFile.Count - 1 do
//                   begin
//                     if AnsiPos(tempString,ResultFile[i])>0 then
//                      begin
//                         if FeBdata then tempString:=tempString+' '+
//                                         StringDataFromRow(ResultFile[i],5)+' '+
//                                         StringDataFromRow(ResultFile[i],6)+' '+
//                                         StringDataFromRow(DatesDatFile[1],5)+' '+
//                                         StringDataFromRow(DatesDatFile[1],6)
//                                    else tempString:=DatesDatFile[1]+' '+
//                                         StringDataFromRow(ResultFile[i],7)+' '+
//                                         StringDataFromRow(ResultFile[i],8);
//                        tempString:=SomeSpaceToOne(tempString);
//                        ResultFile.Delete(i);
//                        ResultFile.Insert(i,tempString);
//                        RowIsFound:=true;
//                        Break;
//                      end; //if AnsiPos(tempString,ResultFile[i])>0 then
//                   end;//for I := 1 to ResultFile.Count - 1 do
//                 if not(RowIsFound) then
//                    begin
//                    if FeBdata then  tempString:=tempString+' 1 1 '+
//                                         StringDataFromRow(DatesDatFile[1],5)+' '+
//                                         StringDataFromRow(DatesDatFile[1],6)
//                               else tempString:=DatesDatFile[1];
//                     ResultFile.Add(tempString);
//                    end;
//                 DatesDatFile.Delete(1);
//                end; //while DatesDatFile.Count>1 do
//             end;
//          if (AnsiPos('n_FeB',ResultFile[0])>0)and(not(AnsiPos('n_Fe ',ResultFile[0])>0)) then
//             begin
//              if not(FeBdata) then
//                begin
//                 ResultFile.Delete(0);
//                 ResultFile.Insert(0,'N_Fe N_B T d n_Fe n_Fe_SRH n_FeB n_FeB_SRH');
//                 for I := 1 to ResultFile.Count - 1 do
//                   begin
//                    tempString:=StringDataFromRow(ResultFile[i],1)+
//                      ' '+StringDataFromRow(ResultFile[i],2)+
//                      ' '+StringDataFromRow(ResultFile[i],3)+
//                      ' '+StringDataFromRow(ResultFile[i],4)+' 1 1 '+
//                      StringDataFromRow(ResultFile[i],5)+' '+
//                      StringDataFromRow(ResultFile[i],6);
//                      ResultFile.Delete(i);
//                      ResultFile.Insert(i,tempString);
//                   end;
//                end;
//              while DatesDatFile.Count>1 do
//                begin
//                 tempString:=StringDataFromRow(DatesDatFile[1],1)+
//                      ' '+StringDataFromRow(DatesDatFile[1],2)+
//                      ' '+StringDataFromRow(DatesDatFile[1],3)+
//                      ' '+StringDataFromRow(DatesDatFile[1],4);
//                 RowIsFound:=false;
//                 for I := 1 to ResultFile.Count - 1 do
//                   begin
//                     if AnsiPos(tempString,ResultFile[i])>0 then
//                      begin
//                         if FeBdata then tempString:=DatesDatFile[1]
//                                    else tempString:=DatesDatFile[1]+' '+
//                                         StringDataFromRow(ResultFile[i],7)+' '+
//                                         StringDataFromRow(ResultFile[i],8);
//                        tempString:=SomeSpaceToOne(tempString);
//                        ResultFile.Delete(i);
//                        ResultFile.Insert(i,tempString);
//                        RowIsFound:=true;
//                        Break;
//                      end; //if AnsiPos(tempString,ResultFile[i])>0 then
//                   end;//for I := 1 to ResultFile.Count - 1 do
//                 if not(RowIsFound) then ResultFile.Add(DatesDatFile[1]);
//                 DatesDatFile.Delete(1);
//                end; //while DatesDatFile.Count>1 do
//             end;
//          if (not(AnsiPos('n_FeB',ResultFile[0])>0))and(AnsiPos('n_Fe ',ResultFile[0])>0) then
//             begin
//              if FeBdata then
//                begin
//                 ResultFile.Delete(0);
//                 ResultFile.Insert(0,'N_Fe N_B T d n_Fe n_Fe_SRH n_FeB n_FeB_SRH')
//                end;
//               while DatesDatFile.Count>1 do
//                begin
//                 tempString:=StringDataFromRow(DatesDatFile[1],1)+
//                      ' '+StringDataFromRow(DatesDatFile[1],2)+
//                      ' '+StringDataFromRow(DatesDatFile[1],3)+
//                      ' '+StringDataFromRow(DatesDatFile[1],4);
//                 RowIsFound:=false;
//                 for I := 1 to ResultFile.Count - 1 do
//                   begin
//                     if AnsiPos(tempString,ResultFile[i])>0 then
//                      begin
//                         if FeBdata then tempString:=tempString+' '+
//                                         StringDataFromRow(ResultFile[i],5)+' '+
//                                         StringDataFromRow(ResultFile[i],6)+' '+
//                                         StringDataFromRow(DatesDatFile[1],5)+' '+
//                                         StringDataFromRow(DatesDatFile[1],6)
//                                    else tempString:=DatesDatFile[1];
//                        tempString:=SomeSpaceToOne(tempString);
//                        ResultFile.Delete(i);
//                        ResultFile.Insert(i,tempString);
//                        RowIsFound:=true;
//                        Break;
//                      end; //if AnsiPos(tempString,ResultFile[i])>0 then
//                   end;//for I := 1 to ResultFile.Count - 1 do
//                 if not(RowIsFound) then
//                    begin
//                    if FeBdata then  tempString:=tempString+' 1 1 '+
//                                         StringDataFromRow(DatesDatFile[1],5)+' '+
//                                         StringDataFromRow(DatesDatFile[1],6)
//                               else tempString:=DatesDatFile[1];
//                     ResultFile.Add(tempString);
//                    end;
//                 DatesDatFile.Delete(1);
//                end; //while DatesDatFile.Count>1 do
//             end;
//          ResultFile.SaveToFile('ResultAll.dat');
//         end;
//        TxtFile.Free;
//        DatesDatFile.Free;
//        ResultFile.Free;
//        nDat.Free;
//        n_srhDat.Free;
       end;
end;

procedure TMainForm.BDatesDatCorrectClick(Sender: TObject);
 var //Direc:string;
    DatesDatFile,ResultFile:TStringList;
    SR : TSearchRec;
    i,j:integer;
    tempString:string;
begin
 OpenDialog1.Filter:='Shottky result file (dates.dat)|dates.dat';
   if OpenDialog1.Execute()
     then
       begin
       Directory:=ExtractFilePath(OpenDialog1.FileName);
       DatesDatFile:=TStringList.Create;
       ResultFile:=TStringList.Create;
       DatesDatFile.LoadFromFile(OpenDialog1.FileName);

        Delete(Directory,Length(Directory),1);
        tempString:='';
        for I := Length(Directory) downto 1 do
          tempString:=tempString+Directory[i];
        Delete(tempString,1,AnsiPos ('\', tempString)-1);
        Directory:='';
        for I := Length(tempString) downto 1 do
          Directory:=Directory+tempString[i];
        SetCurrentDir(Directory);
       if FindFirst('dates.dat', faAnyFile, SR) <> 0 then
         begin
            showmessage('dates.dat in up-directory is absent');
            Exit;
         end                                         else
         begin
           ResultFile.LoadFromFile(SR.Name);
           for I := 1 to DatesDatFile.Count - 1 do
                for j := 1 to ResultFile.Count - 1 do
                    if StringDataFromRow(DatesDatFile[i],1)=
                       StringDataFromRow(ResultFile[j],1)   then
                      begin
                        ResultFile.Delete(j);
                        ResultFile.Insert(j,DatesDatFile[i]);
                      end;
          ResultFile.SaveToFile('dates.dat');
         end;
        DatesDatFile.Free;
        ResultFile.Free;
       end;
end;

procedure GradFileTitleCreate(SL:TStringList);
begin
  SL.Clear;
  SL.Add('interpolation: linear');
  SL.Add('');
  SL.Add('x (micrometer)	Nt (1/m3)');
end;

procedure TMainForm.BFeB_xClick(Sender: TObject);
 var //Direc:string;
     EB_File,FeGRDFile,FeBGRDFile,FeGRDFilePP,FeBGRDFilePP:TStringList;
     Vec:TVector;
     Row:Int64;
     i,j:word;
     T:word;
     delFe,Nfe:double;
     tempstr:string;

begin
 OpenDialog1.InitialDir:=SCAPS_Folder+'\results';
 OpenDialog1.FileName:='';
 OpenDialog1.Filter:='File with energy bands (*.eb)|*.eb';
 if OpenDialog1.Execute()
   then
     begin
      Directory:=ExtractFilePath(OpenDialog1.FileName);
      EB_File:=TStringList.Create;
      FeGRDFile:=TStringList.Create;
      FeBGRDFile:=TStringList.Create;
      FeGRDFilePP:=TStringList.Create;
      FeBGRDFilePP:=TStringList.Create;
      EB_File.LoadFromFile(OpenDialog1.FileName);
      SetCurrentFolders;

      Vec:=TVector.Create;
      Row:=0;
      T:=0;
      IVparameter.SCAPSFileNameDetermination(EB_File);


      while (Row<EB_File.Count) do
       begin
        if AnsiPos ('Temperature', EB_File[ROW])>0 then
          T:=round(FloatDataFromRow(EB_File[ROW],2));

        if AnsiPos ('x(um)', EB_File[ROW])>0 then
          begin
            Row:=Row+2;
            for I := 0 to 199 do
             begin
//               Vec.Add(290+FloatDataFromRow(EB_File[ROW],2),-FloatDataFromRow(EB_File[ROW],7));
               if i>149 then
               Vec.Add(BaseThick.Data-10+FloatDataFromRow(EB_File[ROW],2),-FloatDataFromRow(EB_File[ROW],7))
                         else
               Vec.Add(FloatDataFromRow(EB_File[ROW],2),-FloatDataFromRow(EB_File[ROW],7));

               Inc(ROW);
             end;
            Break;
          end;
         Inc(ROW);
       end;
//      Vec.DeleteDuplicate;
      SetTemperatureFolders(T);
      Vec.WriteToFile('Ef_'+PartOfFileNameCreate(T)+'.dat',10);
      while not (SetCurrentDir(GetCurrentDir + '\grd')) do
        MkDir('grd');


      for I := 0 to Vec.HighNumber do
       Vec.Y[i]:=Nfeb(Boron.Data,T,Vec.Y[i]);

      if FeStepNumber.Data>1 then delFe:=(Log10(FeHi.Data)-Log10(FeLow.Data))/(FeStepNumber.Data-1)
                             else delFe:= Log10(FeHi.Data);
      Nfe:=Log10(FeLow.Data);
      j:=0;
      repeat
        GradFileTitleCreate(FeGRDFile);
        GradFileTitleCreate(FeBGRDFile);
        GradFileTitleCreate(FeGRDFilePP);
        GradFileTitleCreate(FeBGRDFilePP);

//        FeGRDFile.Clear;
//        FeBGRDFile.Clear;
//        FeGRDFile.Add('interpolation: linear');
//        FeGRDFile.Add('');
//        FeGRDFile.Add('x (micrometer)	Nt (1/m3)');
//
//        FeBGRDFile.Add('interpolation: linear');
//        FeBGRDFile.Add('');
//        FeBGRDFile.Add('x (micrometer)	Nt (1/m3)');
//
//        FeGRDFilePP.Clear;
//        FeBGRDFilePP.Clear;
//        FeGRDFilePP.Add('interpolation: linear');
//        FeGRDFilePP.Add('');
//        FeGRDFilePP.Add('x (micrometer)	Nt (1/m3)');
//
//        FeBGRDFilePP.Add('interpolation: linear');
//        FeBGRDFilePP.Add('');
//        FeBGRDFilePP.Add('x (micrometer)	Nt (1/m3)');

        for I := 0 to 99 do
         begin
          FeBGRDFile.Add(FloatToStrF(Vec.X[i+100]-1,ffExponent,10,2)+'	'+
                        FloatToStrF(Vec.Y[i+100]*Power(10,Nfe)*1e6,ffExponent,8,2));
          FeGRDFile.Add(FloatToStrF(Vec.X[i+100]-1,ffExponent,10,2)+'	'+
                        FloatToStrF((1-Vec.Y[i+100])*Power(10,Nfe)*1e6,ffExponent,8,2));
          FeBGRDFilePP.Add(FloatToStrF(Vec.X[i],ffExponent,10,2)+'	'+
                        FloatToStrF(Vec.Y[i]*Power(10,Nfe)*1e6,ffExponent,8,2));
          FeGRDFilePP.Add(FloatToStrF(Vec.X[i],ffExponent,10,2)+'	'+
                        FloatToStrF((1-Vec.Y[i])*Power(10,Nfe)*1e6,ffExponent,8,2));
         end;
//        tempstr:= LowerCase(floattostrF(Power(10,Nfe),ffExponent,4,2));
//        tempstr:=AnsiReplaceStr(tempstr,'.','p');
//        tempstr:=AnsiReplaceStr(tempstr,'+','');
//        FeBGRDFile.SaveToFile('FeB'+tempstr+'.grd');
//        FeGRDFile.SaveToFile('Fe'+tempstr+'.grd');
        tempstr:=IntToStr(j);
        if j<10 then tempstr:='0'+tempstr;

        FeBGRDFile.SaveToFile('B'+tempstr+'.grd');
        FeGRDFile.SaveToFile('F'+tempstr+'.grd');
        FeBGRDFilePP.SaveToFile('P'+tempstr+'.grd');
        FeGRDFilePP.SaveToFile('S'+tempstr+'.grd');

//        if SetCurrentDir(SCAPS_Folder+'\grading\') then
//           begin
            FeBGRDFile.SaveToFile(SCAPS_Folder+'\grading\'+'B'+tempstr+'.grd');
            FeGRDFile.SaveToFile(SCAPS_Folder+'\grading\'+'F'+tempstr+'.grd');
            FeBGRDFilePP.SaveToFile(SCAPS_Folder+'\grading\'+'P'+tempstr+'.grd');
            FeGRDFilePP.SaveToFile(SCAPS_Folder+'\grading\'+'S'+tempstr+'.grd');
//           end;
        Nfe:=Nfe+delFe;
        inc(j);
      until (Nfe>Log10(FeHi.Data*1.0001));

      Vec.Free;
      EB_File.Free;
      FeGRDFile.Free;
      FeBGRDFile.Free;
      FeGRDFilePP.Free;
      FeBGRDFilePP.Free;
     end;
end;

//procedure TMainForm.BMaterialFileCreateClick(Sender: TObject);
// var nSiLayer,pSiLayer,Defect,SBFLayer:TStringList;
//     T:integer;
//     tempstr,tempBody,tempFooter:string;
//     dFei,dFeBd,dFeBa:TDefect;
//begin
//// showmessage(floattostr(Boron.Data));
//
//
// Defect:=TStringList.Create;
// Defect.Clear;
// T:=TempStart.Data;
//
// dFei:=TDefect.Create(Fei);
// dFeBd:=TDefect.Create(FeB_don);
// dFeBa:=TDefect.Create(FeB_ac);
// tempstr:='                   '+dFei.Name;
// tempstr:=tempstr+'                                            '+'FeB '+dFeBa.DefectType;
// tempstr:=tempstr+'                                     '+'FeB '+dFeBd.DefectType;
// Defect.Add(tempstr);
// tempstr:='T        sig_n       sig_p       Ev+Et';
// tempstr:=tempstr+'        sig_n       sig_p     Ec-Et';
// tempstr:=tempstr+'       sig_n       sig_p    Ec-Et(p)   Ec-Et(p+)';
// Defect.Add(tempstr);
// repeat
//  tempstr:=inttostr(T)+'  ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFei.Sn(T)*1e4,ffExponent,4,2))+'  ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFei.Sp(T)*1e4,ffExponent,4,2))+'  ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFei.Et,ffFixed,5,3))+'    ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFeBa.Sn(T)*1e4,ffExponent,4,2))+'  ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFeBa.Sp(T)*1e4,ffExponent,4,2))+'  ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFeBa.Et,ffFixed,5,3))+'   ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFeBd.Sn(T)*1e4,ffExponent,4,2))+'  ';
//  tempstr:=tempstr+LowerCase(floattostrf(dFeBd.Sp(T)*1e4,ffExponent,4,2))+'  ';
//  tempstr:=tempstr+LowerCase(floattostrf(Silicon.Eg(T)-Silicon.BGN(Boron.Data*1e6,False)-dFeBd.Et,ffFixed,5,3));
//  tempstr:=tempstr+'        '+LowerCase(floattostrf(Silicon.Eg(T)-Silicon.BGN(BSFCon.Data*1e6,False)-dFeBd.Et,ffFixed,5,3));
//  Defect.Add(tempstr);
//
//  T:=T+TempStep.Data;
// until (T>TempFinish.Data);
// dFei.Free;
// dFeBd.Free;
// dFeBa.Free;
// Defect.SaveToFile('defect.bdf');
// Defect.Free;
//
//
// nSiLayer:=TStringList.Create;
// pSiLayer:=TStringList.Create;
// SBFLayer:=TStringList.Create;
// T:=TempStart.Data;
//
// repeat
//  nSiLayer.Clear;
//  pSiLayer.Clear;
//  SBFLayer.Clear;
//  nSiLayer.Add('material name : n_Si');
//  pSiLayer.Add('material name : p_Si');
//  SBFLayer.Add('material name : p+_Si');
//
//  {� SCAPS ������ ��������, � ����� ������� ����� � �����, ����������
//  ��������� �� ����������� � ������� �������� �� �������� ��� 300 � }
//  tempBody:='	 1.000e+01	 1.000e+01	 1.000e+01	 ';
//  tempFooter:='	 0	 0	[cm/s]';
//  tempstr:=LowerCase(floattostrF( Silicon.Vth_n(T)*100,ffExponent,4,2));
//  tempstr:=tempstr+'	 '+tempstr+tempBody+
//    tempstr+'	 '+tempstr+tempFooter;
//  nSiLayer.Add('v_th_n :	 '+tempstr);
//  pSiLayer.Add('v_th_n :	 '+tempstr);
//  SBFLayer.Add('v_th_n :	 '+tempstr);
//
//  tempstr:=LowerCase(floattostrF( Silicon.Vth_p(T)*100,ffExponent,4,2));
//  tempstr:=tempstr+'	 '+tempstr+tempBody+tempstr+'	 '+tempstr+tempFooter;
//  nSiLayer.Add('v_th_p :	 '+tempstr);
//  pSiLayer.Add('v_th_p :	 '+tempstr);
//  SBFLayer.Add('v_th_p :	 '+tempstr);
//
//  tempstr:='eps :	    11.900000	    11.900000	    1.000000	    10.000000	    10.000000	    11.900000	    11.900000	 0	 0	[-]';
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//  tempstr:='chi :	  4.050000	  4.050000	  0.100000	  1.000000	  1.000000	  4.050000	  4.050000	 0	 0	[eV]';
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//  tempBody:='	  0.100000	  1.000000	  1.000000	  ';
//  tempFooter:='	 0	 0	[eV]';
//  tempstr:=LowerCase(floattostrF( Silicon.Eg(T)-Silicon.BGN(EmiterCon.Data*1e6,True),ffFixed,7,6));
//  nSiLayer.Add('Eg :	  '+tempstr+'	  '+tempstr+tempBody+
//      tempstr+'	  '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.Eg(T)-Silicon.BGN(Boron.Data*1e6,False),ffFixed,7,6));
//  pSiLayer.Add('Eg :	  '+tempstr+'	  '+tempstr+tempBody+
//      tempstr+'	  '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.Eg(T)-Silicon.BGN(BSFCon.Data*1e6,False),ffFixed,7,6));
//  SBFLayer.Add('Eg :	  '+tempstr+'	  '+tempstr+tempBody+
//      tempstr+'	  '+tempstr+tempFooter);
//
//  tempBody:='	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
//  tempFooter:='	 0	 0	[/cm^3]';
//  tempstr:=LowerCase(floattostrF( Silicon.Nc(T)*Power((300/T),1.5)/1e6,ffExponent,7,2));
//{� �������� ��� ������������ ��������� ������ ����� �������������� ���� ������, ��
//1,5, ��� ����������� SCAPS. ���� ��� ����, ��� �������� ��������������� ��������
//��������, ������ �� �������� ��� 300 � ����, ��� ��� �������� ��������� (T/300)^1.5
//�������� ��������, ��� �������}
//  tempstr:='Nc :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter;
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//  tempstr:=LowerCase(floattostrF( Silicon.Nv(T)*Power((300/T),1.5)/1e6,ffExponent,7,2));
//  tempstr:='Nv :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter;
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//  tempBody:='	 1.000000e-03	 1.000000e+00	 1.000000e+00	 ';
//  tempFooter:='	 0	 0	[cm^2/Vs]';
//  tempstr:=LowerCase(floattostrF( Silicon.mu_n(T,EmiterCon.Data*1e6,True)*1e4,ffExponent,7,2));
//  nSiLayer.Add('mu_n :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF(Silicon.mu_p(T,EmiterCon.Data*1e6,False)*1e4,ffExponent,7,2));
//  nSiLayer.Add('mu_p :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//
//  tempstr:=LowerCase(floattostrF( Silicon.mu_n(T,Boron.Data*1e6,False)*1e4,ffExponent,7,2));
//  pSiLayer.Add('mu_n :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.mu_p(T,Boron.Data*1e6,True)*1e4,ffExponent,7,2));
//  pSiLayer.Add('mu_p :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//
//  tempstr:=LowerCase(floattostrF( Silicon.mu_n(T,BSFCon.Data*1e6,False)*1e4,ffExponent,7,2));
//  SBFLayer.Add('mu_n :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.mu_p(T,BSFCon.Data*1e6,True)*1e4,ffExponent,7,2));
//  SBFLayer.Add('mu_p :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//
//  tempBody:='	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
//  tempFooter:='	 0	 2	[/cm^3]';
//
//  tempstr:=LowerCase(floattostrF(EmiterCon.Data,ffExponent,7,2));
//  nSiLayer.Add('Nd(uniform) :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//
//  tempstr:='0.000000e+00';
//  pSiLayer.Add('Nd(uniform) :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  SBFLayer.Add('Nd(uniform) :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//  nSiLayer.Add('Na(uniform) :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF(Boron.Data,ffExponent,7,2));
//  pSiLayer.Add('Na(uniform) :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF(BSFCon.Data,ffExponent,7,2));
//  SBFLayer.Add('Na(uniform) :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//  tempstr:='Tunneling in layer: 1 (0: no tunneling, 1: with tunneling)';
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//  tempstr:=LowerCase(floattostrF( Silicon.Meff_e(T),ffExponent,7,2));
//  tempBody:='	 1.000000e+00	 1.000000e+00	 1.000000e+00	 ';
//  tempFooter:='	 0	 0	[-]';
//  tempstr:='Relative electron mass :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter;
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//  tempstr:=LowerCase(floattostrF( Silicon.Meff_h(T),ffExponent,7,2));
//  tempstr:='Relative hole mass :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter;
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//  tempstr:=LowerCase(floattostrF( Silicon.Brad(T)*1e6,ffExponent,7,2));
//  tempBody:='	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
//  tempFooter:='	 0	 0	[cm^3/s]';
//  tempstr:='K_rad :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter;
//  nSiLayer.Add(tempstr);
//  pSiLayer.Add(tempstr);
//  SBFLayer.Add(tempstr);
//
//
//  tempBody:='	 1.000000e+01	 1.000000e+01	 1.000000e+01	 ';
//  tempFooter:='	 0	 0	[cm^6/s]';
//  tempstr:=LowerCase(floattostrF( Silicon.Cn_Auger(EmiterCon.Data*1e6,T)*1e12,ffExponent,7,2));
//  nSiLayer.Add('c_n_auger :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.Cn_Auger(Silicon.MinorityN(Boron.Data*1e6),T)*1e12,ffExponent,7,2));
//  pSiLayer.Add('c_n_auger :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.Cn_Auger(Silicon.MinorityN(BSFCon.Data*1e6),T)*1e12,ffExponent,7,2));
//  SBFLayer.Add('c_n_auger :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//
//  tempstr:=LowerCase(floattostrF( Silicon.Cp_Auger(Silicon.MinorityN(EmiterCon.Data*1e6),T)*1e12,ffExponent,7,2));
//  nSiLayer.Add('c_p_auger :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.Cp_Auger(Boron.Data*1e6,T)*1e12,ffExponent,7,2));
//  pSiLayer.Add('c_p_auger :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//  tempstr:=LowerCase(floattostrF( Silicon.Cp_Auger(BSFCon.Data*1e6,T)*1e12,ffExponent,7,2));
//  SBFLayer.Add('c_p_auger :	 '+tempstr+'	 '+tempstr+tempBody+
//      tempstr+'	 '+tempstr+tempFooter);
//
//
//  nSiLayer.Add('absorption grading :	 1107.12	 1107.12	  250.00	  250.00	    0.00	 1107.12	 1107.12	 0	 0	[nm]');
//  nSiLayer.Add('absorptionmodel pure A material (y=0) : from file');
//  nSiLayer.Add('absorptionfile pure A material (y=0) : Si.abs');
//  nSiLayer.Add('absorption pure B material (y=1), model : from file');
//  nSiLayer.Add('absorption pure B material (y=1), file : Si.abs');
//
//  pSiLayer.Add('absorption grading :	 1107.12	 1107.12	  250.00	  250.00	    0.00	 1107.12	 1107.12	 0	 0	[nm]');
//  pSiLayer.Add('absorptionmodel pure A material (y=0) : from file');
//  pSiLayer.Add('absorptionfile pure A material (y=0) : Si.abs');
//  pSiLayer.Add('absorption pure B material (y=1), model : from file');
//  pSiLayer.Add('absorption pure B material (y=1), file : Si.abs');
//
//  SBFLayer.Add('absorption grading :	 1107.12	 1107.12	  250.00	  250.00	    0.00	 1107.12	 1107.12	 0	 0	[nm]');
//  SBFLayer.Add('absorptionmodel pure A material (y=0) : from file');
//  SBFLayer.Add('absorptionfile pure A material (y=0) : Si.abs');
//  SBFLayer.Add('absorption pure B material (y=1), model : from file');
//  SBFLayer.Add('absorption pure B material (y=1), file : Si.abs');
//
//
//  nSiLayer.SaveToFile('nSi_'+BaseThickToString+'T'+inttostr(T)+NBoronToString+'.material');
//  pSiLayer.SaveToFile('pSi_'+BaseThickToString+'T'+inttostr(T)+NBoronToString+'.material');
//  SBFLayer.SaveToFile('ppSi_'+BaseThickToString+'T'+inttostr(T)+NBoronToString+'.material');
//
//  T:=T+TempStep.Data;
// until (T>TempFinish.Data);
//
//
// nSiLayer.Free;
// pSiLayer.Free;
//end;

procedure TMainForm.FoldersToForm;
begin
 L_SCAPSF.Caption:=SCAPS_Folder;
 L_ResF.Caption:=Result_Folder;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FormatSettings.DecimalSeparator:='.';
//  DecimalSeparator:='.';
  SCAPSFile:=TStringList.Create;
  SCAPSFile.Sorted:=False;
   ConfigFile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'SCapsConv.ini');
  TempStart:=TIntegerParameterShow. Create(STTemp_start,LTemp_start,'Start:',290);
  TempStart.SetName('Temperature');
  TempStart.ReadFromIniFile(ConfigFile);
  TempFinish:=TIntegerParameterShow. Create(STTemp_Finish,LTemp_Finish,'Finish:',340);
  TempFinish.SetName('Temperature');
  TempFinish.ReadFromIniFile(ConfigFile);
  TempStep:=TIntegerParameterShow. Create(STTemp_Step,LTemp_Step,'Step:',5);
  TempStep.SetName('Temperature');
  TempStep.ReadFromIniFile(ConfigFile);
  Boron:=TDoubleParameterShow. Create(STBoron,'Boron',1e10,5);
  Boron.SetName('SC');
  Boron.ReadFromIniFile(ConfigFile);
  EmiterCon:=TDoubleParameterShow. Create(STEmiter_Con,'Phosphorus',1e19,3);
  EmiterCon.SetName('SC');
  EmiterCon.ReadFromIniFile(ConfigFile);
  BSFCon:=TDoubleParameterShow. Create(STSBF_Con,'BSFBoron',5e18,3);
  BSFCon.SetName('SC');
  BSFCon.ReadFromIniFile(ConfigFile);
  EmiterThick:=TDoubleParameterShow. Create(STEmiter_Thick,'EmiterThick',0.5,3);
  EmiterThick.SetName('SC');
  EmiterThick.ReadFromIniFile(ConfigFile);
  BSFThick:=TDoubleParameterShow. Create(STSBF_Thick,'SBFThick',1.0,3);
  BSFThick.SetName('SC');
  BSFThick.ReadFromIniFile(ConfigFile);
  BaseThick:=TIntegerParameterShow. Create(STBase_Thick,LSBF_Thick, 'Thickness (mkm)',180);
  BaseThick.SetName('SC');
  BaseThick.ReadFromIniFile(ConfigFile);



  FeLow:=TDoubleParameterShow. Create(STFe_Lo,LFe_Lo,'Low limit:',1e10,5);
  FeLow.SetName('Iron');
  FeLow.ReadFromIniFile(ConfigFile);
  FeHi:=TDoubleParameterShow. Create(STFe_Hi,LFe_Hi,'High limit:',1e13,5);
  FeHi.SetName('Iron');
  FeHi.ReadFromIniFile(ConfigFile);
  FeStepNumber:=TIntegerParameterShow. Create(STFe_steps,LFe_steps,'Step Number:',19);
  FeStepNumber.SetName('Iron');
  FeStepNumber.ReadFromIniFile(ConfigFile);


  SCAPS_Folder:=ConfigFile.ReadString('Folders','SCAPS',GetCurrentDir);
  Result_Folder:=ConfigFile.ReadString('Folders','Results',GetCurrentDir);
  FoldersToForm();

  IVparameter:=TIVparameter.Create;

 Diod:=TDiod_Schottky.Create;
// Diod.ReadFromIniFile(ConfigFile);
 Diod.Semiconductor.Material:=TMaterial.Create(Si);

// ChangeMaterial(Si);

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin

 ConfigFile.EraseSection('Temperature');
 ConfigFile.EraseSection('SC');
 ConfigFile.EraseSection('Iron');
 ConfigFile.EraseSection('Folders');

  ConfigFile.WriteString('Folders','SCAPS',SCAPS_Folder);
  ConfigFile.WriteString('Folders','Results',Result_Folder);


  Boron.WriteToIniFile(ConfigFile);
  Boron.Free;
  EmiterCon.WriteToIniFile(ConfigFile);
  EmiterCon.Free;
  BSFCon.WriteToIniFile(ConfigFile);
  BSFCon.Free;
  EmiterThick.WriteToIniFile(ConfigFile);
  EmiterThick.Free;
  BSFThick.WriteToIniFile(ConfigFile);;
  BSFThick.Free;
  BaseThick.WriteToIniFile(ConfigFile);;
  BaseThick.Free;

  TempFinish.WriteToIniFile(ConfigFile);
  TempFinish.Free;
  TempStep.WriteToIniFile(ConfigFile);
  TempStep.Free;
  TempStart.WriteToIniFile(ConfigFile);
  TempStart.Free;
  FeLow.WriteToIniFile(ConfigFile);
  FeLow.Free;
  FeHi.WriteToIniFile(ConfigFile);
  FeHi.Free;
  FeStepNumber.WriteToIniFile(ConfigFile);
  FeStepNumber.Free;
//  Diod.WriteToIniFile(ConfigFile);
  IVparameter.Free;
  Diod.Semiconductor.Material.Free;
  Diod.Free;
  ConfigFile.Free;
  SCAPSFile.Free;
end;

function TMainForm.NBoronToString: string;
begin
  Result:='B'+NumberToString(Boron.Data);
end;

function TMainForm.Nfeb(Nb, T, Ef: double): double;
begin
  Result:=Nb*1e-23*exp(0.582/Kb/T)/(1+Nb*1e-23*exp(0.582/Kb/T))
                  /(1+exp((Ef-0.394)/Kb/T));
end;




function TMainForm.PartOfFileNameCreate(T: integer): string;
begin
 Result:=BaseThickToString+'T'+inttostr(T)+NBoronToString;
end;


function TMainForm.SearchInFolders(StartFolder: string): string;
 var sr: TSearchRec;
begin
  Result:='';
  if FindFirst(StartFolder+'\*.*', faAnyFile,SR) <> 0 then Exit;
  repeat
    if (((SR.Attr and faDirectory) = SR.Attr)
     and (SR.Name <> '.') and (SR.Name <> '..'))
      then
          begin
            SearchInFolders(StartFolder+'\'+SR.Name);
          end;
    if (SR.Name ='dates.dat')and(RGIllumination.ItemIndex=0)
      then AdDataFromDatesDat(StartFolder+'\'+SR.Name);
    if ((SR.Name ='Fe.txt')or((SR.Name ='FeB.txt')))and(RGIllumination.ItemIndex>0)
      then AdDataFromDatesDat(StartFolder+'\'+SR.Name);

  until FindNext(SR) <> 0;
  FindClose(SR);

end;


procedure TMainForm.SetCurrentFolders;
var
  tempStr: string;
begin
  while not (SetCurrentDir(SCAPS_Folder)) do
    B_SCAPSFSelectClick(nil);
  while not (SetCurrentDir(Result_Folder)) do
    B_ResFSelectClick(nil);
  tempStr := Result_Folder + '\' + BaseThickToString;
  while not (SetCurrentDir(tempSTR)) do
    MkDir(BaseThickToString);
  tempStr := tempStr + '\' + NBoronToString;
  while not (SetCurrentDir(tempSTR)) do
    MkDir(NBoronToString);
end;

procedure TMainForm.SetTemperatureFolders(T: Integer);
 Var  tempStr:string;
begin
  tempStr := Result_Folder + '\' + BaseThickToString + '\' + NBoronToString;
  SetCurrentDir(tempStr);
  while not (SetCurrentDir(tempSTR + '\' + 'T' + inttostr(T))) do
    MkDir('T' + inttostr(T));
end;

procedure TMainForm.StringReplaceMy(StringList: TStringList; Str: string;
  IndexOfString: integer);
begin
  try
  if (StringList.Count-1)<IndexOfString then Exit;
  StringList.Delete(IndexOfString);
  StringList.Insert(IndexOfString,Str);
  finally

  end;
end;

//function TMainForm.NumberToString(Number: double; DigitNumber: word): string;
//begin
//  Result:=LowerCase(floattostrF(Number,ffExponent,DigitNumber,2));
//  Result:=EditString(Result);
////  Result:=AnsiReplaceStr(Result,'.','p');
////  Result:=AnsiReplaceStr(Result,'+','');
//end;

end.
