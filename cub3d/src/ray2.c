#include "cub3d.h"

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

void    cal_ray(t_god *god, t_dpable_ray *hv, int a, int b)
{
    double next_touchX;
    double next_touchY;

    next_touchX = hv->xintercept;
    next_touchY = hv->yintercept;

    while (next_touchX >= 0 && next_touchX <= god->map.window_width && next_touchY >= 0 && next_touchY <= god->map.window_height) {
        if (is_wall(god, next_touchX + a, next_touchY + b)) 
        {
            hv->found_wallHit = TRUE;
            hv->wall_hitX = next_touchX;
            hv->wall_hitY = next_touchY;
            break;
        } else {
            next_touchX += hv->xstep;
            next_touchY += hv->ystep;
        }
    }
    cal_distance(god, hv);
}

void    cal_horz_ray(t_god *god, t_dpable_ray *horz)
{
    horz->found_wallHit = FALSE;
    horz->wall_hitX = 0;
    horz->wall_hitY = 0;

    horz->yintercept = floor(god->player.y  / TILE_SIZE) * TILE_SIZE;
    
    horz->yintercept += god->ray.isRay_facingDown ? TILE_SIZE : 0;

    horz->xintercept = god->player.x + (horz->yintercept - god->player.y) / tan(god->ray.ray_angle);

    horz->ystep = TILE_SIZE;
    horz->ystep *= god->ray.isRay_facingUp ? -1 : 1;

    horz->xstep = TILE_SIZE / tan(god->ray.ray_angle);
    horz->xstep *= (god->ray.isRay_facingLeft && horz->xstep > 0) ? -1 : 1;
    horz->xstep *= (god->ray.isRay_facingRight && horz->xstep < 0) ? -1 : 1;

    cal_ray(god, horz, 0, (god->ray.isRay_facingUp ? -1 : 0));
}

void cal_vert_ray(t_god *god, t_dpable_ray *vert)
{
    vert->found_wallHit = FALSE;
    vert->wall_hitX = 0;
    vert->wall_hitY = 0;

    vert->xintercept = floor(god->player.x  / TILE_SIZE) * TILE_SIZE;
    vert->xintercept += god->ray.isRay_facingRight ? TILE_SIZE : 0;

    vert->yintercept = god->player.y + (vert->xintercept - god->player.x) * tan(god->ray.ray_angle);

    vert->xstep = TILE_SIZE;
    vert->xstep *= god->ray.isRay_facingLeft ? -1 : 1;

    vert->ystep = TILE_SIZE * tan(god->ray.ray_angle);
    vert->ystep *= (god->ray.isRay_facingUp && vert->ystep > 0) ? -1 : 1;
    vert->ystep *= (god->ray.isRay_facingDown && vert->ystep < 0) ? -1 : 1;

    cal_ray(god, vert, (god->ray.isRay_facingLeft ? -1 : 0), 0);
}

void    draw_one_ray(t_god *god, double angle, int i)
{
    t_dpable_ray horz;
    t_dpable_ray vert;

    ray_init(&god->ray, angle);
    cal_horz_ray(god, &horz);
    cal_vert_ray(god, &vert);

    if (vert.distance < horz.distance) {
        god->ray.wall_hit_x = vert.wall_hitX;
        god->ray.wall_hit_y = vert.wall_hitY;
        god->ray.distance = vert.distance;
        god->ray.hit_vertical = TRUE;
    } else {
        god->ray.wall_hit_x = horz.wall_hitX;
        god->ray.wall_hit_y = horz.wall_hitY;
        god->ray.distance = horz.distance;
        god->ray.hit_vertical = FALSE;
    }
    //printf("%f\n", normalize_angle(god->player.rotationAngle));
    draw_line(god, god->ray.wall_hit_x - god->player.x, god->ray.wall_hit_y - god->player.y);
    render_3D_project_walls(god, i);
}
