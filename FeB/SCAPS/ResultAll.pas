unit ResultAll;

interface

uses
  Classes,OlegFunction,SomeFunction,OlegMath, OlegType;

type TArguments=(aFe,aB,aT,aD);
     TExtractedDataDark=(edn2);
//     TExtractedDataLight=(edVoc,edIsc,edFF,edEta);
     TExtractedDataLight=(edVoc,edIsc,edFF,edEta,edVmp,edImp);

const
      DirectoryNames:array[TArguments]of string=
      ('Iron','Boron','Temperature','Thickness');
      ShortDirectoryNames:array[TArguments]of string=
       ('Fe','Bo','T','d');
      FileHeaderNames:array[TArguments]of string=
       ('N_Fe','N_B','T','d');
//      FileHeaderNew='nFsrh nFBsrh dnsrh nF nFB dn dnF dnFB';
      FileHeaderNew='JscF EtaF VocF FFF JscFB EtaFB VocFB FFFB eJsc eEta eVoc eFF';

      ParametersNames:array[TArguments]of string=
       ('N_Fe','N_B','T','d');
      ParametersPsevdo:array[TArguments]of string=
       ('TDD','N_B','T','d');

      ExtractedDataDarkNames:array[TExtractedDataDark]of string=
      ('n');
//      ExtractedDataLightNames:array[TExtractedDataLight]of string=
//      ('Jsc', 'Eta','Voc','FF');
      ExtractedDataLightNames:array[TExtractedDataLight]of string=
      ('Jsc', 'Eta','Voc','FF','Vmp', 'Jmp');
      ExtractedDataDarkPsevdo:array[TExtractedDataDark]of string=('n2');
//      ExtractedDataLightPsevdo:array[TExtractedDataLight]of string=
//      ('Jsc','eta','Voc','FF');
      ExtractedDataLightPsevdo:array[TExtractedDataLight]of string=
      ('Jsc','eta','Voc','FF','Vmpp', 'Jmpp');

type

 TArrayKeyStringList=class
 private
  function GetCount:word;
  procedure Initiate;
 public
  Keys:array of string;
  StringLists:array of TStringList;
  property Count:word read GetCount;
  Constructor Create();
  function KeyIsPresent(Key:string):boolean;
  procedure AddKey(Key,SringKey:string);
  procedure AddKeysFromStringList(StringList:TStringList;PartNumber:word);
  procedure KeysAndListsToStringList(StringList:TStringList);
  procedure Free;
  procedure Clear;
  procedure SortingByKeyValue();
  procedure CreateDirByKeys(Sault:string);
  procedure DataConvert();
 end;

TKeyStrList=class
{���������� �������� ���� ���������������� ResultAll.dat
� KeysName ����� ��������� ('Fe','Bo','T','d')
� Keys[i] - �������� ����� ���������
� StringLists[i] - ����� �� ���� �������� �����������,
����� ��������� � ����� ���� ��������� ������ Keys[i];
StringHeader - ��������� �����  ResultAll.dat  �� �����������  KeysName
}
 private
  function GetCount:word;
  function GetSList(index:integer):TStringList;
  function GetSListNumber: integer;
 public
  KeysName:string;
  StringHeader:string;
  Keys:array of string;
  StringLists:array of TStringList;
  property Count:word read GetCount;
  property SList[index:integer]:TStringList read GetSList;
  property SListHighNumber:integer read GetSListNumber;
  class function KeysNameDetermine(fileHeader:string):string;
  {���� fileHeader  ���� �  ('N_Fe','N_B','T','d'),
  �� �����������  �������� �  ('Fe','Bo','T','d');
  ������ "None";
  �������� ��� ���� ��� ������������ ��������� �������
  � ������� ��'� ��������}
  class function ShortDirNameToDirName(KeysName:string):string;
  {������ ���� � ('Fe','Bo','T','d')
  ������� ���� � ('Iron','Boron','Temperature','Thickness')}
  class function PartOfDataFileName(Key:string):string;
  {������������ �������� ���������, ���������� � ������
  �����, � �� ��������� ��������, �� �������� � ����� �����
  ��� ��������}
  procedure AddKey(Key,SringKey:string);
  {���� Key ��� � � ����� Keys,
  �� SringKey �������� � ��������� StringLists,
  ������ Key �������� �� Keys � �����������
  �� ���� StringLists � ������ SringKey;
  ���� �������� ��������� ������� �� �����
  �� ����������� (���������� ����� "Result.all"),
  �� ������������  KeysName �� StringHeader}
  procedure AddKeysFromStringList(StringList:TStringList;PartNumber:word);
  {��������, �� � ������� PartNumber (���������
  � �������) StringList ����������� �����,
  ����������� ������ ����� ����-���� �����
  �� ��������� ������� AddKey}
  procedure SortingByKeyValue();
  {� Keys �������� �� ���������;
  � StringLists ����� ������������ ������ ��������}
  procedure DataConvert(StartPosition:word=0);
  procedure KeysAndListsToStringList(StringList:TStringList);
  {Keys[i] �� ������� ����, ��� �������� � StringLists[i],
  ������ ����� ��������� ����� ������ ��������� ���������}
  procedure ShowKeys();
  procedure ShowStringList(Number:integer);
  procedure TCtoStringList(SL: TStringList; T0: Double=300);
  {�������, �� � ��� StringLists ���� ������������ ���������
  � �������� � SL ���� ������������ ����������� �� �������� Keys;
  � ������ ������� SL �������}
end;



TArrKeyStrList=class
{�� ��������� ���� ���� ResultAll.dat,
�������� �� �������, ������� ���� �������
������� ��������� - ��������� 4 (Fe, Bo, T, d),
�� ������� ����������� �  ArrKeyStrList[i];
� ��������  fChields �����������
������ �� �������� ������� ���� ����� �������:
�������� � ArrKeyStrList[i].StringLists[j]
����������� ���-���� ResultAll.dat �
��� �� ����������� �� ����������;
������ ����������, ���� ����������
���� ���� �������� � ����������� ��������,
� ���������� ������� ���� �������� ������� � ArrKeyStrList
}
 public
// private
  ArrKeyStrList:array of TKeyStrList;
  fFileNamePart:string;
  fChields:array of TArrKeyStrList;
  DirectoryPath:string;
  {����, ���� ������ ������������ �����}
  fArgumentNumber:integer;
// public
//  ArrKeyStrList:array of TKeyStrList;
  Constructor Create(SL:TStringList;
                     DataNumber:integer=4;
    {DataNumber - ������� �������, �� ���������������,
    �� ������������� - ������ �������� ������� �����������}
                     FolderName:string='';
                     FileNamePart:string='');
 destructor Destroy;override;
 procedure ShowKeysNames;
 procedure ShowKeys;
 procedure ShowChieldsNumber;
 procedure ShowArrKeyStrListNumber;
 procedure ShowInformation;
 procedure SaveData;
end;

Procedure delIllumParamCalculate(var str:string);
{���������, �� str �� ������
'N_Fe _B T d Isc_Fe Eta_Fe Voc_Fe FF_Fe Isc_FeB Eta_FeB Voc_FeB FF_FeB'
� �������������� �� ����������� � ��� �� �����
������� ���� (P_FeB-P_Fe)/P_FeB}

implementation

uses
  Dialogs, SysUtils, StrUtils;

{ TArrayKeyStringList }

procedure TArrayKeyStringList.AddKey(Key, SringKey: string);
 var i:integer;
begin
// showmessage(inttostr(High(Keys)));
 for I := 0 to High(Keys) do
   if Key=Keys[i] then
    begin
      StringLists[i].Add(SringKey);
      Exit;
    end;
 SetLength(Keys,High(Keys)+2);
 SetLength(StringLists,High(StringLists)+2);
 StringLists[High(StringLists)]:=TStringList.Create;
 Keys[High(Keys)]:=Key;
 StringLists[High(StringLists)].Add(SringKey);
end;

procedure TArrayKeyStringList.AddKeysFromStringList(StringList: TStringList;
  PartNumber: word);
 var i:integer;
begin
  for I := 0 to StringList.Count - 1 do
     AddKey(StringDataFromRow(StringList[i],PartNumber),
             DeleteStringDataFromRow(StringList[i],PartNumber));
end;

procedure TArrayKeyStringList.Clear;
begin
 Free;
 Initiate;
end;

procedure TArrayKeyStringList.Initiate;
begin
  SetLength(Keys, 0);
  SetLength(StringLists, 0);
end;

constructor TArrayKeyStringList.Create;
begin
 inherited Create;
 Initiate;
end;

procedure TArrayKeyStringList.CreateDirByKeys(Sault:string);
 var i:integer;
begin
 for I := 0 to Count-1 do
   CreateDirSafety(Sault+
                EditString(Keys[i]));
end;

procedure TArrayKeyStringList.DataConvert;
 var i:integer;
begin
 for I := 0 to Count - 1 do
  StringLists[i][0]:=DataStringConvert(StringLists[i][0]);
end;

procedure TArrayKeyStringList.Free;
 var i:integer;
begin
 for I := 0 to Count - 1 do
  StringLists[i].Free;
end;

function TArrayKeyStringList.GetCount: word;
begin
 Result:=High(Keys)+1;
end;

function TArrayKeyStringList.KeyIsPresent(Key: string): boolean;
 var i:word;
begin
 for I := 0 to High(Keys) do
  if Key=Keys[i] then
   begin
     Result:=True;
     Exit;
   end;
 Result:=False;  
end;

procedure TArrayKeyStringList.KeysAndListsToStringList(StringList: TStringList);
 var i,j:integer;
begin
 StringList.Clear;
 for I := 0 to Count - 1 do
   for j := 0 to StringLists[i].Count - 1 do
    StringList.Add(Keys[i]+' '+StringLists[i][j]);
end;

procedure TArrayKeyStringList.SortingByKeyValue;
 var KeyValue:array of double;
     i,j:integer;
     tempDouble:double;
     tempString:string;
     tempStringList:TStringList;

begin
 tempStringList:=TStringList.Create;
 SetLength(KeyValue,Count);
 for I := 0 to Count - 1 do
  KeyValue[i]:=StrToFloat(Keys[i]);
  for I := 0 to High(KeyValue)-1 do
   for j := 0 to High(KeyValue)-1-i do
     if KeyValue[j]>KeyValue[j+1] then
       begin
        tempDouble:=KeyValue[j];
        KeyValue[j]:=KeyValue[j+1];
        KeyValue[j+1]:=tempDouble;

        tempString:=Keys[j];
        Keys[j]:=Keys[j+1];
        Keys[j+1]:=tempString;

        tempStringList.Assign(StringLists[j]);
        StringLists[j].Assign(StringLists[j+1]);
        StringLists[j+1].Assign(tempStringList);
       end;
 tempStringList.Free;
end;

{ TArrKeyStrList }

//procedure TArrKeyStrList.AddKey(Key, SringKey: string);
// var i:integer;
//begin
// try
//   StrToFloat(Key);
//   for I := 0 to High(Keys) do
//     if Key=Keys[i] then
//      begin
//        StringLists[i].Add(SringKey);
//        Exit;
//      end;
//   SetLength(Keys,High(Keys)+2);
//   SetLength(StringLists,High(StringLists)+2);
//   StringLists[High(StringLists)]:=TStringList.Create;
//   Keys[High(Keys)]:=Key;
//   StringLists[High(StringLists)].Add(SringKey);
// except
//   KeysName:=KeysNameDetermine(Key);
// end;
//end;

constructor TArrKeyStrList.Create(SL: TStringList;
                               DataNumber: integer;
                               FolderName:string;
                               FileNamePart:string);
//                               Parent: TArrKeyStrList);
 var
     i,j:integer;
begin
 inherited Create;
// fParent:=Parent;
// if fParent=nil then DirectoryPath:=GetCurrentDir;
 if FolderName='' then DirectoryPath:=GetCurrentDir
                  else DirectoryPath:=FolderName;

 fFileNamePart:=FileNamePart;
 fArgumentNumber:=NumberOfSubstringInRow(SL[0])-DataNumber;

 if (FileNamePart<>'')and(fArgumentNumber>1) then
      DirectoryPath:=DirectoryPath+'\'+FileNamePart;

 SetLength(ArrKeyStrList,fArgumentNumber);
 for I := 0 to High(ArrKeyStrList) do
  begin
    ArrKeyStrList[i]:=TKeyStrList.Create;
    ArrKeyStrList[i].AddKeysFromStringList(SL,i+1);
    ArrKeyStrList[i].SortingByKeyValue;
  end;

 SetLength(fChields,0);

 if fArgumentNumber>1 then
  begin
  for I := 0 to High(ArrKeyStrList) do
   for j := 0 to ArrKeyStrList[i].Count-1 do
       begin
        SetLength(fChields,High(fChields)+2);
        fChields[High(fChields)]:=
             TArrKeyStrList.Create(ArrKeyStrList[i].StringLists[j],
                             DataNumber,
                             DirectoryPath
                             +'\'
                             +TKeyStrList.ShortDirNameToDirName(ArrKeyStrList[i].KeysName),
                             fFileNamePart
                             +ArrKeyStrList[i].KeysName
                             +TKeyStrList.PartOfDataFileName(ArrKeyStrList[i].Keys[j]));
       end;
  end;

end;

//function TArrKeyStrList.KeysNameDetermine(fileHeader: string): string;
// var i:TArguments;
//begin
// for I := Low(TArguments) to High(TArguments) do
//   if fileHeader=FileHeaderNames[i] then
//    begin
//      Result:=ShortDirectoryNames[i];
//      Exit;
//    end;
//  Result:='None';
//end;

{ TKeyStrList }

procedure TKeyStrList.AddKey(Key, SringKey: string);
 var i:integer;
begin
 try
   StrToFloat(Key);
   for I := 0 to High(Keys) do
     if Key=Keys[i] then
      begin
        StringLists[i].Add(SringKey);
        Exit;
      end;
   SetLength(Keys,High(Keys)+2);
   SetLength(StringLists,High(StringLists)+2);
   StringLists[High(StringLists)]:=TStringList.Create;
   Keys[High(Keys)]:=Key;
   StringLists[High(StringLists)].Add(StringHeader);
   StringLists[High(StringLists)].Add(SringKey);
 except
   KeysName:=KeysNameDetermine(Key);
   StringHeader:=SringKey;
 end;
end;

procedure TKeyStrList.AddKeysFromStringList(StringList: TStringList;
                                            PartNumber: word);
 var i:integer;
begin
  for I := 0 to StringList.Count - 1 do
     AddKey(StringDataFromRow(StringList[i],PartNumber),
             DeleteStringDataFromRow(StringList[i],PartNumber));
end;

class function TKeyStrList.ShortDirNameToDirName(KeysName: string): string;
 var i:TArguments;
begin
 for I := Low(TArguments) to High(TArguments) do
   if KeysName=ShortDirectoryNames[i] then
    begin
      Result:=DirectoryNames[i];
      Exit;
    end;
  Result:='None';
end;

procedure TKeyStrList.ShowKeys;
 var temp:string;
     i:integer;
begin
 temp:='';
 for i := 0 to High(Keys)
   do temp:=temp+Keys[i]+#10#13;
 showmessage(temp);
end;

procedure TKeyStrList.ShowStringList(Number: integer);
begin
 try
  StringListShow(StringLists[Number]);
 except
 end;
end;

procedure TKeyStrList.DataConvert(StartPosition:word=0);
 var i,j:integer;
     tempstr,header:string;
begin
 for I := 0 to Count - 1 do
  begin
   for j := 1 to StringLists[i].Count-1 do
     StringLists[i][j]:=DataStringConvertNew(StringLists[i][j],StartPosition);
   header:=StringLists[0][0];
   StringLists[i].Delete(0);
   tempstr:='';
   for j := 1 to StartPosition
     do tempstr:=tempstr+StringDataFromRow(header,j)+' ';

   StringLists[i].Insert(0,tempstr+FileHeaderNew);

  end;
end;

function TKeyStrList.GetCount: word;
begin
 Result:=High(Keys)+1;
end;

function TKeyStrList.GetSList(index: integer): TStringList;
begin
 Result:=StringLists[index];
end;

function TKeyStrList.GetSListNumber: integer;
begin
 Result:=High(StringLists);
end;

procedure TKeyStrList.KeysAndListsToStringList(StringList: TStringList);
 var i,j:integer;
begin
 StringList.Clear;
 for I := 0 to Count - 1 do
   for j := 1 to StringLists[i].Count - 1 do
    StringList.Add(Keys[i]+' '+StringLists[i][j]);
 StringList.Insert(0,KeysName+' '+StringLists[0][0]);
end;

class function TKeyStrList.KeysNameDetermine(fileHeader: string): string;
 var i:TArguments;
begin
 for I := Low(TArguments) to High(TArguments) do
   if fileHeader=FileHeaderNames[i] then
    begin
      Result:=ShortDirectoryNames[i];
      Exit;
    end;
  Result:='None';
end;

class function TKeyStrList.PartOfDataFileName(Key: string): string;
begin
  if (AnsiPos ('e',Key)>0)or(AnsiPos ('E',Key)>0)
   then  Result:=Key[1]+Key[3]+AnsiRightStr(Key, 1)
   else  Result:=Key[2]+Key[3];
end;

procedure TKeyStrList.SortingByKeyValue;
 var KeyValue:array of double;
     i,j:integer;
//     tempDouble:double;
//     tempString:string;
     tempStringList:TStringList;
begin
 tempStringList:=TStringList.Create;
 SetLength(KeyValue,Count);
 for I := 0 to Count - 1 do
  KeyValue[i]:=StrToFloat(Keys[i]);
 for I := 0 to High(KeyValue)-1 do
   for j := 0 to High(KeyValue)-1-i do
     if KeyValue[j]>KeyValue[j+1] then
       begin
        SwapRound(KeyValue[j],KeyValue[j+1]);

//        tempDouble:=KeyValue[j];
//        KeyValue[j]:=KeyValue[j+1];
//        KeyValue[j+1]:=tempDouble;

        SwapRound(Keys[j],Keys[j+1]);

//        tempString:=Keys[j];
//        Keys[j]:=Keys[j+1];
//        Keys[j+1]:=tempString;

        tempStringList.Assign(StringLists[j]);
        StringLists[j].Assign(StringLists[j+1]);
        StringLists[j+1].Assign(tempStringList);
       end;
 tempStringList.Free;
end;

procedure TKeyStrList.TCtoStringList(SL: TStringList; T0: Double);
 var i:integer;
begin
 SL.Clear;
 for I := 0 to Count-1 do
   SL.Add(Keys[i]+' '+StringWithTC(StringLists[i],T0))
end;

destructor TArrKeyStrList.Destroy;
 var i:integer;
begin
  for I := 0 to High(fChields) do
    fChields[i].Free;
  for I := 0 to High(ArrKeyStrList) do ArrKeyStrList[i].Free;
  inherited;
end;

procedure TArrKeyStrList.SaveData;
 var i,j,k:integer;
      tempStr,tempStr2:string;
      SimpleDataFile:TStringList;
      DataNumber:integer;
      ValueName:string;
begin
 SimpleDataFile:=TStringList.Create;
// showmessage(inttostr(fArgumentNumber));

 if fArgumentNumber=1 then
  begin
   SetCurrentDir(DirectoryPath);
   ArrKeyStrList[0].DataConvert;
   ArrKeyStrList[0].KeysAndListsToStringList(SimpleDataFile);
   SimpleDataFile.SaveToFile(fFileNamePart+'_'
                             +ArrKeyStrList[0].KeysName
                             +'.dat');
   SimpleDataFile.Free;
   Exit;
  end;


 for I := 0 to High(ArrKeyStrList) do
  begin
    SetCurrentDir(DirectoryPath);
    tempStr:=TKeyStrList.ShortDirNameToDirName(ArrKeyStrList[i].KeysName);

    while not(SetCurrentDir(DirectoryPath+'\'+tempStr))
          do MkDir(tempStr);
  end;

 if fArgumentNumber>2 then
 begin
 for I := 0 to High(ArrKeyStrList) do
  begin
    tempStr:=DirectoryPath+'\'
             +TKeyStrList.ShortDirNameToDirName(ArrKeyStrList[i].KeysName);
    for j := 0 to ArrKeyStrList[i].Count - 1 do
     begin
      SetCurrentDir(tempStr);
      tempStr2:=fFileNamePart
            +ArrKeyStrList[i].KeysName
            +TKeyStrList.PartOfDataFileName(ArrKeyStrList[i].Keys[j]);
      while not(SetCurrentDir(tempStr+'\'+tempStr2))
             do MkDir(tempStr2);
     end;
  end;
 end;

  for I := 0 to High(fChields) do  fChields[i].SaveData;

  if fArgumentNumber=2 then
   begin
    tempStr:=DirectoryPath;
    Delete(tempStr, AnsiPos(fFileNamePart,DirectoryPath)-1,
           Length(fFileNamePart)+1);
    SetCurrentDir(tempStr);

    ArrKeyStrList[0].DataConvert(1);
//    for j := 0 to ArrKeyStrList[0].Count-1 do
//     ArrKeyStrList[0].StringLists[j].SaveToFile('aa'+ArrKeyStrList[0].Keys[j]+'.dat');
//
    DataNumber:=NumberOfSubstringInRow(ArrKeyStrList[0].StringLists[0][0])-1;

    for I := 1 to  DataNumber do
    begin
     ValueName:=StringDataFromRow(ArrKeyStrList[0].StringLists[0][0],1+i);
     while not(SetCurrentDir(tempStr+'\'+ValueName))
             do MkDir(ValueName);

     SimpleDataFile.Clear;

     tempStr2:=StringDataFromRow(ArrKeyStrList[0].StringLists[0][0],1);
     for j := 0 to ArrKeyStrList[0].Count-1 do
      tempStr2:=tempStr2+' '+ArrKeyStrList[0].KeysName
            +TKeyStrList.PartOfDataFileName(ArrKeyStrList[0].Keys[j]);
     SimpleDataFile.Add(tempStr2);

     tempStr2:=ArrKeyStrList[0].KeysName;
     for j := 0 to ArrKeyStrList[0].Count-1 do
      tempStr2:=tempStr2+' '+LogKey(ArrKeyStrList[0].Keys[j]);
     SimpleDataFile.Add(tempStr2);
     for k := 1 to ArrKeyStrList[0].StringLists[0].Count - 1 do
       begin
        tempStr2:=LogKey(StringDataFromRow(ArrKeyStrList[0].StringLists[0][k],1));
        for j := 0 to ArrKeyStrList[0].Count-1 do
         tempStr2:=tempStr2+' '+StringDataFromRow(ArrKeyStrList[0].StringLists[j][k],1+i);
        SimpleDataFile.Add(tempStr2);
       end;
     SimpleDataFile.SaveToFile(ValueName+'_'
                              +fFileNamePart+'_'
                              +ArrKeyStrList[0].KeysName
                              +'.dat');
     SetCurrentDir(tempStr);
    end;

//    SetCurrentDir(tempStr);
    SimpleDataFile.Clear;
    for I := 0 to ArrKeyStrList[1].Count-1 do
      for j := 0 to ArrKeyStrList[0].Count-1 do
       for k := 1 to ArrKeyStrList[0].StringLists[j].Count - 1 do
         if (ArrKeyStrList[1].Keys[i]=StringDataFromRow(ArrKeyStrList[0].StringLists[j][k],1))
         then
         SimpleDataFile.Add(LogKey(ArrKeyStrList[1].Keys[i])
            +' '+LogKey(ArrKeyStrList[0].Keys[j])
            +' '
            +DeleteStringDataFromRow(ArrKeyStrList[0].StringLists[j][k],1));
    SimpleDataFile.Insert(0,ArrKeyStrList[1].KeysName
                    +' '+ArrKeyStrList[0].KeysName+' '
                    +DeleteStringDataFromRow(ArrKeyStrList[0].StringLists[0][0],1));
    SimpleDataFile.SaveToFile(fFileNamePart+'_'
                             +ArrKeyStrList[1].KeysName
                             +ArrKeyStrList[0].KeysName
                             +'.dat');

    ArrKeyStrList[1].DataConvert(1);


    DataNumber:=NumberOfSubstringInRow(ArrKeyStrList[1].StringLists[0][0])-1;
    for I := 1 to  DataNumber do
    begin
     ValueName:=StringDataFromRow(ArrKeyStrList[1].StringLists[0][0],1+i);
     SetCurrentDir(tempStr+'\'+ValueName);

     SimpleDataFile.Clear;

     tempStr2:=StringDataFromRow(ArrKeyStrList[1].StringLists[0][0],1);
     for j := 0 to ArrKeyStrList[1].Count-1 do
      tempStr2:=tempStr2+' '+ArrKeyStrList[1].KeysName
            +TKeyStrList.PartOfDataFileName(ArrKeyStrList[1].Keys[j]);
     SimpleDataFile.Add(tempStr2);

     tempStr2:=ArrKeyStrList[1].KeysName;
     for j := 0 to ArrKeyStrList[1].Count-1 do
      tempStr2:=tempStr2+' '+LogKey(ArrKeyStrList[1].Keys[j]);
     SimpleDataFile.Add(tempStr2);

     for k := 1 to ArrKeyStrList[1].StringLists[0].Count - 1 do
       begin
        tempStr2:=LogKey(StringDataFromRow(ArrKeyStrList[1].StringLists[0][k],1));
        for j := 0 to ArrKeyStrList[1].Count-1 do
         tempStr2:=tempStr2+' '+StringDataFromRow(ArrKeyStrList[1].StringLists[j][k],1+i);
        SimpleDataFile.Add(tempStr2);
       end;


     SimpleDataFile.SaveToFile(ValueName+'_'
                              +fFileNamePart+'_'
                              +ArrKeyStrList[1].KeysName
                              +'.dat');
     SetCurrentDir(tempStr);
    end;


   end;

   SimpleDataFile.Free;

end;

procedure TArrKeyStrList.ShowArrKeyStrListNumber;
begin
 showmessage('ArrKeyStrList='+inttostr(High(Self.ArrKeyStrList)));
end;

procedure TArrKeyStrList.ShowChieldsNumber;
begin
 showmessage('Chields number='+inttostr(High(Self.fChields)));
end;

procedure TArrKeyStrList.ShowInformation;
begin
 ShowKeysNames;
 ShowKeys;
 ShowChieldsNumber;
end;

procedure TArrKeyStrList.ShowKeys;
 var i:integer;
begin
 for i := 0 to High(ArrKeyStrList)
  do  ArrKeyStrList[i].ShowKeys;
end;

procedure TArrKeyStrList.ShowKeysNames;
 var temp:string;
     i:integer;
begin
 temp:='';
 for i := 0 to High(ArrKeyStrList)
   do temp:=temp+ArrKeyStrList[i].KeysName+#10#13;
 showmessage(temp);
end;

Procedure delIllumParamCalculate(var str:string);
{���������, �� str �� ������
'N_Fe _B T d Isc_Fe Eta_Fe Voc_Fe FF_Fe Isc_FeB Eta_FeB Voc_FeB FF_FeB'
� �������������� �� ����������� � ��� �� �����
������� ���� (P_FeB-P_Fe)/P_FeB}
 var P_FeB,P_Fe:double;
     i:word;
begin
// for I := 5 to 8 do
//   begin
//    P_Fe:=FloatDataFromRow(str,i);
//    P_FeB:=FloatDataFromRow(str,i+4);
//    if (P_FeB<>0)and(P_Fe<>0)
//      then str:=str+' '+FloatToStrF((P_FeB-P_Fe)/P_FeB*100,ffExponent,8,2)
//      else str:=str+' 0';
//   end;
 for I := 5 to 10 do
   begin
    P_Fe:=FloatDataFromRow(str,i);
    P_FeB:=FloatDataFromRow(str,i+6);
    if (P_FeB<>0)and(P_Fe<>0)
      then str:=str+' '+FloatToStrF((P_FeB-P_Fe)/P_FeB*100,ffExponent,8,2)
      else str:=str+' 0';
   end;
end;

end.
