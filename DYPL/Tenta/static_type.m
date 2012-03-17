#import <Foundation/Foundation.h>
int main (int argc, const char * argv[])
{
  @autoreleasepool {
    int m = 3; 
    char string[6] = "string";
    NSLog(@"%i", m*string);
  }
  return 0;
}
