#include "cub3d.h"

void player_init(t_player *player)
{
    //player->x = WINDOW_WIDTH / 2.0;
    //player->y = WINDOW_HEIGHT / 2.0;
    player->thickness = PLAYER_THICKNESS;
    //player->rotationAngle = HALF_PI;
    player->walkSpeed = WALKSPEED;
    player->turnSpeed = TURNSPEED;
}

int        key_press(int keycode, t_key *key)
{
    if (keycode == KEY_A)
        key->left = TRUE;
    if (keycode == KEY_D)
        key->right = TRUE;
    if (keycode == KEY_W)
        key->up = TRUE;
    if (keycode == KEY_S)
        key->down = TRUE;
    if (keycode == KEY_RIGHT)
        key->right_rotation = TRUE;
    if (keycode == KEY_LEFT)
        key->left_rotation = TRUE;
    if (keycode == KEY_UP)
        key->updown_sight = -1;
    if (keycode == KEY_DOWN)
        key->updown_sight = 1; 
    if (keycode == KEY_ESC)
        exit(0);
    
    return (0);
}

int        key_release(int keycode, t_key *key)
{
    if (keycode == KEY_A)
        key->left = FALSE;
    if (keycode == KEY_D)
        key->right = FALSE;
    if (keycode == KEY_W)
        key->up = FALSE;
    if (keycode == KEY_S)
        key->down = FALSE;
    if (keycode == KEY_RIGHT)
        key->right_rotation = FALSE;
    if (keycode == KEY_LEFT)
        key->left_rotation = FALSE;
    if (keycode == KEY_UP)
        key->updown_sight = 0;
    if (keycode == KEY_DOWN)
        key->updown_sight = 0;
    if (keycode == KEY_ESC)
        exit(0);
    
    return (0);
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
    if (god->key.left == TRUE)
    {
        walkDirection = 1.0;
        moveside = PI / 2.0;
    }
    if (god->key.right == TRUE)
    {
        walkDirection = -1.0;
        moveside = HALF_PI;
    }
    if (god->key.up == TRUE)
        walkDirection = 1.0;
    if (god->key.down == TRUE)
        walkDirection = -1.0;

    god->player.rotationAngle += turnDirection * god->player.turnSpeed;
    moveStep = walkDirection * god->player.walkSpeed;
    newPlayerX = god->player.x + moveStep * cos(god->player.rotationAngle - moveside);
    newPlayerY = god->player.y + moveStep * sin(god->player.rotationAngle - moveside);
    //printf("%d\n", check_edge(god, god->player.x, newPlayerX, god->player.y, newPlayerY));
    if (!is_wall(god, newPlayerX, newPlayerY) && !check_edge(god, god->player.x, newPlayerX, god->player.y, newPlayerY))
    {
        god->player.x = newPlayerX;
        god->player.y = newPlayerY;
    }
    return (0);
}

int    setting_value(t_god *god, t_player *player, t_img *img)
{
    int x;
    int y;

    setting_map_location(&god->parse, &x, &y, player->x, player->y);
    update_player(god);
    for (int row = -(player->thickness) / 2; row <= (player->thickness) / 2; row++)
    {
        for (int col = -(player->thickness) / 2; col <= (player->thickness) / 2; col++)
        {
            img->data[god->map.window_width * (y + row) + (x + col)] = 0x0000FF;
        }
    }
    draw_ray(god);
    //printf("%f %f\n",god->player.x, god->player.y);
    mlx_put_image_to_window(god->mlx, god->win, img->ptr, 0, 0);
    return (0);
}

int     ft_loop(t_god *god)
{
    render_map(god);
    setting_value(god, &(god->player), &(god->img));
    return (0);
}
int key_exit(t_god *god) {
    exit(0);
    // ToDo: 메모리 해제 코드
    return (0);
}
void render_player(t_god *god)
{
    player_init(&(god->player));
	mlx_hook(god->win, X_EVENT_KEY_PRESS, (1L << 0), &key_press, &(god->key));
    mlx_hook(god->win, X_EVENT_KEY_release, (1L << 1), &key_release, &(god->key));
    mlx_hook(god->win, X_EVENT_KEY_EXIT, 0, &key_exit, god);
    mlx_loop_hook(god->mlx, ft_loop, god);
}