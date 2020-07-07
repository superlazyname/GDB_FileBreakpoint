#include "a/test.h"
#include "b/test.h"
#include "c/test.h"

#include <stdio.h>

int main()
{
    test_a();
    test_b();
    test_c();
    
    printf("Hello from main()!\n");
    return 0;
}