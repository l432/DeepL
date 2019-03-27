unit SomeFunction;

interface

 const DirecName:array[1..3]of string=('Iron','Boron','Temperature');
      ShortDirecName:array[1..3]of string=('Fe','B','T');
      FileHeader='nFsrh nFBsrh dnsrh nF nFB dn';


function EditString(str:string):string;
function NumberToString(Number:double;DigitNumber:word=4):string;
function SubDirectoryName(Number1,Number2:word):string;
function SubDirectorySault(Number1,Number2:word):string;
function DataFileHeader(Number1,Number2:word):string;
function DataStringConvert(Souce:string):string;

implementation

uses
  StrUtils, SysUtils, OlegFunction;

function EditString(str:string):string;
begin
  Result:=AnsiReplaceStr(str,'.','p');
  Result:=AnsiReplaceStr(Result,'+','');
  while AnsiPos ('0E', Result)>5 do
      Result:=AnsiReplaceStr(Result,'0E','E');
  while AnsiPos ('0e', Result)>5 do
      Result:=AnsiReplaceStr(Result,'0e','e');
end;


function NumberToString(Number: double; DigitNumber: word): string;
begin
  Result:=LowerCase(floattostrF(Number,ffExponent,DigitNumber,2));
  Result:=EditString(Result);
end;

function SubDirectorySault(Number1,Number2:word):string;
begin
  case Number1 of
   1:if Number2=1 then Result:=ShortDirecName[2] else Result:=ShortDirecName[3];
   2:if Number2=1 then Result:=ShortDirecName[1] else Result:=ShortDirecName[3];
   else if Number2=1 then Result:=ShortDirecName[1] else Result:=ShortDirecName[2];
  end;
end;

function SubDirectoryName(Number1,Number2:word):string;
begin
  case Number1 of
   1:if Number2=1 then Result:=DirecName[2] else Result:=DirecName[3];
   2:if Number2=1 then Result:=DirecName[1] else Result:=DirecName[3];
   else if Number2=1 then Result:=DirecName[1] else Result:=DirecName[2];
  end;
end;

function DataFileHeader(Number1,Number2:word):string;
begin
  case Number1 of
   1:if Number2=1 then Result:=ShortDirecName[3] else Result:=ShortDirecName[2];
   2:if Number2=1 then Result:=ShortDirecName[3] else Result:=ShortDirecName[1];
   else if Number2=1 then Result:=ShortDirecName[2] else Result:=ShortDirecName[1];
  end;
  Result:=Result+' '+FileHeader;
end;


function DataStringConvert(Souce:string):string;
 var nFe,nFeSRH,nFeB,nFeBSRH:double;
begin
 nFe:=FloatDataFromRow(Souce,1);
 nFeSRH:=FloatDataFromRow(Souce,2);
 nFeB:=FloatDataFromRow(Souce,3);
 nFeBSRH:=FloatDataFromRow(Souce,4);
 Result:=StringDataFromRow(Souce,2)+' '
         +StringDataFromRow(Souce,4)+' '
         +FloatToStrF(nFeSRH-nFeBSRH,ffExponent,10,2)+' '
         +StringDataFromRow(Souce,1)+' '
         +StringDataFromRow(Souce,3)+' '
         +FloatToStrF(nFe-nFeB,ffExponent,10,2);
end;

end.
