#include "cub3d.h"

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

double distance_between_points(double x1, double y1, double x2, double y2)
{
    return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}

void    cal_distance(t_god *god, t_dpable_ray *hv)
{
    if (hv->found_wallHit == TRUE)
        hv->distance = distance_between_points(god->player.x, god->player.y, hv->wall_hitX, hv->wall_hitY);
    else
        hv->distance = 111111;
}

double    cal_sprite_degree(t_god *god, t_sprite sprite)
{
    double angle;

    angle = normalize_angle(god->player.rotationAngle)
        - atan2(sprite.y - god->player.y, sprite.x - god->player.x);
    if (angle > PI)
            angle -= TWO_PI;
    else if (angle < -1 * PI)
            angle += TWO_PI;
    return (fabs(angle));
}