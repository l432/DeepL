
#include <iostream>
using namespace std;
int main(void) {
 int year;
 
 cout << "Enter a year: ";
 cin >> year;
 
 // Insert your code here
 if (year%4!=0){
 cout<<"Common year"<<endl;
 }
 else{
  cout<<"Leap year"<<endl;   
 }
 return 0;
}