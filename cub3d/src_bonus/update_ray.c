#include "cub3d.h"

void    cal_ray(t_god *god, t_dpable_ray *hv, int a, int b)
{
    double next_touchX;
    double next_touchY;
    int door;

    next_touchX = hv->xintercept;
    next_touchY = hv->yintercept;
    while (next_touchX >= 0 && next_touchX <= god->map.window_width && next_touchY >= 0 && next_touchY <= god->map.window_height)
    {
        door = is_door(god, next_touchX + a, next_touchY + b);
        if (is_wall(god, next_touchX + a, next_touchY + b) || door != FALSE) 
        {
            hv->is_door = door;
            hv->found_wallHit = TRUE;
            hv->wall_hitX = next_touchX;
            hv->wall_hitY = next_touchY;
            break;
        }
        next_touchX += hv->xstep;
        next_touchY += hv->ystep;
    }
    cal_distance(god, hv);
}
int     set_cal_value(int problem, int true, int false)
{
    if (problem == TRUE)
        return (true);
    return (false);
}
void    cal_horz_ray(t_god *god, t_dpable_ray *horz)
{
    horz->found_wallHit = FALSE;
    horz->wall_hitX = 0;
    horz->wall_hitY = 0;

    horz->yintercept = floor(god->player.y  / TILE_SIZE) * TILE_SIZE;
    horz->yintercept += set_cal_value(god->ray.isRay_facingDown, TILE_SIZE, 0);
    horz->xintercept = god->player.x + (horz->yintercept - god->player.y) / tan(god->ray.ray_angle);
    horz->ystep = TILE_SIZE;
    horz->ystep *= set_cal_value(god->ray.isRay_facingUp, -1, 1);
    horz->xstep = TILE_SIZE / tan(god->ray.ray_angle);
    horz->xstep *= set_cal_value(god->ray.isRay_facingLeft && horz->xstep > 0, -1, 1);
    horz->xstep *= set_cal_value(god->ray.isRay_facingRight && horz->xstep < 0, -1, 1);
    cal_ray(god, horz, 0, set_cal_value(god->ray.isRay_facingUp, -1, 0));
}

void cal_vert_ray(t_god *god, t_dpable_ray *vert)
{
    vert->found_wallHit = FALSE;
    vert->wall_hitX = 0;
    vert->wall_hitY = 0;

    vert->xintercept = floor(god->player.x  / TILE_SIZE) * TILE_SIZE;
    vert->xintercept += set_cal_value(god->ray.isRay_facingRight, TILE_SIZE, 0);
    vert->yintercept = god->player.y + (vert->xintercept - god->player.x) * tan(god->ray.ray_angle);
    vert->xstep = TILE_SIZE;
    vert->xstep *= set_cal_value(god->ray.isRay_facingLeft, -1, 1);
    vert->ystep = TILE_SIZE * tan(god->ray.ray_angle);
    vert->ystep *= set_cal_value(god->ray.isRay_facingUp && vert->ystep > 0, -1, 1);
    vert->ystep *= set_cal_value(god->ray.isRay_facingDown && vert->ystep < 0, -1, 1);
    cal_ray(god, vert, set_cal_value(god->ray.isRay_facingLeft, -1, 0), 0);
}
/*
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
}*/

void    update_one_ray(t_god *god, double angle, int i)
{
    t_dpable_ray horz;
    t_dpable_ray vert;

    ray_init(&god->ray, angle);
    cal_horz_ray(god, &horz);
    cal_vert_ray(god, &vert);

    if (vert.distance < horz.distance) {
        god->rray[i].is_door = vert.is_door;
        god->rray[i].wall_hit_x = vert.wall_hitX;
        god->rray[i].wall_hit_y = vert.wall_hitY;
        god->rray[i].distance = vert.distance;
        god->rray[i].hit_vertical = TRUE;
    } else {
        god->rray[i].is_door = horz.is_door;
        god->rray[i].wall_hit_x = horz.wall_hitX;
        god->rray[i].wall_hit_y = horz.wall_hitY;
        god->rray[i].distance = horz.distance;
        god->rray[i].hit_vertical = FALSE;
    }
    vert.is_door = FALSE;
    horz.is_door = FALSE;
    god->rray[i].angle = god->ray.ray_angle;
}

void    update_ray(t_god *god)
{
    double angle;
    double maxAngle;
    int i;

    i = 0;
    angle = god->player.rotationAngle - (RAY_RANGE / 2.0);
    maxAngle = god->player.rotationAngle + (RAY_RANGE / 2.0);

    while (i < god->map.ray_count)
    {
        update_one_ray(god, angle, i);
        angle += RAY_RANGE / god->map.ray_count;
        i++;
    }
}