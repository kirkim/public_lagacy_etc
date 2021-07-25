# include "cub3d.h"

static int		is_space_around_position(t_god *god, int row, int col)
{
	if (row <= 0 || row >= god->parse.row || col <= 0 || col >= god->parse.col)
		return (ERROR);
	else if (god->parse.map[row][col + 1] == ' '
	|| god->parse.map[row][col + 1] == '\0' || god->parse.map[row][col - 1] == ' ')
		return (ERROR);
	else if ((int)ft_strlen(god->parse.map[row - 1]) <= col
	|| god->parse.map[row - 1][col] == ' ' || god->parse.map[row - 1][col] == '\0')
		return (ERROR);
	else if ((int)ft_strlen(god->parse.map[row + 1]) <= col
	|| god->parse.map[row + 1][col] == ' ' || god->parse.map[row + 1][col] == '\0')
		return (ERROR);
	return (SUCCESS);
}

static int     set_angle(t_god *god, int row, int col)
{
    char type;

    if (god->player.x != 0 || god->player.y != 0)
        return (ERROR);
    type = god->parse.map[row][col];
    if (type == 'E')
        god->player.rotationAngle = HALF_PI * 0;
    else if (type == 'S')
        god->player.rotationAngle = HALF_PI * 1;
    else if (type == 'W')
        god->player.rotationAngle = HALF_PI * 2;
    else if (type == 'N')
        god->player.rotationAngle = HALF_PI * 3;
    god->player.x = ((double)col + 0.5) * TILE_SIZE;
    god->player.y = ((double)row + 0.5) * TILE_SIZE;

    return (SUCCESS);
}

static int check_map_and_set_player(t_god *god)
{
    int row;
    int col;
    char value;

    row = -1;
    while (god->parse.map[++row] != NULL)
    {
        col = -1;
        while ((value = god->parse.map[row][++col]) != '\0')
        {
            if (ft_strchr("1 ", value) != NULL)
                continue;
            else if (ft_strchr("0", value) != NULL)
            {
                if (is_space_around_position(god, row, col) == ERROR)
                    return (ERROR);
            }
            else if (ft_strchr("NSEW", value) != NULL)
            {
                if (is_space_around_position(god, row, col) == ERROR || set_angle(god, row, col) == ERROR)
                    return (ERROR);
            }
            else
                return (ERROR);
        }
    }
    return (SUCCESS);
}
static int check_type(t_god *god)
{
    int i;

    if (!(god->parse.row) || !(god->parse.col))
        return (ERROR);
    if ((god->parse.ceiling_color == NO_COLOR) || (god->parse.floor_color == NO_COLOR))
        return (ERROR);
    i = -1;
    while (++i < TEXTURE_COUNT)
        if ((god->parse.tex[i].tex_path) == NULL)
            return (ERROR);
    return (SUCCESS);
}

int check_parsing_value(t_god *god)
{
    if (check_type(god) == ERROR)
        return (ERROR);
    if (check_map_and_set_player(god) == ERROR)
        return (ERROR);
    return (SUCCESS);
}