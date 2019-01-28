unit IV_Class;

interface

uses
  Classes;

const
  SampleArea=1e-6;
  {записуємо ВАХ у файл з міркування, що площа зразка 1мм^2}

 IlluminatedParameterName:array [0..6] of string=
   ('Voc','Jsc','FF','eta', 'Vmpp', 'Jmpp','Wph');
 IlluminatedParameterDescription:array [0..6] of string=
   ('Voc =','Jsc =','FF =','eta =', 'V_MPP =', 'J_MPP =','Incident power');
 IlluminatedParameterUnit:array [0..6] of string=
   ('Volt','mA/cm2','%','%', 'Volt', 'mA/cm2','mW/cm2');

type
 TIVparameter=class
  private
  public
   fName:TStringList;
   fDescription:TStringList;
   fUnit:TStringList;
   fData:array of double;
   fTemperatura:double;
   fFileNumber:word;
   Constructor Create();
   Procedure Clear();
   Procedure Empty();
   Procedure Free;
   Procedure Add(Name,Description,Un:string);overload;
   Procedure Add(Name,Description,Un:string; Data:double);overload;
   Function Title:string;
   Function DataString:string;
   Function FileName:string;
   Procedure ParameterTitleDetermination(SCAPSFile:TStringList);
   Procedure ParameterDetermination(DataString:String);
 end;

implementation

uses
  SysUtils, OlegType, StrUtils, Dialogs, OlegFunction;

{ TIVparameter }

procedure TIVparameter.Add(Name,Description,Un:string);
begin
 fName.Add(Name);
 fDescription.Add(Description);
 fUnit.Add(Un);
 SetLength(fData, fName.Count);
end;

Procedure TIVparameter.Add(Name,Description,Un:string; Data:double);
begin
  Add(Name,Description,Un);
  fData[high(fData)]:=Data;
end;

procedure TIVparameter.Clear;
begin
 fName.Clear;
 fDescription.Clear;
 fUnit.Clear;
end;

constructor TIVparameter.Create;
begin
 inherited Create;
 fName:=TStringList.Create;
 fDescription:=TStringList.Create;
 fUnit:=TStringList.Create;
end;

function TIVparameter.DataString: string;
 var i:integer;
begin
  if fName.Count>0 then
    begin
     Result:=FloatToStrF(fTemperatura,ffGeneral,4,1)+' '+
             FileName+' '+FloatToStrF(1/fTemperatura/Kb,ffGeneral,5,2);
     for I := 0 to fName.Count - 1 do
       Result:=Result+' '+FloatToStrF(fData[i],ffExponent,7,0);
    end
               else
    Result:='';
end;

procedure TIVparameter.Empty;
var
  I: Integer;
begin
 fTemperatura:=300;
 fFileNumber:=0;
 for I := 0 to High(fData) do
   fData[i]:=0;
end;

function TIVparameter.FileName: string;
begin
 Result:=IntToStr(fFileNumber)+'_'+IntToStr(Round(fTemperatura));
 if fFileNumber<100 then Result:='0'+Result;
 if fFileNumber<10 then Result:='0'+Result;
end;

procedure TIVparameter.Free;
begin
 fName.Free;
 fDescription.Free;
 fUnit.Free;
 inherited Free;
end;

procedure TIVparameter.ParameterDetermination(DataString: String);
var
  I: Integer;
  tempStr:string;
begin
 if AnsiStartsStr('Temperature', DataString) then
  begin
    DataString:=SomeSpaceToOne(DataString);
    Delete(DataString, 1, AnsiPos (' ', DataString));
     try
       fTemperatura:=StrToFloat(Copy(DataString, 1, AnsiPos (' ', DataString)-1));
     except

     end;
    Exit;
  end;

 if AnsiStartsStr('Batch simulation #', DataString) then
  begin
    DataString:=SomeSpaceToOne(DataString);
    Delete(DataString, 1, AnsiPos ('step', DataString)+4);
     try
       fFileNumber:=StrToInt(Copy(DataString, 1, AnsiPos (' ', DataString)-1));
     except

     end;
    Exit;
  end;

  for I := 0 to fDescription.Count - 1 do
     if AnsiStartsStr(fDescription[i], DataString) then
      begin
        DataString:=SomeSpaceToOne(DataString);
        if AnsiEndsStr(' ',DataString) then DataString:=Copy(DataString,1,Length(DataString)-1);
        if fUnit[i]<>'' then
         begin
//            Delete(DataString,AnsiPos(fUnit[i], DataString),Length(fUnit[i]));
            Delete(DataString,AnsiPos(fUnit[i], DataString),Length(DataString)-AnsiPos(fUnit[i], DataString)+1);
            if AnsiEndsStr(' ',DataString) then DataString:=Copy(DataString,1,Length(DataString)-1);
         end;
         try
          tempStr:=Copy(DataString,
                                    LastDelimiter(' ', DataString)+1,
                                    Length(DataString)-LastDelimiter(' ', DataString));
          fData[i]:=StrToFloat(tempStr);
         except
           if (AnsiPos('.grd',tempStr)>0)and(AnsiPos('FeB',tempStr)>0) then
             begin
               tempstr:=Copy(tempstr,AnsiPos('B',tempStr)+1,8);
               tempstr:=AnsiReplaceStr(tempstr,'p','.');
               fData[i]:=StrToFloat(tempStr);
             end;
         end;
        Exit;
      end;
end;

procedure TIVparameter.ParameterTitleDetermination(SCAPSFile: TStringList);
 var Row:Int64;
     i:byte;
     Description,Name:string;
begin
 if SCAPSFile.Count=0 then Exit;

 Row:=-1;
 repeat
   Inc(Row);
 until (Row=SCAPSFile.Count) or AnsiStartsStr('SCAPS', SCAPSFile[ROW]);

 repeat
    Inc(Row);
    if  ((Row>=SCAPSFile.Count) or AnsiStartsStr('SCAPS', SCAPSFile[ROW]))
      then Break;

    if AnsiStartsStr('Calculation under illumination', SCAPSFile[ROW]) then
     begin
      for I := 0 to High(IlluminatedParameterName) do
        Add(IlluminatedParameterName[i],IlluminatedParameterDescription[i],IlluminatedParameterUnit[i]);
      Continue;
     end;

    if AnsiStartsStr('**Batch parameters**', SCAPSFile[ROW]) then
     begin
       repeat
        Inc(Row);
        if  ((Row>=SCAPSFile.Count) or (SCAPSFile[ROW]=''))
           then Break;
        SCAPSFile[ROW]:=SomeSpaceToOne(SCAPSFile[ROW]);
        Description:=Copy(SCAPSFile[ROW], 1, AnsiPos (':', SCAPSFile[ROW])-1);
        Name:=Description;
        while AnsiContainsStr(Name,'>>') do
           Name:=Copy(Name,AnsiPos('>>',Name)+2,Length(Name)-AnsiPos('>>',Name)-1);
        if AnsiContainsStr(Name,'[') then
           Name:=Copy(Name,1,AnsiPos('[',Name)-1);
        Name:=Acronym(Name);
        Add(Name,Description,'');
       until false;
     end;

 until false;

end;


function TIVparameter.Title: string;
 var i:integer;
begin
  if fName.Count>0 then
    begin
     Result:='T file kT1';
     for I := 0 to fName.Count - 1 do
       Result:=Result+' '+fName[i];
//       Result:=Result+' '+fUnit[i];
    end
               else
    Result:='';
end;

end.
