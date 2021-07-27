#include "cub3d.h"

double	normalize_angle(double angle)
{
	if (angle >= 0)
	{
		while (angle >= TWO_PI)
			angle -= TWO_PI;
	}
	else
	{
		while (angle <= 0)
			angle += TWO_PI;
	}
	return (angle);
}

void	set_point(t_point *p, double x, double y)
{
	p->x = x;
	p->y = y;
}

int	check_edge(t_god *god, const t_point *p1, const t_point *p2)
{
	int	dx;
	int	dy;
	int	dx2;
	int	dy2;

	dx = (int)(p1->x / TILE_SIZE) - (int)(p2->x / TILE_SIZE);
	dy = (int)(p1->y / TILE_SIZE) - (int)(p2->y / TILE_SIZE);
	dx2 = (int)(p1->x / TILE_SIZE);
	dy2 = (int)(p1->y / TILE_SIZE);
	if (dx == 1 && dy == 1)
		return ((ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL)
			&& (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL));
	if (dx == 1 && dy == -1)
		return ((ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL)
			&& (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL));
	if (dx == -1 && dy == 1)
		return ((ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL)
			&& (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL));
	if (dx == -1 && dy == -1)
		return ((ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL)
			&& (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL));
	return (FALSE);
}

void	cal_distance(t_god *god, t_dpable_ray *hv)
{
	if (hv->found_wall_hit == TRUE)
		hv->distance = distance_between_points(god->player.x, god->player.y,
				hv->wall_hit_x, hv->wall_hit_y);
	else
		hv->distance = 111111;
}

double	cal_sprite_degree(t_god *god, t_sprite sprite)
{
	double	angle;

	angle = normalize_angle(god->player.rota_angle)
		- atan2(sprite.y - god->player.y, sprite.x - god->player.x);
	if (angle > PI)
		angle -= TWO_PI;
	else if (angle < -1 * PI)
		angle += TWO_PI;
	return (fabs(angle));
}
