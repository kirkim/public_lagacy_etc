#include "cub3d.h"

void update_3Dvalue(t_god *god)
{
    god->player.updown_sight += UPDOWNSPEED * (god->key.updown_sight);
    if (god->key.mouse_on == TRUE)
        god->player.updown_sight += 2 * (god->mouse.y - god->map.window_height / 2);
    if (god->player.updown_sight > god->map.window_height / 2)
        god->player.updown_sight = god->map.window_height / 2;
    if (god->player.updown_sight < - god->map.window_height / 2)
        god->player.updown_sight = - god->map.window_height / 2;
}
int update_player(t_god *god)
{
    double turnDirection = 0.0;
    double walkDirection = 0.0;
    double newPlayerX;
    double newPlayerY;
    double moveside = 0.0;
    int moveStep;

    if (god->key.left_rotation == TRUE)
        turnDirection = -1.0;
    if (god->key.right_rotation == TRUE)
        turnDirection = 1.0;
    if (god->key.up == TRUE && god->key.down == FALSE)
        walkDirection = 1.0;
    if (god->key.down == TRUE && god->key.up == FALSE)
        walkDirection = -1.0;
    if (god->key.left == TRUE && god->key.right == FALSE)
    {
        walkDirection = 1.0;
        moveside = PI / 2.0;
        if (god->key.up == TRUE && god->key.down == FALSE)
            moveside = HALF_PI / 2;
        if (god->key.down == TRUE && god->key.up == FALSE)
        {
            walkDirection = -1.0;
            moveside = -HALF_PI / 2;
        }
    }
    if (god->key.right == TRUE && god->key.left == FALSE)
    {
        walkDirection = -1.0;
        moveside = HALF_PI;
        if (god->key.up == TRUE && god->key.down == FALSE)
        {
            walkDirection = 1.0;
            moveside = -HALF_PI / 2;
        }
        if (god->key.down == TRUE && god->key.up == FALSE)
            moveside = HALF_PI / 2;
    }

    god->player.rotationAngle += turnDirection * god->player.turnSpeed;
    if (god->key.mouse_on == TRUE)
        god->player.rotationAngle += (double)((god->mouse.x - god->map.window_width / 2) / (100 * PI));
    moveStep = walkDirection * god->player.walkSpeed;
    newPlayerX = god->player.x + moveStep * cos(god->player.rotationAngle - moveside);
    newPlayerY = god->player.y + moveStep * sin(god->player.rotationAngle - moveside);
    if (is_door(god, newPlayerX, newPlayerY) != CLOSE_DOOR
        && !is_wall(god, newPlayerX, newPlayerY)
        && !is_sprite(god, newPlayerX, newPlayerY)
        && !check_edge(god, god->player.x, newPlayerX, god->player.y, newPlayerY))
    {
        god->player.x = newPlayerX;
        god->player.y = newPlayerY;
    }

    return (0);
}
void    update_door(t_god *god)
{
    int x;
    int y;

    x = (int)god->player.x / TILE_SIZE;
    y = (int)god->player.y / TILE_SIZE;
    if (god->key.open_door == TRUE)
    {
        if (god->map.map[y - 1][x] == '3')
            god->map.map[y - 1][x] = '4';
        else if (god->map.map[y + 1][x] == '3')
            god->map.map[y + 1][x] = '4';
    }
    else if (god->key.open_door == FALSE)
    {
        if (god->map.map[y - 1][x] == '4')
            god->map.map[y - 1][x] = '3';
        else if (god->map.map[y + 1][x] == '4')
            god->map.map[y + 1][x] = '3';
    }
}


