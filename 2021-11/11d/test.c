#include <stdio.h>

int main(void)
{
	char str[100];

	scanf("%[^\n|.]s", str);
	printf("%s\n", str);
}
