#include "cub3d.h"

void ray_init(t_ray *ray, double rayAngle)
{
    ray->ray_angle = normalize_angle(rayAngle);

    ray->isRay_facingDown = ray->ray_angle > 0 && ray->ray_angle < PI;
    ray->isRay_facingUp = !ray->isRay_facingDown;
    ray->isRay_facingRight = ray->ray_angle < 0.5 * PI || ray->ray_angle > 1.5 * PI;
    ray->isRay_facingLeft = !ray->isRay_facingRight;
}

void    init_t_cal_ray(t_god *god, t_cal_ray *c, double *dx, double *dy)
{
    c->ray_x = god->player.x;
    c->ray_y = god->player.y;

    c->max_value = fmax(fabs(*dx), fabs(*dy));
    if (c->max_value == 0)
        return ;
    *dx /= c->max_value;
    *dy /= c->max_value;
}

void    draw_line(t_god *god, double dx, double dy)
{
    t_cal_ray   c;

    init_t_cal_ray(god, &c, &dx, &dy);
    while (1)
    {      
        if (is_door(god, c.ray_x + dx, c.ray_y + dy) == 0
            && !check_edge(god, c.ray_x, c.ray_x + dx, c.ray_y, c.ray_y + dy)
            && !is_wall(god, c.ray_x + dx, c.ray_y + dy))
        {
            c.ray_x += dx;
            c.ray_y += dy;
        }
        else
            break;
        setting_map_location(&god->parse, &c.x, &c.y, c.ray_x, c.ray_y);
        god->img.data[god->map.window_width * c.y + c.x] = 0xFF0000;
    }
}

void    render_ray(t_god *god)
{
    int i;

    i = 0;
    while (i < god->map.ray_count)
    {
        draw_line(god, god->rray[i].wall_hit_x - god->player.x, god->rray[i].wall_hit_y - god->player.y);
        i++;
    }
}