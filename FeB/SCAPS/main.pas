unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, StrUtils,OlegFunction,OlegType,OlegShowTypes, 
  IniFiles,OlegMaterialSamples,Math;

type
  TMainForm = class(TForm)
    BtFileSelect: TButton;
    BtDone: TButton;
    LFile: TLabel;
    LAction: TLabel;
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
    BMaterialFileCreate: TButton;
    BDatesDat: TButton;
    BFeB_x: TButton;
    GBFerum: TGroupBox;
    LFe_Lo: TLabel;
    LFe_Hi: TLabel;
    LFe_steps: TLabel;
    STFe_Lo: TStaticText;
    STFe_Hi: TStaticText;
    STFe_steps: TStaticText;
    procedure BtFileSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtCloseClick(Sender: TObject);
    procedure BtDoneClick(Sender: TObject);
    procedure BMaterialFileCreateClick(Sender: TObject);
    procedure BDatesDatClick(Sender: TObject);
    procedure BFeB_xClick(Sender: TObject);
  private
    { Private declarations }
    TempStart,TempFinish,TempStep: TIntegerParameterShow;
    FeLow,FeHi:TDoubleParameterShow;
    FeStepNumber: TIntegerParameterShow;
    Boron:TDoubleParameterShow;
    ConfigFile:TIniFile;
    function NBoronToString():string;
    function Nfeb(Nb,T,Ef:double):double;
    {рівноважна частка пар FeB по відношенню до загальної
    кількості Fe,
    Nb - концентрація бору, []=см-3
    Т - температура
    Ef - положення рівня Фермі відносно валентної зони}
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
     Comments,SCparam,DatFile,DatFile_srh:TStringList;
//     IlluminatedChar:boolean;
     V,I,I_srh:double;
     tempStr,DatFileName,DatFileLocation,DatFileLocation2:string;
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
 DatFileLocation2:=DatFileLocation;
 try
  MkDir(DatFileLocation);
 except

 end;
 DatFileLocation:=Directory+'\'+DatFileLocation+'\';


 DecimalSeparator:='.';
 Comments:=TStringList.Create;
 SCparam:=TStringList.Create;
 DatFile:=TStringList.Create;
 DatFile_srh:=TStringList.Create;

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
//      (AnsiContainsStr(SCAPSFile[ROW],'jtot(mA/cm2)'))) then
     (AnsiContainsStr(SCAPSFile[ROW],' jbulk(mA/cm2)'))and
      (AnsiContainsStr(SCAPSFile[ROW],'j_SRH'))) then
    begin
     ROW:=ROW+2;
     DatFile.Clear;
     DatFile_srh.Clear;
    while SCAPSFile[ROW]<>'' do
       begin
        SCAPSFile[ROW]:=SomeSpaceToOne(SCAPSFile[ROW]);
        tempStr:=SCAPSFile[ROW];
        if AnsiStartsStr(' ',tempStr) then Delete(tempStr, 1, 1);
        try
         V:=StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));

         Delete(tempStr, 1, AnsiPos (' ', tempStr));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));

         I:=10*SampleArea*StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));

         Delete(tempStr, 1, AnsiPos (' ', tempStr));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));
         Delete(tempStr, 1, AnsiPos (' ', tempStr));

         I_srh:=10*SampleArea*StrToFloat(Copy(tempStr, 1, AnsiPos (' ', tempStr)-1));

        except
         V:=0;
         I:=0;

         I_srh:=0;
        end;
        DatFile.Add((FloatToStrF(V,ffExponent,4,0)+' '+
                     FloatToStr(I)));
        DatFile_srh.Add((FloatToStrF(V,ffExponent,4,0)+' '+
                     FloatToStr(I_srh)));
        Row:=ROW+1;
       end;

     DatFileName:=IVparameter.FileName+'.dat';
     DatFile.SaveToFile(DatFileLocation+DatFileName);
     Comments.Add(DatFileName);
     Comments.Add('T='+FloatToStrF(IVparameter.fTemperatura,ffGeneral,4,1));
     Comments.Add('');

     DatFileName:=IVparameter.FileName+'_srh.dat';
     DatFile_srh.SaveToFile(DatFileLocation+DatFileName);
     Comments.Add(DatFileName);
     Comments.Add('T='+FloatToStrF(IVparameter.fTemperatura,ffGeneral,4,1));
     Comments.Add('');
     Continue;
   end;

   Inc(Row);
  end;

 SCparam.Add(IVparameter.DataString);

 if Comments.Count>0 then
      Comments.SaveToFile(DatFileLocation+'comments');
 Comments.Free;
 if SCparam.Count>1 then
//      SCparam.SaveToFile(DatFileLocation+'SCparam.dat');
//      SCparam.SaveToFile(DatFileLocation+DatFileLocation2+'.dat');
      SCparam.SaveToFile(DatFileLocation+DatFileLocation2+'.txt');

 SCparam.Free;
 DatFile.Free;
   IVparameter.Free;

 LAction.Caption:='Extraction is done';
 LAction.Font.Color:=clGreen;
end;

procedure TMainForm.BtFileSelectClick(Sender: TObject);

begin
   OpenDialog1.Filter:='Scaps files (*.iv)|*.iv';
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


procedure TMainForm.BDatesDatClick(Sender: TObject);
 var Direc:string;
    DatesDatFile,{CommentsFile,}TxtFile,
    nDat,n_srhDat:TStringList;
    SR : TSearchRec;
    i,j:integer;
    fl_name,tempString:string;
    SRH_file,FeBdata:boolean;
begin
 OpenDialog1.Filter:='Shottky result file (dates.dat)|dates.dat';
   if OpenDialog1.Execute()
     then
       begin
       Direc:=ExtractFilePath(OpenDialog1.FileName);
       DatesDatFile:=TStringList.Create;
//       CommentsFile:=TStringList.Create;
       TxtFile:=TStringList.Create;
       nDat:=TStringList.Create;
       n_srhDat:=TStringList.Create;
       DatesDatFile.LoadFromFile(OpenDialog1.FileName);
//       if FileExists(Direc+'comments') then
//          CommentsFile.LoadFromFile(Direc+'comments')
//                                       else
//          begin
//            showmessage('comments file is absent');
//            Exit;
//          end;
       if FindFirst('*.txt', faAnyFile, SR) = 0 then
         TxtFile.LoadFromFile(SR.Name)
                                                else
         begin
            showmessage('.txt file is absent');
            Exit;
         end;
       FeBdata:=(Length(TxtFile[0])>14);

       nDat.Add('N_Fe N_B T n n_SRH');
//       n_srhDat.Add('N_Fe N_B T n');
       for I := 1 to DatesDatFile.Count - 1 do
         begin
          fl_name:=StringDataFromRow(DatesDatFile[i],2);
          fl_name:=Copy(fl_name,1,AnsiPos ('.dat', fl_name)-1);
          SRH_file:=(AnsiPos ('_srh', fl_name)>0);
          if SRH_file then fl_name:=Copy(fl_name,1,AnsiPos ('_srh', fl_name)-1);
          for j:=1 to TxtFile.Count - 1 do
            if AnsiPos(fl_name,TxtFile[j])>0 then
             begin
              tempString:=StringDataFromRow(TxtFile[j],4)+
                          ' '+StringDataFromRow(TxtFile[j],1)+
                          ' '+LowerCase(floattostrF(Boron.Data,ffExponent,4,2))+
                          ' '+StringDataFromRow(DatesDatFile[i],9);
              Break;
             end;
          if SRH_file then  n_srhDat.Add(tempString)
                      else  nDat.Add(tempString);
         end;
        DatesDatFile.Clear;
        if FeBdata then DatesDatFile.Add('N_Fe N_B T n_FeB n_FeB_SRH')
                   else DatesDatFile.Add('N_Fe N_B T n_Fe n_Fe_SRH');
        for I := 1 to nDat.Count - 1 do
         begin
          tempString:=StringDataFromRow(nDat[i],1)+
                      ' '+StringDataFromRow(nDat[i],2)+
                      ' '+StringDataFromRow(nDat[i],3);
          for j := 0 to n_srhDat.Count - 1 do
           if AnsiPos(tempString,n_srhDat[j])>0 then
            begin
            DatesDatFile.Add(nDat[i]+' '+StringDataFromRow(n_srhDat[j],4));
            Break;
            end;
         end;

        Delete(Direc,Length(Direc),1);
        tempString:='';
        for I := Length(Direc) downto 1 do
          tempString:=tempString+Direc[i];
        Delete(tempString,1,AnsiPos ('\', tempString)-1);
        Direc:='';
        for I := Length(tempString) downto 1 do
          Direc:=Direc+tempString[i];
        tempString:=LowerCase(floattostrF( Boron.Data,ffExponent,4,2));
        tempString:=AnsiReplaceStr(tempString,'.','p');
        tempString:=AnsiReplaceStr(tempString,'+','');
        tempString:=NBoronToString()+
        {'NB'+tempString+}'T'+StringDataFromRow(TxtFile[2],1);
        if FeBdata then DatesDatFile.SaveToFile(Direc+tempString+'FeB.dat')
                   else DatesDatFile.SaveToFile(Direc+tempString+'Fe.dat');

//        DatesDatFile.SaveToFile(Direc+tempString+'Fe.dat');
//        nDat.SaveToFile(Direc+tempString+'Fe.dat');
//        n_srhDat.SaveToFile(Direc+tempString+'Fe_srh.dat');
        TxtFile.Free;
        DatesDatFile.Free;
        nDat.Free;
        n_srhDat.Free;
       end;
end;

procedure TMainForm.BFeB_xClick(Sender: TObject);
 var Direc:string;
     EB_File,FeGRDFile,FeBGRDFile:TStringList;
     Vec:PVector;
     Row:Int64;
     i:word;
     T:word;
     delFe,Nfe:double;
     tempstr:string;

begin
 OpenDialog1.Filter:='File with energy bands (*.eb)|*.eb';
 if OpenDialog1.Execute()
   then
     begin
      Direc:=ExtractFilePath(OpenDialog1.FileName);
      EB_File:=TStringList.Create;
      FeGRDFile:=TStringList.Create;
      FeBGRDFile:=TStringList.Create;
      EB_File.LoadFromFile(OpenDialog1.FileName);
      new(Vec);
      Row:=0;
      T:=0;
      while (Row<EB_File.Count) do
       begin
        if AnsiPos ('Temperature', EB_File[ROW])>0 then
          T:=round(FloatDataFromRow(EB_File[ROW],2));

        if AnsiPos ('x(um)', EB_File[ROW])>0 then
          begin
//            showmessage(EB_File[ROW]);
            Row:=Row+2;
            for I := 0 to 99 do
             begin
               Vec.Add(290+FloatDataFromRow(EB_File[ROW],2),-FloatDataFromRow(EB_File[ROW],7));
               Inc(ROW);
             end;
            Break;
          end;
         Inc(ROW);
       end;
      for I := 0 to 5 do
       Vec.Add(i*50,Vec^.Y[0]);
      Vec.Sorting();
      Vec.Write_File('Ef_'+NBoronToString+'T'+IntTostr(T)+'.dat',10);
      for I := 0 to Vec^.n - 1 do
       Vec^.Y[i]:=Nfeb(Boron.Data,T,Vec^.Y[i]);

      if FeStepNumber.Data>1 then delFe:=(Log10(FeHi.Data)-Log10(FeLow.Data))/(FeStepNumber.Data-1)
                             else delFe:= Log10(FeHi.Data);
      Nfe:=Log10(FeLow.Data);
      repeat
        FeGRDFile.Clear;
        FeBGRDFile.Clear;
        FeGRDFile.Add('interpolation: linear');
        FeGRDFile.Add('');
        FeGRDFile.Add('x (micrometer)	Nt (1/m3)');

        FeBGRDFile.Add('interpolation: linear');
        FeBGRDFile.Add('');
        FeBGRDFile.Add('x (micrometer)	Nt (1/m3)');
        for I := 0 to Vec^.n - 1 do
         begin
          FeBGRDFile.Add(FloatToStrF(Vec^.X[i],ffExponent,10,2)+'	'+
                        FloatToStrF(Vec^.Y[i]*Power(10,Nfe)*1e6,ffExponent,8,2));
          FeGRDFile.Add(FloatToStrF(Vec^.X[i],ffExponent,10,2)+'	'+
                        FloatToStrF((1-Vec^.Y[i])*Power(10,Nfe)*1e6,ffExponent,8,2));
         end;
        tempstr:= LowerCase(floattostrF(Power(10,Nfe),ffExponent,4,2));
        tempstr:=AnsiReplaceStr(tempstr,'.','p');
        tempstr:=AnsiReplaceStr(tempstr,'+','');
        FeBGRDFile.SaveToFile('FeB'+tempstr+'.grd');
        FeGRDFile.SaveToFile('Fe'+tempstr+'.grd');
        Nfe:=Nfe+delFe;
      until (Nfe>Log10(FeHi.Data*1.0001));

      dispose(Vec);
      EB_File.Free;
      FeGRDFile.Free;
      FeBGRDFile.Free;
     end;
end;

procedure TMainForm.BMaterialFileCreateClick(Sender: TObject);
 var nSiLayer,pSiLayer,Sigma_P,Sigma_N,
     TempMybdf,{pSi_matbdf,nSi_matbdf,}
     Egbdf,mu_nbdf,mu_pbdf:TStringList;
    T:integer;
    tempstr:string;
begin
 Sigma_N:=TStringList.Create;
 Sigma_P:=TStringList.Create;
 nSiLayer:=TStringList.Create;
 pSiLayer:=TStringList.Create;
 TempMybdf:=TStringList.Create;
// pSi_matbdf:=TStringList.Create;
// nSi_matbdf:=TStringList.Create;
 Egbdf:=TStringList.Create;
 mu_nbdf:=TStringList.Create;
 mu_pbdf:=TStringList.Create;

 Sigma_N.Clear;
 Sigma_P.Clear;
 TempMybdf.Clear;
// pSi_matbdf.Clear;
// nSi_matbdf.Clear;
 Egbdf.Clear;
 mu_nbdf.Clear;
 mu_pbdf.Clear;

  T:=TempStart.Data;

// showmessage(floattostr( Diod.Semiconductor.Material.Nc(300)));
//  showmessage(LowerCase(floattostrF( Diod.Semiconductor.Material.Nc(T)/1e6,ffExponent,7,2)));
//  showmessage(LowerCase(floattostrF( Silicon.mu_n(T,0)*1e4,ffExponent,7,2))+'  '+floattostr(Silicon.mu_n(T,1e25)));
//  showmessage(LowerCase(floattostrF( T,ffExponent,9,2)));
//   showmessage(floattostr(3e-4/Silicon.mu_p(T,Boron.Data*1e7)/Boron.Data/1e7/Qelem));
 repeat
  Sigma_N.Add(LowerCase(floattostrf(9.1e-15*exp(-0.024/Kb/T),ffExponent,4,2)));
//  Sigma_P.Add(LowerCase(floattostrf(3.985e-16*exp(-0.045/Kb/T),ffExponent,4,2)));
  Sigma_P.Add(Inttostr(T)+' '+LowerCase(floattostrf(9.1e-15*exp(-0.024/Kb/T),ffExponent,4,2))+' '+
              LowerCase(floattostrf(3.985e-16*exp(-0.045/Kb/T),ffExponent,4,2)));
  TempMybdf.Add(LowerCase('  '+floattostrF( T,ffExponent,9,2)));
  Egbdf.Add(LowerCase(floattostrF( Silicon.Eg(T),ffFixed,7,6)));
  mu_nbdf.Add(LowerCase(floattostrF( Silicon.mu_n(T,0)*1e4,ffExponent,7,2)));
  mu_pbdf.Add(LowerCase(floattostrF( Silicon.mu_p(T,Boron.Data*1e6)*1e4,ffExponent,7,2)));

  nSiLayer.Clear;
  pSiLayer.Clear;
  nSiLayer.Add('material name : n_Si');
  pSiLayer.Add('material name : p_Si');

//  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Vth_n(T)*100,ffExponent,4,2));
{в SCAPS теплові швидкості, а також густини станів у зонах, вважаються
залежними від температури і потрібно задавати їх значення при 300 К }
  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Vth_n(300)*100,ffExponent,4,2));
  nSiLayer.Add('v_th_n :	 '+tempstr+'	 '+tempstr+'	 1.000e+01	 1.000e+01	 1.000e+01	 '+
    tempstr+'	 '+tempstr+'	 0	 0	[cm/s]');
  pSiLayer.Add('v_th_n :	 '+tempstr+'	 '+tempstr+'	 1.000e+01	 1.000e+01	 1.000e+01	 '+
    tempstr+'	 '+tempstr+'	 0	 0	[cm/s]');

//  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Vth_p(T)*100,ffExponent,4,2));
  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Vth_p(300)*100,ffExponent,4,2));
  nSiLayer.Add('v_th_p :	 '+tempstr+'	 '+tempstr+'	 1.000e+01	 1.000e+01	 1.000e+01	 '+
    tempstr+'	 '+tempstr+'	 0	 0	[cm/s]');
  pSiLayer.Add('v_th_p :	 '+tempstr+'	 '+tempstr+'	 1.000e+01	 1.000e+01	 1.000e+01	 '+
    tempstr+'	 '+tempstr+'	 0	 0	[cm/s]');

  nSiLayer.Add('eps :	    11.900000	    11.900000	    1.000000	    10.000000	    10.000000	    11.900000	    11.900000	 0	 0	[-]');
  pSiLayer.Add('eps :	    11.900000	    11.900000	    1.000000	    10.000000	    10.000000	    11.900000	    11.900000	 0	 0	[-]');

  nSiLayer.Add('chi :	  4.050000	  4.050000	  0.100000	  1.000000	  1.000000	  4.050000	  4.050000	 0	 0	[eV]');
  pSiLayer.Add('chi :	  4.050000	  4.050000	  0.100000	  1.000000	  1.000000	  4.050000	  4.050000	 0	 0	[eV]');

  tempstr:=LowerCase(floattostrF( Silicon.Eg(T),ffFixed,7,6));
  nSiLayer.Add('Eg :	  '+tempstr+'	  '+tempstr+'	  0.100000	  1.000000	  1.000000	  '+
      tempstr+'	  '+tempstr+'	 0	 0	[eV]');
  pSiLayer.Add('Eg :	  '+tempstr+'	  '+tempstr+'	  0.100000	  1.000000	  1.000000	  '+
      tempstr+'	  '+tempstr+'	 0	 0	[eV]');

//  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Nc(T)/1e6,ffExponent,7,2));
  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Nc(T)*Power((300/T),1.5)/1e6,ffExponent,7,2));
{в літературі для температурної залежності густин станів передбачаються інші ступені, ніж
1,5, яку використовує SCAPS. Тому для того, щоб програма використовувала правильні
значення, задаємо її значення при 300 К таке, щоб для класичної залежності (T/300)^1.5
виходили значення, яке потрібно}
  nSiLayer.Add('Nc :	 '+tempstr+'	 '+tempstr+'	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[/cm^3]');
  pSiLayer.Add('Nc :	 '+tempstr+'	 '+tempstr+'	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[/cm^3]');

//  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Nv(T)/1e6,ffExponent,7,2));
  tempstr:=LowerCase(floattostrF( Diod.Semiconductor.Material.Nv(T)*Power((300/T),1.5)/1e6,ffExponent,7,2));
  nSiLayer.Add('Nv :	 '+tempstr+'	 '+tempstr+'	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[/cm^3]');
  pSiLayer.Add('Nv :	 '+tempstr+'	 '+tempstr+'	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[/cm^3]');

  tempstr:=LowerCase(floattostrF( Silicon.mu_n(T,1e25)*1e4,ffExponent,7,2));
  nSiLayer.Add('mu_n :	 '+tempstr+'	 '+tempstr+'	 1.000000e-03	 1.000000e+00	 1.000000e+00	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[cm^2/Vs]');
  tempstr:=LowerCase(floattostrF( Silicon.mu_n(T,0)*1e4,ffExponent,7,2));
  pSiLayer.Add('mu_n :	 '+tempstr+'	 '+tempstr+'	 1.000000e-03	 1.000000e+00	 1.000000e+00	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[cm^2/Vs]');

  tempstr:=LowerCase(floattostrF( Silicon.mu_p(T,0)*1e4,ffExponent,7,2));
  nSiLayer.Add('mu_p :	 '+tempstr+'	 '+tempstr+'	 1.000000e-03	 1.000000e+00	 1.000000e+00	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[cm^2/Vs]');
  tempstr:=LowerCase(floattostrF( Silicon.mu_p(T,Boron.Data*1e6)*1e4,ffExponent,7,2));
  pSiLayer.Add('mu_p :	 '+tempstr+'	 '+tempstr+'	 1.000000e-03	 1.000000e+00	 1.000000e+00	 '+
      tempstr+'	 '+tempstr+'	 0	 0	[cm^2/Vs]');

  nSiLayer.Add('Nd(uniform) :	 1.000000e+19	 1.000000e+19	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      '1.000000e+19	 1.000000e+19	 0	 2	[/cm^3]');
  pSiLayer.Add('Nd(uniform) :	 0.000000e+00	 0.000000e+00	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      '0.000000e+00	 0.000000e+00	 0	 2	[/cm^3]');

  nSiLayer.Add('Na(uniform) :	 0.000000e+00	 0.000000e+00	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      '0.000000e+00	 0.000000e+00	 0	 2	[/cm^3]');
   tempstr:=LowerCase(floattostrF( Boron.Data,ffExponent,7,2));
  pSiLayer.Add('Na(uniform) :	 '+tempstr+'	 '+tempstr+'	 1.000000e+01	 1.000000e+01	 1.000000e+01	 '+
      tempstr+'	 '+tempstr+'	 0	 2	[/cm^3]');

  nSiLayer.Add('Tunneling in layer: 1 (0: no tunneling, 1: with tunneling)');
  nSiLayer.Add('Relative electron mass :	 3.400000e-01	 3.400000e-01	 1.000000e+00	 1.000000e+00	 1.000000e+00	 3.400000e-01	 3.400000e-01	 0	 0	[-]');
  nSiLayer.Add('Relative hole mass :	 6.000000e-01	 6.000000e-01	 1.000000e+00	 1.000000e+00	 1.000000e+00	 6.000000e-01	 6.000000e-01	 0	 0	[-]');
  nSiLayer.Add('K_rad :	 1.800000e-15	 1.800000e-15	 1.000000e+01	 1.000000e+01	 1.000000e+01	 1.800000e-15	 1.800000e-15	 0	 0	[cm^3/s]');
  nSiLayer.Add('c_n_auger :	 3.000000e-31	 3.000000e-31	 1.000000e+01	 1.000000e+01	 1.000000e+01	 3.000000e-31	 3.000000e-31	 0	 0	[cm^6/s]');
  nSiLayer.Add('c_p_auger :	 3.000000e-31	 3.000000e-31	 1.000000e+01	 1.000000e+01	 1.000000e+01	 3.000000e-31	 3.000000e-31	 0	 0	[m^6/s]');
  nSiLayer.Add('absorption grading :	 1107.12	 1107.12	  250.00	  250.00	    0.00	 1107.12	 1107.12	 0	 0	[nm]');
  nSiLayer.Add('absorptionmodel pure A material (y=0) : from file');
  nSiLayer.Add('absorptionfile pure A material (y=0) : Si.abs');
  nSiLayer.Add('absorption pure B material (y=1), model : from file');
  nSiLayer.Add('absorption pure B material (y=1), file : Si.abs');

  pSiLayer.Add('Tunneling in layer: 1 (0: no tunneling, 1: with tunneling)');
  pSiLayer.Add('Relative electron mass :	 3.400000e-01	 3.400000e-01	 1.000000e+00	 1.000000e+00	 1.000000e+00	 3.400000e-01	 3.400000e-01	 0	 0	[-]');
  pSiLayer.Add('Relative hole mass :	 6.000000e-01	 6.000000e-01	 1.000000e+00	 1.000000e+00	 1.000000e+00	 6.000000e-01	 6.000000e-01	 0	 0	[-]');
  pSiLayer.Add('K_rad :	 1.800000e-15	 1.800000e-15	 1.000000e+01	 1.000000e+01	 1.000000e+01	 1.800000e-15	 1.800000e-15	 0	 0	[cm^3/s]');
  pSiLayer.Add('c_n_auger :	 3.000000e-31	 3.000000e-31	 1.000000e+01	 1.000000e+01	 1.000000e+01	 3.000000e-31	 3.000000e-31	 0	 0	[cm^6/s]');
  pSiLayer.Add('c_p_auger :	 3.000000e-31	 3.000000e-31	 1.000000e+01	 1.000000e+01	 1.000000e+01	 3.000000e-31	 3.000000e-31	 0	 0	[m^6/s]');
  pSiLayer.Add('absorption grading :	 1107.12	 1107.12	  250.00	  250.00	    0.00	 1107.12	 1107.12	 0	 0	[nm]');
  pSiLayer.Add('absorptionmodel pure A material (y=0) : from file');
  pSiLayer.Add('absorptionfile pure A material (y=0) : Si.abs');
  pSiLayer.Add('absorption pure B material (y=1), model : from file');
  pSiLayer.Add('absorption pure B material (y=1), file : Si.abs');

//  tempstr:=LowerCase(floattostrF( Boron.Data,ffExponent,4,2));
//  tempstr:=AnsiReplaceStr(tempstr,'.','p');
//  tempstr:=AnsiReplaceStr(tempstr,'+','');
//  nSiLayer.SaveToFile('nSi_T'+inttostr(T)+'NB'+tempstr+'.material');
//  nSi_matbdf.Add('file: '+'nSi_T'+inttostr(T)+'NB'+tempstr+'.material');
//  pSiLayer.SaveToFile('pSi_T'+inttostr(T)+'NB'+tempstr+'.material');
//  pSi_matbdf.Add('file: '+'pSi_T'+inttostr(T)+'NB'+tempstr+'.material');

  nSiLayer.SaveToFile('nSi_T'+inttostr(T)+NBoronToString+'.material');
  pSiLayer.SaveToFile('pSi_T'+inttostr(T)+NBoronToString+'.material');

  T:=T+TempStep.Data;
 until (T>TempFinish.Data);

 Sigma_N.SaveToFile('Sigma_n.bdf');
 Sigma_P.SaveToFile('Sigma_p.bdf');
 TempMybdf.SaveToFile('TempMy.bdf');
// pSi_matbdf.SaveToFile('pSi_mat.bdf');
// nSi_matbdf.SaveToFile('nSi_mat.bdf');
 Egbdf.SaveToFile('Eg.bdf');
 mu_nbdf.SaveToFile('mu_n.bdf');
 mu_pbdf.SaveToFile('mu_p.bdf');


 Sigma_N.Free;
 Sigma_P.Free;
 nSiLayer.Free;
 pSiLayer.Free;
 TempMybdf.Free;
// pSi_matbdf.Free;
// nSi_matbdf.Free;
 Egbdf.Free;
 mu_nbdf.Free;
 mu_pbdf.Free;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DecimalSeparator:='.';
  SCAPSFile:=TStringList.Create;
  SCAPSFile.Sorted:=False;
   ConfigFile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'SCapsConv.ini');
  TempStart:=TIntegerParameterShow. Create(STTemp_start,LTemp_start,'Start:',300);
  TempStart.SetName('Temperature');
  TempStart.ReadFromIniFile(ConfigFile);
  TempFinish:=TIntegerParameterShow. Create(STTemp_Finish,LTemp_Finish,'Finish:',350);
  TempFinish.SetName('Temperature');
  TempFinish.ReadFromIniFile(ConfigFile);
  TempStep:=TIntegerParameterShow. Create(STTemp_Step,LTemp_Step,'Step:',10);
  TempStep.SetName('Temperature');
  TempStep.ReadFromIniFile(ConfigFile);
  Boron:=TDoubleParameterShow. Create(STBoron,'Concentration',1e10,5);
  Boron.SetName('Boron');
  Boron.ReadFromIniFile(ConfigFile);

  FeLow:=TDoubleParameterShow. Create(STFe_Lo,LFe_Lo,'Low limit:',1e9,5);
  FeLow.SetName('Iron');
  FeLow.ReadFromIniFile(ConfigFile);
  FeHi:=TDoubleParameterShow. Create(STFe_Hi,LFe_Hi,'High limit:',1e13,5);
  FeHi.SetName('Iron');
  FeHi.ReadFromIniFile(ConfigFile);
  FeStepNumber:=TIntegerParameterShow. Create(STFe_steps,LFe_steps,'Step Number:',25);
  FeStepNumber.SetName('Iron');
  FeStepNumber.ReadFromIniFile(ConfigFile);



 Diod:=TDiod_Schottky.Create;
// Diod.ReadFromIniFile(ConfigFile);
 Diod.Semiconductor.Material:=TMaterial.Create(Si);

// ChangeMaterial(Si);

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Boron.WriteToIniFile(ConfigFile);
  Boron.Free;
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
  Diod.Semiconductor.Material.Free;
  Diod.Free;
  ConfigFile.Free;
  SCAPSFile.Free;
end;

function TMainForm.NBoronToString: string;
begin
  Result:=LowerCase(floattostrF(Boron.Data,ffExponent,4,2));
  Result:=AnsiReplaceStr(Result,'.','p');
  Result:=AnsiReplaceStr(Result,'+','');
  Result:='NB'+Result;
end;

function TMainForm.Nfeb(Nb, T, Ef: double): double;
begin
  Result:=Nb*1e-23*exp(0.582/Kb/T)/(1+Nb*1e-23*exp(0.582/Kb/T))
                  /(1+exp((Ef-0.394)/Kb/T));
end;

end.
