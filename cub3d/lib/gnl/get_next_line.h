/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/27 14:03:52 by kirkim            #+#    #+#             */
/*   Updated: 2021/01/27 14:58:09 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_H
# define GET_NEXT_LINE_H

# ifdef _WIN32
#  include <io.h>
# else
#  include <unistd.h>
# endif

# include <stdlib.h>
# include <limits.h>

# ifndef OPEN_MAX
#  define OPEN_MAX 10240
# endif

# ifndef BUFFER_SIZE
#  define BUFFER_SIZE 4
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
