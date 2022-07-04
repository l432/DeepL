unit EpiLayers;

interface

const

//IEEEJPhotovol_5_p1250-1263.pdf
EmiterPointNumber=42;
EmiterPoints:array[0..EmiterPointNumber]of double=
(0, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09,
 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19,
 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 0.29,
 0.3, 0.31, 0.32, 0.33, 0.335, 0.34, 0.345, 0.35, 0.355,
 0.36, 0.37, 0.38, 0.39);
EmiterConcentration:array[0..EmiterPointNumber]of double=
(1.1E21, 2.2E21, 4.3E21, 8E21, 1.45E22, 2.5E22, 4.2E22, 6.6E22,
 1.1E23, 1.7E23, 2.2E23, 3.3E23, 5.1E23, 7E23, 9.6E23, 1.2E24,
 1.5E24, 2E24, 2.3E24, 3E24, 3.7E24, 4.4E24, 5.4E24, 6.3E24,
 7E24, 8.2E24, 9.5E24, 1.05E25, 1.15E25, 1.3E25, 1.5E25, 1.8E25,
 2.1E25, 2.7E25, 3E25, 4E25, 6E25, 1E26, 1.7E26, 2.5E26, 3E26,
 3E26, 3E26);

BSFPointNumber=39;
BSFPoints:array[0..BSFPointNumber]of double=
(0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2, 2.2, 2.4, 2.6,
 2.8, 3, 3.2, 3.4, 3.6, 3.8, 4, 4.2, 4.4, 4.6, 4.8, 5, 5.2, 5.4,
 5.6, 5.8, 6, 6.2, 6.4, 6.6, 6.8, 7, 7.2, 7.4, 7.6, 7.75);

BSFConcentration:array[0..BSFPointNumber]of double=
(2.6E24, 2.8E24, 2.9E24, 3E24, 3.15E24, 3.25E24, 3.4E24, 3.5E24,
 3.7E24, 3.8E24, 3.95E24, 4.05E24, 4.2E24, 4.3E24, 4.4E24, 4.5E24,
 4.6E24, 4.7E24, 4.8E24, 4.8E24, 4.6E24, 4.3E24, 4.1E24, 3.8E24,
 3.4E24, 2.9E24, 2.1E24, 1.6E24, 1.2E24, 8E23, 5E23, 3E23, 2E23,
 1.2E23, 8E22, 5E22, 2.4E22, 1.4E22, 1E22, 7.1E21);



Procedure EmiterGradingFileCreate(dn:double=0.39;
                                  Nd:double=3e26;
                                  FileName:string='eND');

Procedure BSFGradingFileCreate(dn:double=7.75;
                               Na:double=4.8e24;
                               Nb:double=7.1e21;
                               FileName:string='eNA');

implementation

uses
  OlegVector, System.Classes, System.SysUtils, main;


Procedure EmiterGradingFileCreate(dn:double=0.39;
                                  Nd:double=3e26;
                                  FileName:string='eND');
 var Vec:TVector;
     GrdFile:TStringList;
     i:integer;
begin
 Vec:=TVector.Create;
 for I := 0 to EmiterPointNumber do
   Vec.Add(EmiterPoints[i],EmiterConcentration[i]);

 if dn<>EmiterPoints[EmiterPointNumber] then
   for I := 0 to EmiterPointNumber do
      Vec.X[i]:=Vec.X[i]/EmiterPoints[EmiterPointNumber]*dn;

 if Nd<>EmiterConcentration[EmiterPointNumber] then
   for I := 0 to EmiterPointNumber do
      Vec.Y[i]:=Vec.Y[i]/EmiterConcentration[EmiterPointNumber]*Nd;

 GRDFile:=TStringList.Create;
 GRDFile.Add('interpolation: logarithmic');
 GRDFile.Add('');
 GRDFile.Add('x (micrometer)	ND (1/m3)');
 for I := 0 to EmiterPointNumber do
   GRDFile.Add(FloatToStrF(Vec.X[i],ffExponent,8,2)+'	'+
                        FloatToStrF(Vec.Y[i],ffExponent,8,2));
 GRDFile.SaveToFile(MainForm.SCAPS_Folder+'\grading\'+FileName+'.grd');
 FreeAndNil(GRDFile);
 FreeAndNil(Vec);
end;

Procedure BSFGradingFileCreate(dn:double=7.75;
                               Na:double=4.8e24;
                               Nb:double=7.1e21;
                               FileName:string='eNA');
 var Vec:TVector;
     GrdFile:TStringList;
     i:integer;
     y1,y2:double;
begin
 Vec:=TVector.Create;
 for I := 0 to BSFPointNumber do
   Vec.Add(BSFPoints[i],BSFConcentration[i]);

 if Na<>4.8e24 then
   for I := 0 to 25 do
      Vec.Y[i]:=Vec.Y[i]/4.8e24*Na;
 if (Nb<>7.1e21)or(Na<>4.8e24) then
   for I := 26 to BSFPointNumber do
      begin
        y1:=exp(ln(2.9e24)+(ln(7.1e21)-ln(2.9e24))/(7.75-5)*(Vec.X[i]-5));
        y2:=exp(ln(Vec.Y[25])+(ln(Nb)-ln(Vec.Y[25]))/(7.75-5)*(Vec.X[i]-5));
        Vec.Y[i]:=Vec.Y[i]/y1*y2;
      end;

 if dn<>BSFPoints[BSFPointNumber] then
   for I := 0 to BSFPointNumber do
      Vec.X[i]:=Vec.X[i]/BSFPoints[BSFPointNumber]*dn;

 GRDFile:=TStringList.Create;
 GRDFile.Add('interpolation: logarithmic');
 GRDFile.Add('');
 GRDFile.Add('x (micrometer)	NA (1/m3)');
 for I := 0 to BSFPointNumber do
   GRDFile.Add(FloatToStrF(Vec.X[i],ffExponent,8,2)+'	'+
                        FloatToStrF(Vec.Y[i],ffExponent,8,2));
 GRDFile.SaveToFile(MainForm.SCAPS_Folder+'\grading\'+FileName+'.grd');
 FreeAndNil(GRDFile);
 FreeAndNil(Vec);
end;

end.
