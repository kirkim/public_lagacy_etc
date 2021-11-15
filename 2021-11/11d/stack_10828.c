#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct stack_s {
    struct stack_s *next;
    int value;
} stack_t;

void push(stack_t* head, int value)
{
    stack_t *node;
    node = (stack_t*)malloc(sizeof(stack_t));
    node->value = value;
    node->next = head->next;
    head->next = node;
}

int pop(stack_t* head)
{
    int result;
    stack_t* trash;

    result = head->next->value;
    trash = head->next;
    if (head->next->next != NULL)
        head->next = head->next->next;
    else
        head->next = NULL;
    free(trash);

    return result;
}

int main(void) {
    int count;
    char func[20];
    int push_num;
    int i;
    stack_t head;
    int cnt;

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
        else if (strcmp(func, "top") == 0)
        {
            if (cnt > 0)
                printf("%d\n", head.next->value);
            else
                printf("-1\n");
        }
    }
    return (0);
}
