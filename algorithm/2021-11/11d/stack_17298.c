#include <stdio.h>

#define TRUE (1)
#define FALSE (0)

int main(void)
{
	int input_cnt;
	int is_exist;
	int storage[1000000];

	scanf("%d\n", &input_cnt);
	for (int i = 0; i < input_cnt; i++)
	{
		scanf("%d", &storage[i]);
	}
	for (int i = 0; i < input_cnt - 1; i++)
	{
		is_exist = FALSE;
		for (int j = i + 1; j < input_cnt; j++)
		{
			if (storage[j] > storage[i])
			{
				printf("%d ", storage[j]);
				is_exist = TRUE;
				break;
			}
		}
		if (is_exist == FALSE)
			printf("-1 ");
	}
	printf("-1");
}
