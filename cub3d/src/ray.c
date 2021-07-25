#include "cub3d.h"

void ray_init(t_ray *ray, double rayAngle)
{
    ray->ray_angle = normalize_angle(rayAngle);
    ray->wall_hit_x = 0;
    ray->wall_hit_y = 0;
    ray->distance = 0;
    ray->hit_vertical = FALSE;

    ray->isRay_facingDown = ray->ray_angle > 0 && ray->ray_angle < PI;
    ray->isRay_facingUp = !ray->isRay_facingDown;
    ray->isRay_facingRight = ray->ray_angle < 0.5 * PI || ray->ray_angle > 1.5 * PI;
    ray->isRay_facingLeft = !ray->isRay_facingRight;
}

void    draw_line(t_god *god, double dx, double dy)
{
    double    ray_x;
    double    ray_y;
    int x;
    int y;
    double    max_value;
    
    ray_x = god->player.x;
    ray_y = god->player.y;
    
    max_value = fmax(fabs(dx), fabs(dy));
    if (max_value == 0)
        return ;
    dx /= max_value;
    dy /= max_value;
    while (1)
    {   
        if (!check_edge(god, ray_x, ray_x + dx, ray_y, ray_y + dy) && !is_wall(god, ray_x, ray_y))
        {
            ray_x += dx;
            ray_y += dy;
        }
        else
            break;
        setting_map_location(&god->parse, &x, &y, ray_x, ray_y);
        god->img.data[god->map.window_width * y + x] = 0xFF0000;
    }
}

void    draw_ray(t_god *god)
{
    double angle;
    double maxAngle;
    int i;

    i = 0;
    angle = god->player.rotationAngle - (RAY_RANGE / 2.0);
    maxAngle = god->player.rotationAngle + (RAY_RANGE / 2.0);

    while (i < god->map.ray_count)
    {
        draw_one_ray(god, angle, i);
        angle += RAY_RANGE / god->map.ray_count;
        i++;
    }
}