#include "cub3d.h"

void    render_player(t_god *god)
{
    int x;
    int y;

    setting_map_location(&god->parse, &x, &y, god->player.x, god->player.y);
    for (int row = -(god->player.thickness) / 2; row <= (god->player.thickness) / 2; row++)
    {
        for (int col = -(god->player.thickness) / 2; col <= (god->player.thickness) / 2; col++)
        {
            god->img.data[god->map.window_width * (y + row) + (x + col)] = 0x0000FF;
        }
    }
}
