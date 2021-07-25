#include "cub3d.h"

int draw_sky(t_god *god, int ray_num, int wall_top_pixel, int color)
{
    for (int y = 0; y < wall_top_pixel; y++)
        for (int x = 0; x < WALL_STRIP_WIDTH; x++)
            if (god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] == NO_COLOR)
                god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] = color;
    return (0);
}
int draw_bottom(t_god *god, int ray_num, int wall_bottom_pixel, int color)
{
    for (int y = wall_bottom_pixel; y < god->map.window_height; y++)
        for (int x = 0; x < WALL_STRIP_WIDTH; x++)
            if (god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] == NO_COLOR)
                god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] = color;
    return (0);
}
void update_3Dvalue(t_god *god)
{
    if (god->ray.distance == 0)
        god->ray.distance = 0.1;
    god->player.updown_sight += UPDOWNSPEED * god->key.updown_sight;
    if (god->player.updown_sight > god->map.window_height / 4)
        god->player.updown_sight = god->map.window_height / 4;
    if (god->player.updown_sight < - god->map.window_height / 4)
        god->player.updown_sight = - god->map.window_height / 4;
}
void    set_wall_diretion(t_god *god)
{
    if (god->ray.hit_vertical == TRUE && (god->player.x - god->ray.wall_hit_x) > 0)
        god->ray.wall_direction = T_WE;
    else if (god->ray.hit_vertical == TRUE && (god->player.x - god->ray.wall_hit_x) < 0)
        god->ray.wall_direction = T_EA;
    else if (god->ray.hit_vertical == FALSE && (god->player.y - god->ray.wall_hit_y) > 0)
        god->ray.wall_direction = T_NO;
    else
        god->ray.wall_direction = T_SO;
}

void    init_3D(t_god *god, t_3d *v)
{
    v->correct_distance = god->ray.distance * cos(god->ray.ray_angle - god->player.rotationAngle);
    v->distance_plane = (god->map.window_width / 2) / tan(FOV_ANGLE / 2);
    v->projected_height = (int)((TILE_SIZE / v->correct_distance) * v->distance_plane);
    
    v->top = (god->map.window_height / 2) - (v->projected_height / 2) - god->player.updown_sight;
    v->correct_top = v->top < 0 ? 1 : v->top;

    v->bottom = (god->map.window_height / 2) + (v->projected_height / 2) - god->player.updown_sight;
    v->correct_bottom = v->bottom > god->map.window_height ? god->map.window_height : v->bottom;
    
    v->height = v->bottom - v->top;
}

int     set_wall_color(t_god *god, t_3d *v, int i)
{
    int col;
    int direction;
    int row;

    set_wall_diretion(god);
    direction = god->ray.wall_direction;
    if (direction == T_WE || direction == T_EA)
        col = ((int)god->ray.wall_hit_y % TILE_SIZE) * (god->parse.tex[direction].width / TILE_SIZE);
    else
        col = (int)god->ray.wall_hit_x % TILE_SIZE * (god->parse.tex[direction].width / TILE_SIZE);
    row = (((v->correct_top - v->top + i) * god->parse.tex[direction].width) / v->height);

    return god->parse.tex[direction].texture[(int)god->parse.tex[direction].height * row + col];
}
void render_3D_project_walls(t_god *god, int ray_num)
{
    t_3d    v;
    int     i;

    update_3Dvalue(god);
    init_3D(god, &v);

    i = 0;
    for (int y = v.correct_top; y < v.correct_bottom; y++)
    {
        for (int x = 0; x < WALL_STRIP_WIDTH; x++)
            if (god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] == NO_COLOR)
                god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] = set_wall_color(god, &v, i);
        i++;
    }
    draw_sky(god, ray_num, v.correct_top, god->parse.ceiling_color);
    draw_bottom(god, ray_num, v.correct_bottom, god->parse.floor_color);
}