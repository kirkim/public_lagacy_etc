#include "cub3d.h"

int is_upper(char c)
{
    if (c >= 'A' && c <= 'Z')
        return (TRUE);
    return (FALSE);
}
int is_space(char c)
{
    if (c == ' ' || c == '\n' || c == '\t' || c == '\v' || c == '\f' || c == '\r')
        return (TRUE);
    return (FALSE);
}

double normalize_angle(double angle)
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
    return angle;
}
int check_edge(t_god *god, double x1, double x2, double y1, double y2)
{
    int dx;
    int dy;

    dx = (int)(x1 / TILE_SIZE) - (int)(x2 / TILE_SIZE);
    dy = (int)(y1 / TILE_SIZE) - (int)(y2 / TILE_SIZE);
    int dx2 = (int)(x1 / TILE_SIZE);
    int dy2 = (int)(y1 / TILE_SIZE);
    
    if (dx == 1 && dy == 1)
        return (ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL) && (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL);
    if (dx == 1 && dy == -1)
        return (ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL) && (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL);
    if (dx == -1 && dy == 1)
        return (ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL) && (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL);
    if (dx == -1 && dy == -1)
        return (ft_strchr("0NSEW", god->map.map[dy2 - dy][dx2]) == NULL) && (ft_strchr("0NSEW", god->map.map[dy2][dx2 - dx]) == NULL);
    return FALSE;
}
/*
int is_wall_tool(t_god *god, double x1, double y1, double x2, double y2, double angle)
{
    if (!check_edge(god, x1, x2, y1, y2))
       return is_wall(god, x2, y2);
    else
        return is_wall_ray(god, x2, y2, angle); 
}*/
int is_wall(t_god *god, double x, double y)
{
	int xX;
	int yY;

	if (x < 0 || x > god->map.window_width || y < 0 || y > god->map.window_height) {
            return (TRUE);
    }
    xX = (int)floor(x / TILE_SIZE);
    yY = (int)floor(y / TILE_SIZE);

    return (ft_strchr("0NSEW", god->map.map[yY][xX]) == NULL);
}
/*
int is_wall_ray(t_god *god, double x, double y, double angle)
{
	int xX;
	int yY;
	if (x < 0 || x > god->map.window_width || y < 0 || y > god->map.window_height) {
            return (TRUE);
    }
    xX = (int)(x / TILE_SIZE);
    yY = (int)(y / TILE_SIZE);
    if (ft_strchr(" 0NSEW", god->map.map[yY][xX]) == NULL)
        return (TRUE);


    return (ft_strchr(" 0NSEW", god->map.map[yY - 1][xX]) == NULL && ft_strchr("0NSEW", god->map.map[yY][xX - 1]) == NULL);

    if (angle < HALF_PI && angle >= 0)
    {
        if (ft_strchr(" 0NSEW", god->map.map[yY - 1][xX]) == NULL && ft_strchr("0NSEW", god->map.map[yY][xX - 1]) == NULL)
            return (TRUE);
    }
    else if (angle < 2 * HALF_PI && angle >= HALF_PI)
    {
        if (ft_strchr(" 0NSEW", god->map.map[yY - 1][xX]) == NULL && ft_strchr("0NSEW", god->map.map[yY][xX + 1]) == NULL)
            return (TRUE);
    }
    else if (angle < 3 * HALF_PI && angle >= 2 * HALF_PI)
    {
        if (ft_strchr(" 0NSEW", god->map.map[yY + 1][xX]) == NULL && ft_strchr("0NSEW", god->map.map[yY][xX + 1]) == NULL)
            return (TRUE);
    }
    else if (angle < 4 * HALF_PI && angle >= 3 * HALF_PI)
    {
        if (ft_strchr(" 0NSEW", god->map.map[yY + 1][xX]) == NULL && ft_strchr("0NSEW", god->map.map[yY][xX - 1]) == NULL)
            return (TRUE);
    }
    return (FALSE);
}*/
