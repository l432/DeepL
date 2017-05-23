int vec_Notes[8];

int _ABVAR_1_TimeOut = 0 ;
int _ABVAR_2_Red_Pin = 0 ;
int _ABVAR_3_Green_Pin = 0 ;
int _ABVAR_4_Blue_Pin = 0 ;
int _ABVAR_5_ColorNumber = 0 ;
int _ABVAR_6_OktavaNumber = 0 ;
int _ABVAR_7_TonePin = 0 ;
int _ABVAR_8_Vx = 0 ;
int _ABVAR_9_Vy = 0 ;
int _ABVAR_10_VxNow = 0 ;

void Red();
void White();
void Purple();
void Yellow();
void Blue();
void Dark();
void LightBlue();
void SetColor();
void Orange();
void Green();

void setup()
{
  for (int i=0;i<8;i++) vec_Notes[i]=0;

  pinMode( 1 , OUTPUT);
  pinMode( _ABVAR_2_Red_Pin , OUTPUT);
  pinMode( _ABVAR_3_Green_Pin , OUTPUT);
  pinMode( _ABVAR_4_Blue_Pin , OUTPUT);

  vec_Notes[1 - 1] = 33 ;

  vec_Notes[2 - 1] = 37 ;

  vec_Notes[3 - 1] = 41 ;

  vec_Notes[4 - 1] = 44 ;

  vec_Notes[5 - 1] = 49 ;

  vec_Notes[6 - 1] = 55 ;

  vec_Notes[7 - 1] = 58 ;

  vec_Notes[8 - 1] = 62 ;

  _ABVAR_1_TimeOut = 50 ;

  _ABVAR_2_Red_Pin = 9 ;

  _ABVAR_3_Green_Pin = 11 ;

  _ABVAR_4_Blue_Pin = 10 ;

  _ABVAR_5_ColorNumber = 3 ;

  _ABVAR_6_OktavaNumber = 4 ;

  _ABVAR_7_TonePin = 13 ;

  _ABVAR_8_Vx = 0 ;

  _ABVAR_9_Vy = 1 ;

}

void loop()
{
  if (( ( analogRead(_ABVAR_9_Vy) ) > ( 1000 ) ))
  {
    _ABVAR_5_ColorNumber = ( _ABVAR_5_ColorNumber - 1 ) ;
    if (( ( _ABVAR_5_ColorNumber ) < ( 1 ) ))
    {
      _ABVAR_5_ColorNumber = 1 ;
    }
    _ABVAR_6_OktavaNumber = ( _ABVAR_6_OktavaNumber / 2 ) ;
    if (( ( _ABVAR_6_OktavaNumber ) < ( 1 ) ))
    {
      _ABVAR_6_OktavaNumber = 1 ;
    }
    delay( 50 );
  }
  if (( ( analogRead(_ABVAR_9_Vy) ) < ( 20 ) ))
  {
    _ABVAR_5_ColorNumber = ( _ABVAR_5_ColorNumber + 1 ) ;
    if (( ( _ABVAR_5_ColorNumber ) > ( 8 ) ))
    {
      _ABVAR_5_ColorNumber = 8 ;
    }
    _ABVAR_6_OktavaNumber = ( _ABVAR_6_OktavaNumber * 2 ) ;
    if (( ( _ABVAR_6_OktavaNumber ) > ( 128 ) ))
    {
      _ABVAR_6_OktavaNumber = 128 ;
    }
    delay( 50 );
  }
  SetColor();
  _ABVAR_10_VxNow = analogRead(_ABVAR_8_Vx) ;
  if (( ( _ABVAR_10_VxNow ) < ( 100 ) ))
  {
    digitalWrite( 1 , LOW );
    tone(_ABVAR_7_TonePin, ( vec_Notes[1 - 1] * _ABVAR_6_OktavaNumber ));
    delay( _ABVAR_1_TimeOut );
    digitalWrite( 1 , HIGH );
  }
}

void Blue()
{
  analogWrite(_ABVAR_2_Red_Pin , 255);
  analogWrite(_ABVAR_3_Green_Pin , 255);
  analogWrite(_ABVAR_4_Blue_Pin , 0);
}

void LightBlue()
{
  analogWrite(_ABVAR_2_Red_Pin , 255);
  analogWrite(_ABVAR_3_Green_Pin , 0);
  analogWrite(_ABVAR_4_Blue_Pin , 0);
}

void SetColor()
{
  if (( ( _ABVAR_5_ColorNumber ) == ( 1 ) ))
  {
    Red();
  }
  if (( ( _ABVAR_5_ColorNumber ) == ( 2 ) ))
  {
    Orange();
  }
  if (( ( _ABVAR_5_ColorNumber ) == ( 3 ) ))
  {
    Yellow();
  }
  if (( ( _ABVAR_5_ColorNumber ) == ( 4 ) ))
  {
    Green();
  }
  if (( ( _ABVAR_5_ColorNumber ) == ( 5 ) ))
  {
    LightBlue();
  }
  if (( ( _ABVAR_5_ColorNumber ) == ( 6 ) ))
  {
    Blue();
  }
  if (( ( _ABVAR_5_ColorNumber ) == ( 7 ) ))
  {
    Purple();
  }
  if (( ( _ABVAR_5_ColorNumber ) == ( 8 ) ))
  {
    White();
  }
}

void Dark()
{
  analogWrite(_ABVAR_2_Red_Pin , 255);
  analogWrite(_ABVAR_3_Green_Pin , 255);
  analogWrite(_ABVAR_4_Blue_Pin , 255);
}

void Orange()
{
  analogWrite(_ABVAR_2_Red_Pin , 0);
  analogWrite(_ABVAR_3_Green_Pin , 125);
  analogWrite(_ABVAR_4_Blue_Pin , 255);
}

void Yellow()
{
  analogWrite(_ABVAR_2_Red_Pin , 0);
  analogWrite(_ABVAR_3_Green_Pin , 0);
  analogWrite(_ABVAR_4_Blue_Pin , 255);
}

void Purple()
{
  analogWrite(_ABVAR_2_Red_Pin , 0);
  analogWrite(_ABVAR_3_Green_Pin , 255);
  analogWrite(_ABVAR_4_Blue_Pin , 0);
}

void Red()
{
  analogWrite(_ABVAR_2_Red_Pin , 0);
  analogWrite(_ABVAR_3_Green_Pin , 255);
  analogWrite(_ABVAR_4_Blue_Pin , 255);
}

void Green()
{
  analogWrite(_ABVAR_2_Red_Pin , 255);
  analogWrite(_ABVAR_3_Green_Pin , 0);
  analogWrite(_ABVAR_4_Blue_Pin , 255);
}

void White()
{
  analogWrite(_ABVAR_2_Red_Pin , 0);
  analogWrite(_ABVAR_3_Green_Pin , 0);
  analogWrite(_ABVAR_4_Blue_Pin , 0);
}


