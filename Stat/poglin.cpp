#include <stdio.h>
#include <stdlib.h>
#include <math.h>


using namespace std;
float Eg(float Eg0, float al, float bet, float T);
float dod1(float l, float Eg, float Ep, float T);
float dod2(float l, float Eg, float Ep, float T);

main()

{	
const float Eg01=1.1557, Eg02=2.5;
const float al=7.021e-4, bet=1108;
const float Ep1=1.827e-2, Ep2=5.773e-2;
const float C1=5.5, C2=4;
const float A1=3.231e2, A2=7.237e3;
const float l1=9e-7, l2=9.5e-7;

//const float c=3e8, k=8.625e-5, h=6.63e-34, e=1.6e-19;
//float hce=h*c/e;
int T;
float b1,b2,b3,b4;
float gam1,gam2;

FILE *fp;

if ((fp=fopen("poglin.dat", "w"))==NULL)
    { 
      puts("Cannot open file");
      exit (1);
    } 
 
 
for (T=280; T<=360; T+=10)
{
b1=A1*(dod1(l1,Eg(Eg01,al,bet,T),Ep1,T)+dod2(l1,Eg(Eg01,al,bet,T),Ep1,T));
b2=A2*(dod1(l1,Eg(Eg02,al,bet,T),Ep1,T)+dod2(l1,Eg(Eg02,al,bet,T),Ep1,T));
b3=A1*(dod1(l1,Eg(Eg01,al,bet,T),Ep2,T)+dod2(l1,Eg(Eg01,al,bet,T),Ep2,T));
b4=A2*(dod1(l1,Eg(Eg02,al,bet,T),Ep2,T)+dod2(l1,Eg(Eg02,al,bet,T),Ep2,T));
gam1=C1*(b1+b2)+C2*(b3+b4);

b1=A1*(dod1(l2,Eg(Eg01,al,bet,T),Ep1,T)+dod2(l2,Eg(Eg01,al,bet,T),Ep1,T));
b2=A2*(dod1(l2,Eg(Eg02,al,bet,T),Ep1,T)+dod2(l2,Eg(Eg02,al,bet,T),Ep1,T));
b3=A1*(dod1(l2,Eg(Eg01,al,bet,T),Ep2,T)+dod2(l2,Eg(Eg01,al,bet,T),Ep2,T));
b4=A2*(dod1(l2,Eg(Eg02,al,bet,T),Ep2,T)+dod2(l2,Eg(Eg02,al,bet,T),Ep2,T));
gam2=C1*(b1+b2)+C2*(b3+b4);


 printf("%d %g %g\n", T, gam1, gam2);
 fprintf(fp,"%d %g %g\n", T, gam1, gam2);

//  printf("%d %g\n", T, Eg(Eg02,al,bet,T));

}
 getchar();
//	return 0;
}


float Eg(float Eg0, float al, float bet, float T)
{
float rez;
rez=Eg0-al*T*T/(T+bet);
return rez;
}

float dod1(float l, float Eg, float Ep, float T)
{
const float c=3e8, k=8.625e-5, h=6.63e-34, e=1.6e-19;
float hce=h*c/e;
float rez, temp;
temp=hce/l-Eg+Ep;
rez=pow(temp,2)/(exp(Ep/k/T)-1);
return rez;      
}

float dod2(float l, float Eg, float Ep, float T)
{
const float c=3e8, k=8.625e-5, h=6.63e-34, e=1.6e-19;
float hce=h*c/e;
float rez, temp;
temp=hce/l-Eg-Ep;
rez=pow(temp,2)/(1-exp(-Ep/k/T));
return rez;      
}
