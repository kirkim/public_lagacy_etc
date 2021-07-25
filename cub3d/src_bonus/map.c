#include "cub3d.h"

void    setting_map_location(t_parse *parse, int *x, int *y, int x2, int y2)
{
    if (MAP_LOCATION == LEFTUP_MAP)
    {
        *x = (int)(MINIMAP_SCALE * x2);
        *y = (int)(MINIMAP_SCALE * y2);
    }
    else if (MAP_LOCATION == LEFTDOWN_MAP)
    {
        *x = (int)(MINIMAP_SCALE * x2);
        *y = (int)((1 - MINIMAP_SCALE) * TILE_SIZE * parse->row + MINIMAP_SCALE * y2);
    }
    else if (MAP_LOCATION == RIGHTUP_MAP)
    {
        *x = (int)((1 - MINIMAP_SCALE) * TILE_SIZE * parse->col + MINIMAP_SCALE * x2);
        *y = (int)(MINIMAP_SCALE * y2);
    }
    else if (MAP_LOCATION == RIGHTDOWN_MAP)
    {
        *x = (int)((1 - MINIMAP_SCALE) * TILE_SIZE * parse->col + MINIMAP_SCALE * x2);
        *y = (int)((1 - MINIMAP_SCALE) * TILE_SIZE * parse->row + MINIMAP_SCALE * y2);
    }
}

void fill_squares(t_god *god, int x, int y, int color)
{
	int i;
	int j;

	setting_map_location(&god->parse, &x, &y, x, y);
	j = -1;
	while (++j < (int)(MINIMAP_SCALE * TILE_SIZE))
	{
		i = -1;
		while (++i < (int)(MINIMAP_SCALE * TILE_SIZE))
		{
			god->img.data[(int)(god->map.window_width) * (y + j) + (x + i)] = color;
		}
	}
}

void    init_map(t_god *god)
{
    int x;
    int y;

    y = -1;
    while (++y < god->map.window_height)
    {
        x = -1;
        while (++x < god->map.window_width)
            god->img.data[god->map.window_width * y + x] = NO_COLOR;
    }
}

void	render_map(t_god *god)
{
	int col;
	int row;
    init_map(god);
	row = -1;
	while (++row < god->parse.row)
	{
		col = -1;
		while (++col < god->parse.col)
		{
			if (god->map.map[row][col] == '1')
				fill_squares(god, (int)(TILE_SIZE * col), (int)(TILE_SIZE * row), 0x000000);
            else if (god->map.map[row][col] == ' ')
                fill_squares(god, (int)(TILE_SIZE * col), (int)(TILE_SIZE * row), NO_COLOR);
            else if (ft_strchr("2F", god->map.map[row][col]) != NULL)
                fill_squares(god, (int)(TILE_SIZE * col), (int)(TILE_SIZE * row), 0x00ff00);
            else if (god->map.map[row][col] == '3')
                fill_squares(god, (int)(TILE_SIZE * col), (int)(TILE_SIZE * row), 0x00ffff);
            else if (god->map.map[row][col] == '5')
                fill_squares(god, (int)(TILE_SIZE * col), (int)(TILE_SIZE * row), 0x843600);
            else if (god->map.map[row][col] == '4')
                fill_squares(god, (int)(TILE_SIZE * col), (int)(TILE_SIZE * row), 0x883388);
			else
				fill_squares(god, (int)(TILE_SIZE * col), (int)(TILE_SIZE * row), 0xffffff);
		}
	}
}