#include "cub3d.h"

int	find_char(const char *value, char c)
{
	while (*value != '\0')
	{
		if (*value == c)
			return (TRUE);
		value++;
	}
	return (FALSE);
}

int	set_angle(t_god *god, int row, int col)
{
	char	type;

	if (god->player.x != 0 || god->player.y != 0)
		return (exit_error(god, ERROR, "There may be more than one NSEW!"));
	type = god->parse.map[row][col];
	if (type == 'E')
		god->player.rota_angle = HALF_PI * 0;
	else if (type == 'S')
		god->player.rota_angle = HALF_PI * 1;
	else if (type == 'W')
		god->player.rota_angle = HALF_PI * 2;
	else if (type == 'N')
		god->player.rota_angle = HALF_PI * 3;
	god->player.x = ((double)col + 0.5) * TILE_SIZE;
	god->player.y = ((double)row + 0.5) * TILE_SIZE;
	return (SUCCESS);
}

char	*update_map_malloc(char *s1, char *s2)
{
	char	*temp;
	char	*result;

	if (s1 == NULL)
		s1 = ft_strdup("");
	temp = ft_strjoin(s1, "\n");
	result = ft_strjoin(temp, s2);
	free_memory(s1);
	free_memory(temp);
	return (result);
}
