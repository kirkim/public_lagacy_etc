#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct stack_s {
    struct stack_s *next;
	struct stack_s *before;
	struct stack_s *front;
	int value;
} s_t;

void push(s_t* head, int value)
{
    s_t *node;
    node = (s_t*)malloc(sizeof(s_t));
    node->value = value;
	node->next = head->next;
	if (node->next != NULL)
		node->next->before = node;
	if (head->front == NULL)
		head->front = node;
	head->next = node;
}

int pop(s_t* head)
{
    int result;

    result = head->front->value;
	if (head->front->before != NULL)
		head->front = head->front->before;
	else
		head->front = NULL;
	return result;
}

int main(void) {
    int count;
    char func[20];
    int push_num;
    int i;
    s_t head;
	int cnt;

	head.next = NULL;
	head.before = NULL;
	head.front = NULL;
	scanf("%d", &count);
	i = 0;
    cnt = 0;
    while (i++ < count)
    {
        scanf("%s", func);
        if (strcmp(func, "push") == 0)
        {
            scanf("%d", &push_num);
            push(&head, push_num);
            cnt++;
        }
        else if (strcmp(func, "pop") == 0)
        {
            if (cnt > 0)
            {
                printf("%d\n", pop(&head));
                cnt--;
            }
            else
                printf("-1\n");
        }
        else if (strcmp(func, "size") == 0)
        {
            printf("%d\n", cnt);
        }
        else if (strcmp(func, "empty") == 0)
        {
            if (cnt < 1)
                printf("1\n");
            else
                printf("0\n");
        }
        else if (strcmp(func, "front") == 0)
        {
            if (cnt > 0)
                printf("%d\n", head.front->value);
            else
                printf("-1\n");
        }
		else if (strcmp(func, "back") == 0)
        {
            if (cnt > 0)
                printf("%d\n", head.next->value);
            else
                printf("-1\n");
        }
    }
    return (0);
}
