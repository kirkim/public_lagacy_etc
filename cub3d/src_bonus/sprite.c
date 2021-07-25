#include "cub3d.h"

int     set_sprite_color(t_god *god, t_sprite *sprite, int i, int k)
{
    int row;
    int x;
    t_3d v;
    int symbol;

    symbol = sprite->symbol;
    v = sprite->v;
    x = ((k * god->parse.tex[symbol].width)) / v.width;
    row = (((v.correct_top - v.top + i) * god->parse.tex[symbol].height) / v.projected_height);
    return god->parse.tex[symbol].texture[(int)god->parse.tex[symbol].width * row + x];
}

void change_value(t_sprite *s1, t_sprite *s2)
{
    t_sprite temp;

    temp.x = s1->x;
    temp.y = s1->y;
    temp.distance = s1->distance;
    temp.symbol = s1->symbol;
    s1->x = s2->x;
    s1->y = s2->y;
    s1->distance = s2->distance;
    s1->symbol = s2->symbol;
    s2->x = temp.x;
    s2->y = temp.y;
    s2->distance = temp.distance;
    s2->symbol = temp.symbol;
}

void sort_sprite(t_sprite *sprite)
{
    int i;
    int j;

    i = 0;
    while (i < SPRITE_COUNT - 1)
    {
        j = i + 1;
        while (j < SPRITE_COUNT)
        {
            if (sprite[j].distance < sprite[i].distance)
                change_value(&sprite[i], &sprite[j]);
            j++;
        }
        i++;
    }
}
void set_sprite(t_god *god)
{
    int i;

    i = -1;
    god->time++;
    while (god->sprite[++i].exist == TRUE && i < SPRITE_COUNT)
    {
        god->sprite[i].distance = distance_between_points(god->player.x, god->player.y, god->sprite[i].x, god->sprite[i].y);
        if (god->time % ANIMATE_DELAY == 0)
        {
            if (god->sprite[i].symbol == T_S)
                god->sprite[i].symbol = T_ST;
            else if (god->sprite[i].symbol == T_ST)
                god->sprite[i].symbol = T_SU;
            else if (god->sprite[i].symbol == T_SU)
                god->sprite[i].symbol = T_SV;
            else if (god->sprite[i].symbol == T_SV)
                god->sprite[i].symbol = T_S;
        }
    }
    
}
void render_sprite(t_god *god)
{
    int     i;

    set_sprite(god);
    sort_sprite(god->sprite);
    for (int j = 0; god->sprite[j].exist == TRUE && j < SPRITE_COUNT ; j++)
    {
        init_sprite(god, &god->sprite[j].v, &god->sprite[j]);
        if (god->sprite[j].angle < FOV_ANGLE / 2 + 1)
        {
            i = 0;
            for (int y = god->sprite[j].v.correct_top; y < god->sprite[j].v.correct_bottom; y++)
            {
                for (int x = god->sprite[j].left_x; x < god->sprite[j].right_x; x++)
                    if (x > 0 && x < god->map.window_width && y > 0 && y < god->map.window_height)
                        if (god->img.data[god->map.window_width * y + x] == NO_COLOR && god->sprite[j].distance < god->rray[x].distance)
                            god->img.data[god->map.window_width * y + x] = set_sprite_color(god, &god->sprite[j], i, x - god->sprite[j].left_x);
                i++;
            }
        }
    }
}