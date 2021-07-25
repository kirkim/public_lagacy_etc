#include "cub3d.h"

void player_init(t_player *player)
{
    player->thickness = PLAYER_THICKNESS;
    player->walkSpeed = WALKSPEED;
    player->turnSpeed = TURNSPEED;
}

int    update_master(t_god *god, t_player *player, t_img *img)
{
    update_player(god);
    update_3Dvalue(god);
    update_door(god);
    update_ray(god);

    return (0);
}

int     ft_loop(t_god *god)
{
    
    update_master(god, &(god->player), &(god->img));
    render_map(god);
    is_in_door(god);
    is_in_room(god);
    render_ray(god);
    render_sprite(god);
    render_3d(god);
    render_player(god);
    mlx_put_image_to_window(god->mlx, god->win, god->img.ptr, 0, 0);
    return (0);
}

void render_master(t_god *god)
{
    player_init(&(god->player));
	mlx_hook(god->win, X_EVENT_KEY_PRESS, (1L << 0), &key_press, &(god->key));
    mlx_hook(god->win, X_EVENT_KEY_release, (1L << 1), &key_release, &(god->key));
    mlx_hook(god->win, X_EVENT_KEY_EXIT, 0, &key_exit, god);
    mlx_loop_hook(god->mlx, ft_loop, god);
}