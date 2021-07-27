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

# define PI         (3.14159265358979323846264338327950288)
# define TWO_PI     (6.28318530717958647692528676655900576)
# define HALF_PI    (1.57079632679489661923132169163975144)
# define FOV_ANGLE  (60 * (PI / 180.0))

/* Kinds of MAP_LOCATION */
# define LEFTUP_MAP (1)
# define LEFTDOWN_MAP (2)
# define RIGHTUP_MAP (3)
# define RIGHTDOWN_MAP (4)

/* user settings */
# define ANIMATE_DELAY (3)
# define MAP_LOCATION (LEFTDOWN_MAP)
# define MINIMAP_SCALE (0.25)
# define TILE_SIZE (64)
# define PLAYER_THICKNESS (6)
# define WALKSPEED (2.0)
# define TURNSPEED (1.5 * (PI / 180.0))
# define UPDOWNSPEED (20)
# define RAY_RANGE (PI / 3.0)
# define WALL_STRIP_WIDTH (1)

# define X_EVENT_KEY_PRESS      (2)
# define X_EVENT_KEY_release    (3)
# define X_EVENT_KEY_EXIT       (17)

# define OPEN_DOOR (2)
# define CLOSE_DOOR (1)
# define TRUE (1)
# define FALSE (0)
# define SUCCESS (0)
# define ERROR (1)
# define NO_COLOR (0xFF00FF)

# define KEY_ESC    (53)
# define KEY_W      (13)
# define KEY_A      (0)
# define KEY_S      (1)
# define KEY_D      (2)
# define KEY_LEFT	(123)
# define KEY_RIGHT	(124)
# define KEY_UP 	(126)
# define KEY_DOWN	(125)
# define KEY_1		(18)
# define KEY_2		(19)
# define KEY_3		(20)
# define KEY_4		(21)
# define KEY_M      (46)
# define KEY_P      (35)
# define KEY_SPACEBAR	(49)

/* texture */
# define T_ERROR (-1)
# define T_NO (0)
# define T_SO (1)
# define T_WE (2)
# define T_EA (3)
# define TI_NO (4)
# define TI_SO (5)
# define TI_WE (6)
# define TI_EA (7)
# define T_DO  (8)
# define T_DC  (9)
# define T_S  (10)
# define T_ST (11)
# define T_SU (12)
# define T_SV (13)
# define T_SF  (14)
# define T_FLOOR (15)
# define T_CEIL (16)
# define T_MAP (17)
# define TEXTURE_COUNT (15)  // put the number of xpm files going to use!
# define SPRITE_COUNT (3)

typedef struct s_point
{
	double x;
	double y;
}			t_point;

typedef struct s_dpable_update
{
	double turn_direction;
	double walk_direction;
	double new_x;
	double new_y;
	double moveside;
	int move_step;
}				t_dpable_update;

typedef struct s_dpable_parse
{
	int		fd;
	char	*line;
	int		gnl_ret;
	int		parse_type;
}				t_dpable_parse;

typedef struct s_door
{
    int cnt;
    int is_true;
    int in_room;
}               t_door;

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
    int         width;
}               t_3d;

typedef struct s_sprite
{
    double x;
    double y;
    int start;
    int exist;
    int symbol;
    double distance;
    double angle;
    double left_x;
    double right_x;
    t_3d    v;
}               t_sprite;

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
    double rota_angle;
    double walk_speed;
    double turn_speed;
    double updown_sight;
} t_player;

typedef struct s_ray {
    double  ray_angle;
    int     wall_paper;
    int     facing_down;
    int     facing_up;
    int     facing_right;
    int     facing_left;
} t_ray;

typedef struct s_rray {
    double  wall_hit_x;
    double  wall_hit_y;
    double  distance;
    double  angle;
    int     hit_vertical;
    int     is_door;
}               t_rray;

typedef struct s_dpable_ray {
    double  xintercept;
    double  yintercept;
    double  xstep;
    double  ystep;
    int     found_wall_hit;
    double  wall_hit_x;
    double  wall_hit_y;
    double  distance;
    int     is_door;
} t_dpable_ray;

typedef struct s_cal_ray {
    double ray_x;
    double ray_y;
    double max_value;
    int x;
    int y;
}               t_cal_ray;

typedef struct s_key {
    int up;
    int down;
    int right;
    int left;
    int right_rotation;
    int left_rotation;
    int updown_sight;
    int open_door;
    int mouse_on;
} t_key;

typedef struct    s_mouse
{
    int x;
    int y;
	unsigned int	delay_x;
	unsigned int	delay_y;
}   t_mouse;

typedef struct s_god {
    t_player player;
    t_img    img;
    t_key    key;
    t_ray    ray;
    t_parse  parse;
    t_map    map;
    t_sprite sprite[SPRITE_COUNT];
    t_rray   *rray;
    t_door   door;
    void     *mlx;
    void     *win;
    unsigned int     time;
    t_mouse    mouse;
} t_god;

/* render */
void    render_master(t_god *god);
void	render_map(t_god *god);
void    render_3d(t_god *god);
void    render_ray(t_god *god);
void    render_player(t_god *god);

/* update */
void    update_ray(t_god *god);
void    update_door(t_god *god);
void     update_player(t_god *god);
void    update_3Dvalue(t_god *god);

/* is valid */
int     is_wall(t_god *god, double x, double y);
int     is_door(t_god *god, double x, double y);
int     is_sprite(t_god *god, double x, double y);
int     is_upper(char c);
int     is_space(char c);
void    is_in_door(t_god *god);
void    is_in_room(t_god *god);
int     is_map_valid(char *line);
int		is_space_around_position(t_god *god, int row, int col);
int     is_cub_file(const char *cub_file_path);

/* key */
int     key_press(int keycode, t_key *key);
int     key_release(int keycode, t_key *key);
int     key_exit(t_god *god);

/* init */
void    init_3D(t_god *god, t_3d *v, int i);
void    set_wall_diretion(t_god *god, int i);
void    init_sprite(t_god *god, t_3d *v, t_sprite *sprite);
void    init_map_malloc(t_god *god);

/* ray */
void    draw_line(t_god *god, double dx, double dy);
void    ray_init(t_ray *ray, double rayAngle);
void    setting_map_location(t_parse *parse, int *x, int *y, int x2, int y2);
void    render_3D_project_walls(t_god *god, int i);

/* parse */
int     parse_file(t_god *god, const char *cub_file_path);
int     check_parsing_value(t_god *god);
int     find_char(const char *value, char c);
int     set_angle(t_god *god, int row, int col);
char    *update_map_malloc(char *s1, char *s2);
int     check_parse_type(char *line);
char    *parse_path_malloc(char *line);
int     parse_color(int *cf, char *line);
int     parse_map(t_parse *parse);

/* etc */
int     exit_error(t_god *god, int exit_code, const char *message);
void    free_memory(void *memory);
void    free_array_memory(void **memory, int index);
int     free_memory_return(void *memory, int return_code);
void    free_texture_array(t_god *god);
int     set_door(t_god *god, int row, int col);
void	update_mouse(t_god *god);

/* utils */
double  normalize_angle(double angle);
int	check_edge(t_god *god, const t_point *p1, const t_point *p2);
double  distance_between_points(double x1, double y1, double x2, double y2);
void    cal_distance(t_god *god, t_dpable_ray *hv);
double  cal_sprite_degree(t_god *god, t_sprite sprite);
int		ternaries_func(int problem, int true, int false);
double	ternaries_func2(double problem, double true, double false);
void    make_even_value(int *num1, int *num2);
void set_point(t_point *p, double x, double y);

/* texture */
void	load_texture(t_god *god);

/* sprite */
void    render_sprite(t_god *god);
void	change_value(t_sprite *s1, t_sprite *s2);
#endif
