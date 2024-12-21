#include <stdio.h>

int main(int argc, char *argv[])
{
    printf("this is last break time!\n");
    if (argc > 2)
    {
        printf("please write without spaces!\n");
        return (0);
    }
    else if (argc == 1)
    {
        printf("please write something you want to say!\n");
        return (0);
    }
    printf("you say: %s\n", argv[1]);

    return (0);
}
