#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;
int main()
{
  string str="123456.11";
  int index= str.find(".");
  float result=0.0f;

  int bitCount=0;
  for(int i=index-1;i>=0;i--)
    {
      result+=(str[i]-'0')*pow(10,bitCount);
      bitCount++;
    }

  bitCount=1;
  for(int i=index+1;i<str.length();i++)
    {
      result+=(str[i]-'0')*pow(10,bitCount*(-1));
      bitCount++;
    }

  std::cout<<fixed<<result<<endl;

  return 0;
}
