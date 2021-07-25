#include "cub3d.h"

int draw_sky(t_god *god, int ray_num, int wall_top_pixel, int color)
{
    if (god->door.in_room)
        color = 0x843600;
    for (int y = 0; y < wall_top_pixel; y++)
        for (int x = 0; x < WALL_STRIP_WIDTH; x++)
            if (god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] == NO_COLOR)
                god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] = color;
    return (0);
}
int draw_bottom(t_god *god, int ray_num, int wall_bottom_pixel, int color)
{
    if (god->door.in_room)
        color = 0x46464f;
    for (int y = wall_bottom_pixel; y < god->map.window_height; y++)
        for (int x = 0; x < WALL_STRIP_WIDTH; x++)
            if (god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] == NO_COLOR)
                god->img.data[god->map.window_width * y + (x + ray_num * WALL_STRIP_WIDTH)] = color;
    return (0);
}

int     set_wall_color(t_god *god, t_3d *v, int r, int i)
{
    int col;
    int direction;
    int row;
    
    set_wall_diretion(god, i);
    direction = god->ray.wall_direction;
    if (direction == T_WE || direction == T_EA || direction == TI_WE || direction == TI_EA)
        col = ((int)god->rray[i].wall_hit_y % TILE_SIZE) * (god->parse.tex[direction].width / TILE_SIZE);
    else
        col = (int)god->rray[i].wall_hit_x % TILE_SIZE * (god->parse.tex[direction].width / TILE_SIZE);
    row = (((v->correct_top - v->top + r) * god->parse.tex[direction].height) / v->height);

    return god->parse.tex[direction].texture[(int)god->parse.tex[direction].width * row + col];
}

void render_3D_project_walls(t_god *god, int i)
{
    t_3d    v;
    int     r;

    init_3D(god, &v, i);
    
    r = 0;
    for (int y = v.correct_top; y < v.correct_bottom; y++)
    {
        for (int x = 0; x < WALL_STRIP_WIDTH; x++)
            if (god->img.data[god->map.window_width * y + (x + i * WALL_STRIP_WIDTH)] == NO_COLOR)
                god->img.data[god->map.window_width * y + (x + i * WALL_STRIP_WIDTH)] = set_wall_color(god, &v, r, i);
        r++;
    }
    draw_sky(god, i, v.correct_top, god->parse.ceiling_color);
    draw_bottom(god, i, v.correct_bottom, god->parse.floor_color);
}

void    render_3d(t_god *god)
{
    int i;

    i = 0;
    while (i < god->map.ray_count)
    {
        render_3D_project_walls(god, i);
        i++;
    }
}