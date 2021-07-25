#include "cub3d.h"

static int is_cub_file(const char *cub_file_path)
{
    int file_len;
    int is_same;

    file_len = ft_strlen(cub_file_path);
    if (ft_strncmp(cub_file_path + file_len - 4, ".cub", 4) == 0)
        is_same = TRUE;
    else
        is_same = FALSE;
    return (is_same);
}

int     find_char(const char *value, char c)
{
    while (*value != '\0')
    {
        if (*value == c)
            return TRUE;
        value++;
    }
    return FALSE;
}

int     is_map_valid(char *line)
{
    int i;

    i = 0;
    while (line[i])
    {
        if (find_char("01NSEW ", line[i]) == FALSE)
            return (FALSE);
        i++;
    }
    return (TRUE);
}

static int check_parse_type(char *line)
{
	if (line[0] == 'N' && line[1] == 'O')
		return (T_NO);
	else if (line[0] == 'S' && line[1] == 'O')
		return (T_SO);
	else if (line[0] == 'W' && line[1] == 'E')
		return (T_WE);
	else if (line[0] == 'E' && line[1] == 'A')
		return (T_EA);
	else if (line[0] == 'F' && line[1] == ' ')
		return (T_FLOOR);
	else if (line[0] == 'C' && line[1] == ' ')
		return (T_CEIL);
	else if (is_map_valid(line))
		return (T_MAP);
	return (T_ERROR);
}

int parse_color(int *cf, char *line)
{
    int i;
    int x;
    int color;
    char **color_malloc;

    *cf = 0;
    while (is_upper(*line) == TRUE)
        line++;
    while (is_space(*line) == TRUE)
        line++;
    if ((color_malloc = ft_split(line, ',')) == NULL)
        return (ERROR);
    i = -1;
    while (++i < 3)
    {
        *cf *= 256;
        x = -1;
        color = 0;
        while (color_malloc[i][++x] != '\0')
        {
            if (ft_isdigit(color_malloc[i][x]) == FALSE)
                return (ERROR);
            color = color * 10 + color_malloc[i][x] - '0';
        }
        *cf += color;
    }
    free_array_memory((void**)color_malloc, 3);
    return (SUCCESS);
}

char *parse_path_malloc(char *line)
{
    char    *temp_malloc; 

    while (is_upper(*line) == TRUE)
        line++;
    while (is_space(*line) == TRUE)
        line++;
    if((temp_malloc = ft_strdup(line)) == NULL)
        return (NULL);
    return (temp_malloc);
}

char    *update_map_malloc(char *s1, char *s2)
{
    char *temp;
    char *result;

    if (s1 == NULL)
        s1 = ft_strdup("");
    temp = ft_strjoin(s1, "\n");
    result = ft_strjoin(temp, s2);
    free_memory(s1);
    free_memory(temp);
    
    return (result);
}

int     parse_map(t_parse *parse)
{
    int row;
    int col;

    if((parse->map = ft_split(parse->temp_map, '\n')) == NULL)
        return (free_memory_return(parse->temp_map, ERROR));
    row = -1;
    col = 0;
    while (parse->map[++row] != NULL)
        if (ft_strlen(parse->map[row]) > col)
            col = ft_strlen(parse->map[row]);
    parse->row = row;
    parse->col = col;
    /* config->tile = config->width / config->colums; */
    return (free_memory_return(parse->temp_map, SUCCESS));
}
int do_parsing(t_parse *parse, int g_ret, int type, char *line)
{
    if (type >= T_NO && type <= T_EA)
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
