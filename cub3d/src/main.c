#include "cub3d.h"

static void special_init(t_god *god)
{
	god->parse.floor_color = NO_COLOR;
	god->parse.ceiling_color = NO_COLOR;
}
void    make_even_value(int *num1, int *num2)
{
    if (*num1 % 2 != 0)
        *num1 += 1;

    if (*num2 % 2 != 0)
        *num2 += 1;
}
void    set_map(t_god *god)
{
    int y;
    int row;
    int col;

    god->map.map = (char **)malloc(sizeof(char *) * god->map.map_rows);
    y = -1;
    while (++y < god->map.map_rows)
        god->map.map[y] = (char *)malloc(sizeof(char) * (god->map.map_cols + 1));
    row = -1;
    while (++row < god->parse.row)
    {
        col = -1;
        while (god->parse.map[row][++col] != '\0')
            god->map.map[row][col] = god->parse.map[row][col];
		col--;
		while (++col < god->map.map_cols)
        	god->map.map[row][col] = ' ';
        god->map.map[row][col] = '\0';
    }
    free_array_memory((void **)god->parse.map, god->parse.row);
}
static void ft_init(t_god *god)
{
	god->map.map_rows = god->parse.row;
    god->map.map_cols = god->parse.col;
	make_even_value(&god->map.map_rows, &god->map.map_cols);
    god->map.window_height = god->parse.row * TILE_SIZE;
    god->map.window_width = god->parse.col * TILE_SIZE;
    god->map.ray_count = god->map.window_width / WALL_STRIP_WIDTH;
	set_map(god);
	god->mlx = mlx_init();
	god->win = mlx_new_window(god->mlx, god->map.window_width, god->map.window_height, "mlx_title");
	god->img.ptr = mlx_new_image(god->mlx, god->map.window_width, god->map.window_height);
	god->img.data = (int *)mlx_get_data_addr(god->img.ptr, &(god->img.bpp), &(god->img.line_size), &(god->img.endian));
}
int		find_color(t_god *god, int col, int row)
{
	int color;
	int height = god->parse.tex[1].height;
	int width = god->parse.tex[1].width;
	int result_row = (height * row) / god->map.window_height;
	int result_col = (width * col) / god->map.window_width;
	color = god->parse.tex[1].texture[width * result_row + result_col];
	return (color);
}

int main(int argc, char **argv)
{
	t_god god;

	if (argc != 2)
		return (exit_error(&god, ERROR, "WRONG ARGUMENT COUNT!"));
	ft_memset(&god, 0, sizeof(t_god));
	special_init(&god);	
	if (parse_file(&god, argv[1]) == ERROR)
		return (exit_error(&god, ERROR, "FAIL PARSING!"));

	if (check_parsing_value(&god) == ERROR)
		return (exit_error(&god, ERROR, "WRONG PARSING VALUE SAVED!"));
	ft_init(&god);
	load_texture(&god);
	render_player(&god);
    
	/*
	for (int i = 0; i < god.map.map_rows; i++)
	{
		for (int j = 0; j < god.map.map_cols; j++)
			printf("%c ", god.map.map[i][j]);
		printf("\n");
	}
	printf("%d %d", god.map.map_rows, god.map.map_cols);*/
	/*
	for (int i = 0; i < god.parse.row; i++)
	{
		for (int j = 0; j <= god.parse.col; j++)
			printf("%c ", god.parse.map[i][j]);
		printf("\n");
	}*/
	
	mlx_put_image_to_window(god.mlx, god.win, god.img.ptr, 0, 0);
    mlx_loop(god.mlx);
	
	free_texture_array(&god);
	return (0);
}
