#ifndef GET_NEXT_LINE_H
# define GET_NEXT_LINE_H

#  include <unistd.h>
# include <stdlib.h>
# include <limits.h>

# ifndef OPEN_MAX
#  define OPEN_MAX 10240
# endif

# ifndef BUFFER_SIZE
#  define BUFFER_SIZE 30
# endif

# define FT_EOF 0
# define FT_SUCCESS 1
# define FT_FAIL -1

int		get_next_line(int fd, char **line);
char	*ft_strjoin(char const *s1, char const *s2);
void	*ft_memcpy(void *dst, const void *src, size_t num);
size_t	ft_strlen(const char *str);
char	*ft_strndup(const char *str, ssize_t offst);

#endif
