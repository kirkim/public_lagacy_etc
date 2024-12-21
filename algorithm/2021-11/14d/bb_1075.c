#include <stdio.h>

int main(void)
{
	int first_num;
	int second_num;
	int temp;
	int temp2;
	int result;
	int plus;

	scanf("%d %d", &first_num, &second_num);
	temp = first_num % 100;
	temp2 = (first_num - temp) % second_num;
	result = second_num - temp2;
	if (result == second_num)
		result = 0;
	printf("%02d\n", result);
}
