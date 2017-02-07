bool _ABVAR_1_button_push= false ;

void setup()
{
  pinMode( 5, INPUT);
  pinMode( 6 , OUTPUT);
}

void loop()
{
  _ABVAR_1_button_push = digitalRead(5) ;
  digitalWrite( 6 , _ABVAR_1_button_push );
  delay( 100 );
}


