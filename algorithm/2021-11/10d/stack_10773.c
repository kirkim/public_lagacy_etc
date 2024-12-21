#include <stdio.h>

int main(void) {

	int input_cnt;
	int storage[100000];
	int value;
	int index;
	int result_sum;

	scanf("%d", &input_cnt);

	index = 0;
	while (input_cnt-- > 0)
	{
		scanf("%d", &value);
		if (value == 0)
		{
			index--;
		}
		else
		{
			storage[index] = value;
			index++;
		}
	}
	result_sum = 0;
	while (--index >= 0)
	{
		result_sum += storage[index];
	}
	printf("%d\n", result_sum);

	return (0);
}
