#include "cub3d.h"

int do_parsing(t_parse *parse, int g_ret, int type, char *line)
{
    if (type >= T_NO && type <= T_SF)
    {
        if (parse->tex[type].tex_path || !(parse->tex[type].tex_path = parse_path_malloc(line)))
            return (free_memory_return(line, ERROR));
    }
    else if (type == T_CEIL || type == T_FLOOR)
    {
        if ((type == T_CEIL && (parse_color(&parse->ceiling_color, line)) == ERROR)
            || (type == T_FLOOR && (parse_color(&parse->floor_color, line)) == ERROR))
            return (free_memory_return(line, ERROR));
    }
    else
    {
        parse->temp_map = update_map_malloc(parse->temp_map, line);
        if (g_ret == 0 && parse_map(parse) == ERROR)
            return (free_memory_return(line, ERROR));

    }
    return (free_memory_return(line, SUCCESS));
}

int parse_file(t_god *god, const char *cub_file_path)
{
    int     fd;
    char    *line;
    int     gnl_ret;
    int     parse_type;

    if (!(is_cub_file(cub_file_path)))
        return (exit_error(god, ERROR, "NOT \".cub\" FILE"));
    if ((fd = open(cub_file_path, O_RDONLY)) < 0)
        return (exit_error(god, ERROR, "WRONG FILE PATH OR CAN'T OPEN!"));
    gnl_ret = 1;
    while ((gnl_ret = get_next_line(fd, &line)) > 0)
    {
        if (line[0] == '\0')
            continue;
        if ((parse_type = check_parse_type(line)) == T_ERROR)
            return (exit_error(god, ERROR, "WRONG PARSE TYPE"));
        if (do_parsing(&god->parse, gnl_ret, parse_type, line) == ERROR)
            return (ERROR);
    }
    do_parsing(&god->parse, gnl_ret, parse_type, line);
    close(fd);

    return (SUCCESS);
}