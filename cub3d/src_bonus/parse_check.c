# include "cub3d.h"

static int put_sprite(t_god *god, int row, int col, int symbol)
{
    int cnt;

    cnt = 0;
    while (god->sprite[cnt].exist == TRUE)
    {
        cnt++;
        if (cnt >= SPRITE_COUNT)
            return (ERROR);
    }
    god->sprite[cnt].x = col * TILE_SIZE + TILE_SIZE / 2;
    god->sprite[cnt].y = row * TILE_SIZE + TILE_SIZE / 2;
    god->sprite[cnt].exist = TRUE;
    god->sprite[cnt].symbol = symbol;

    return (SUCCESS);
}

static int check_bonus_symbol(t_god *god, int row, int col, int value)
{
    if (value == '2')
    {
        if (put_sprite(god, row, col, T_S) == ERROR)
            return (exit_error(god, ERROR, "Too much sprite!"));
    }
    else if (value == 'F')
    {
        if (put_sprite(god, row, col, T_SF) == ERROR)
            return (exit_error(god, ERROR, "Too much sprite!"));
    }
    else if (value == '3')
    {
        if (is_space_around_position(god, row, col) == ERROR || set_door(god, row, col) == ERROR)
            return (exit_error(god, ERROR, "door error!"));
    }
    else if (ft_strchr("05", value) != NULL)
    {
        if (is_space_around_position(god, row, col) == ERROR)
            return (exit_error(god, ERROR, "Empty space next to 0!"));
    }
    else
        return (ERROR);
    return (SUCCESS);
}

static int check_symbol(t_god *god)
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
            else if (ft_strchr("NSEW", value) != NULL)
            {
                if (is_space_around_position(god, row, col) == ERROR || set_angle(god, row, col) == ERROR)
                    return (exit_error(god, ERROR, "Empty space next to NSEW!"));
            }
            else if (ft_strchr("2305F", value) != NULL)
            {
                if (check_bonus_symbol(god, row, col, value) == ERROR)
                    return (ERROR);
            }
        }
    }
    return (SUCCESS);
}

static int check_type(t_god *god)
{
    int i;

    if (!(god->parse.row) || !(god->parse.col))
        return (exit_error(god, ERROR, "Row and Col wasn't parsed!"));
    if ((god->parse.ceiling_color == NO_COLOR) || (god->parse.floor_color == NO_COLOR))
        return (exit_error(god, ERROR, "Ceiling and Floor color wasn't parsed!"));
    i = -1;
    while (++i < TEXTURE_COUNT)
        if ((god->parse.tex[i].tex_path) == NULL)
            return (exit_error(god, ERROR, "Some texture weren't parsed!"));
    return (SUCCESS);
}

int check_parsing_value(t_god *god)
{
    if (check_type(god) == ERROR)
        return (exit_error(god, ERROR, "NOT PARSDED_TYPE"));
    if (check_symbol(god) == ERROR)
        return (exit_error(god, ERROR, "NOT PARSDED_MAP"));
    return (SUCCESS);
}