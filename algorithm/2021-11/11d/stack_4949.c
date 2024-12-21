#include <stdio.h>

# define TRUE (1)
# define FALSE (2)
# define SMALL_BRK (3)
# define BIG_BRK (4)
# define STR_SIZE (101)

void init_string(char *str)
{
	for (int i = 0; i < STR_SIZE; i++)
	{
		str[i] = 0;
	}
}

int main(void)
{
	char string[STR_SIZE];
	char bracket[STR_SIZE];
	int b_index;
	int is_success;
	char trash;

	while(TRUE)
	{
		b_index = -1;
		is_success = TRUE;
		init_string(string);
		scanf("%[^\n]s", string);
		scanf("%c", &trash);
		if (string[0] == '.')
		{
			break;
		}
		for (int i = 0; string[i] != '\0'; i++)
		{
			switch (string[i])
			{
				case '(':
					b_index++;
					bracket[b_index] = '(';
					break;
				case ')':
					if (b_index < 0 || bracket[b_index] != '(')
					{
						is_success = FALSE;
						break;
					}
					b_index--;
					break;
				case '[':
					b_index++;
					bracket[b_index] = '[';
					break;
				case ']':
					if (b_index < 0 || bracket[b_index] != '[')
					{
						is_success = FALSE;
						break;
					}
					b_index--;
					break;
			}
			if (is_success == FALSE)
			{
				break;
			}
		}
		if (b_index > -1 || is_success == FALSE)
		{
			printf("no\n");
		}
		else
		{
			printf("yes\n");
		}
	}
}
