#include <stdio.h>

#define TRUE (1)
#define FALSE (0)

int main(void)
{
	int input_cnt;
	char input[51];
	int flag;
	int is_vps = TRUE;

	scanf("%d", &input_cnt);
	while(input_cnt-- > 0)
	{
		for (int i = 0; i < 51; i++) {
			input[i] = 0;
		}
		scanf("%s", input);
		flag = 0;
		is_vps = TRUE;
		for (int i = 0; input[i]; i++)
		{
			if(input[i] == '(')
			{
				flag++;
			} else if(input[i] == ')')
			{
				flag--;
				if (flag < 0)
				{
					is_vps = FALSE;
					break;
				}
			}
		};
		if (is_vps == FALSE || flag != 0)
			printf("NO\n");
		else if (is_vps == TRUE)
			printf("YES\n");
	}
}
