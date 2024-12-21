#include <stdio.h>

#define TRUE (1)
#define FALSE (0)

int main(void)
{
	int range;
	int index;
	int temp_num;
	int is_success;
	int s_i;
	int r_i;
	int storage[100001];
	char result[200002];

	scanf("%d", &range);
	is_success = TRUE;
	s_i = -1;
	r_i = -1;
	index = 1;
	for (int i = 0; i < range; i++)
	{
		scanf("%d", &temp_num);
		while (index <= temp_num)
		{
			s_i++;
			r_i++;
			storage[s_i] = index;
			result[r_i] = '+';
			index++;
		}
		if (storage[s_i] != temp_num)
		{
			is_success = FALSE;
			break;
		}
		r_i++;
		s_i--;
		result[r_i] = '-';
	}
	if (is_success == FALSE)
	{
		printf("NO");
	}
	else
	{
		for (int i = 0; i <= r_i; i++)
		{
			printf("%c\n", result[i]);
		}
	}
}
