#include "cub3d.h"

void    free_memory(void *memory)
{
    if (memory != NULL)
    {
        free(memory);
        memory = NULL;
    }
}
int     free_memory_return(void *memory, int return_code)
{
    free_memory(memory);
    return (return_code);
}
void    free_texture_array(t_god *god)
{
    for (int i = 0; i < TEXTURE_COUNT; i++)
	{
		free_memory(god->parse.tex[i].texture);
	}
}
void    free_array_memory(void **memory, int index)
{
    if (memory == NULL)
        return ;
    while (index-- > 0)
        free_memory(memory[index]);
    free_memory(memory);
}

int    exit_cub3d(t_god *god, int exit_code)
{
    if (god->img.ptr)
        mlx_destroy_image(god->mlx, god->img.ptr);
    if (god->win)
        mlx_destroy_window(god->mlx, god->win);
    //if (god->mlx)
        //mlx_destroy_display(god->mlx);
    if (god)
        exit(exit_code);
    else
        exit(0);
    return (exit_code);
}

int    exit_error(t_god *god, int exit_code, const char *message)
{
    write(2, "ERROR\n", 6);
    if (message)
    {
        write(2, message, ft_strlen(message));
        write(2, "\n", 1);
    }
    exit_cub3d(god, exit_code);
    return (exit_code);
}