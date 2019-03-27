unit ResultAll;

interface

uses
  Classes,OlegFunction,SomeFunction;

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




implementation

uses
  Dialogs, SysUtils;

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

end.
