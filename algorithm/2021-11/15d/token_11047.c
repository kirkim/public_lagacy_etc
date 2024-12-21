#include <stdio.h>

int main(void)
{
	int input_num;
	int price;
	int coin[11];
	int cnt;

	cnt = 0;
	scanf("%d %d", &input_num, &price);
	for (int i = 0; i < input_num; i++)
	{
		scanf("%d", &coin[i]);
	}
	while (price != 0)
	{
		while (price >= coin[input_num - 1])
		{
			price -= coin[input_num - 1];
			cnt++;
		}
		input_num--;
	}
	printf("%d\n", cnt);
}
