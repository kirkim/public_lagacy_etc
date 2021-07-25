#ifndef CUB3D_H
# define CUB3D_H

# include "../lib/mlx/mlx.h"
# include "fcntl.h"
# include <stdlib.h>
# include <math.h>
# include <stdio.h>
# include <float.h>
# include "../lib/libft/libft.h"
# include "../lib/gnl/get_next_line.h"

# define PI (3.14159265358979323846264338327950288)
# define TWO_PI (6.28318530717958647692528676655900576)
# define HALF_PI (1.57079632679489661923132169163975144)
# define FOV_ANGLE (60 * (PI / 180.0))

/* Kinds of MAP_LOCATION */
# define LEFTUP_MAP (1)
# define LEFTDOWN_MAP (2)
# define RIGHTUP_MAP (3)
# define RIGHTDOWN_MAP (4)

/* user settings */
# define MAP_LOCATION (LEFTDOWN_MAP)
# define MINIMAP_SCALE (0.25)
# define TILE_SIZE (64)
# define PLAYER_THICKNESS (6)
# define WALKSPEED (2.0)
# define TURNSPEED (1.5 * (PI / 180.0))
# define UPDOWNSPEED (0.01)
# define RAY_RANGE (PI / 3.0)
# define WALL_STRIP_WIDTH (1)
//# define RAY_COUNT (WINDOW_WIDTH / WALL_STRIP_WIDTH) // It must be bigger than 2 and recommend odd numbers.

# define X_EVENT_KEY_PRESS      (2)
# define X_EVENT_KEY_release    (3)
# define X_EVENT_KEY_EXIT       (17)

# define TRUE (1)
# define FALSE (0)
# define SUCCESS (0)
# define ERROR (1)
# define NO_COLOR (-1)

# define KEY_ESC    (53)
# define KEY_W      (13)
# define KEY_A      (0)
# define KEY_S      (1)
# define KEY_D      (2)
# define KEY_LEFT	(123)
# define KEY_RIGHT	(124)
# define KEY_UP 	(126)
# define KEY_DOWN	(125)
# define KEY_SPACEBAR	(49)

/* texture */
# define T_ERROR (-1)
# define T_NO (0)
# define T_SO (1)
# define T_WE (2)
# define T_EA (3)
# define T_FLOOR (4)
# define T_CEIL (5)
# define T_MAP (6)
# define TEXTURE_COUNT (4)  // put the number of xpm files going to use!

typedef struct s_map
{
    int map_rows;
    int map_cols;
    int window_width;
    int window_height;
    int ray_count;
    char **map;
}               t_map;

typedef struct  s_3d
{
    double      correct_distance;
    double      distance_plane;
    int         projected_height;
    int         top;
    int         correct_top;
    int         bottom;
    int         correct_bottom;
    int         height;
}               t_3d;

typedef struct  s_texture
{
    char		*tex_path;
	int			*texture;
	double		width;
	double		height;
}               t_texture;

typedef struct  s_parse
{
    t_texture   tex[TEXTURE_COUNT];
    int         floor_color;
    int         ceiling_color;
    char        *temp_map;
    char        **map;
    int         row;
    int         col;
}               t_parse;

typedef struct    s_img
{
    void		    *ptr;
    int             *data;
    int             bpp;
    int             line_size;
    int             endian;
    int             img_height;
    int             img_width;
}                t_img;

typedef struct s_player {
    double x;
    double y;
    int thickness;
    double rotationAngle;
    double walkSpeed;
    double turnSpeed;
    double updown_sight;
} t_player;

typedef struct s_ray {
    double  ray_angle;
    double  wall_hit_x;
    double  wall_hit_y;
    double  distance;
    int     hit_vertical;
    int     wall_direction;
    int     isRay_facingDown;
    int     isRay_facingUp;
    int     isRay_facingRight;
    int     isRay_facingLeft;
} t_ray;

typedef struct s_dpable_ray {
    double  xintercept;
    double  yintercept;
    double  xstep;
    double  ystep;
    int     found_wallHit;
    double  wall_hitX;
    double  wall_hitY;
    double  distance;
} t_dpable_ray;

typedef struct s_key {
    int up;
    int down;
    int right;
    int left;
    int right_rotation;
    int left_rotation;
    int updown_sight;
} t_key;

typedef struct s_god {
    t_player player;
    t_img    img;
    t_key    key;
    t_ray    ray;
    t_parse  parse;
    t_map    map;
    void     *mlx;
    void     *win;
} t_god;

void    render_player(t_god *god);
void	render_map(t_god *god);

/* ray */
void    draw_ray(t_god *god);
void    draw_line(t_god *god, double dx, double dy);
void    ray_init(t_ray *ray, double rayAngle);
double distance_between_points(double x1, double y1, double x2, double y2);
void    setting_map_location(t_parse *parse, int *x, int *y, int x2, int y2);
void    draw_one_ray(t_god *god, double angle, int i);
void render_3D_project_walls(t_god *god, int i);
void render3DProjectedWalls(t_god *god, int i);

/* parse */
int parse_file(t_god *god, const char *cub_file_path);
int check_parsing_value(t_god *god);

/* etc */
int    exit_error(t_god *god, int exit_code, const char *message);
void    free_memory(void *memory);
void    free_array_memory(void **memory, int index);
int     free_memory_return(void *memory, int return_code);
void    free_texture_array(t_god *god);

/* utils */
int is_upper(char c);
int is_space(char c);
double normalize_angle(double angle);
int is_wall(t_god *god, double x, double y);
int check_edge(t_god *god, double x1, double x2, double y1, double y2);

/* texture */
void		load_texture(t_god *god);
#endif