/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/27 13:34:56 by kirkim            #+#    #+#             */
/*   Updated: 2021/01/27 21:01:47 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

static void		str_free(char *str)
{
	free(str);
	str = NULL;
}

static ssize_t	find_newline(char *str)
{
	ssize_t cnt;

	cnt = 0;
	while (str != NULL && *str != '\0')
	{
		if (*str == '\n')
			return (cnt);
		str++;
		cnt++;
	}
	return (FT_FAIL);
}

static ssize_t	make_line(char **line, char **save, ssize_t index)
{
	char	*temp;
	char	*next_line;

	if (index >= 0)
	{
		*line = ft_strndup(*save, index);
		next_line = *save + index + 1;
		temp = ft_strndup(next_line, ft_strlen(next_line));
		str_free(*save);
		*save = temp;
		return (FT_SUCCESS);
	}
	if (*save == NULL)
		*line = ft_strndup("", 0);
	else
	{
		*line = *save;
		*save = NULL;
	}
	return (FT_EOF);
}

int				get_next_line(int fd, char **line)
{
	char		*buf;
	char		*temp;
	static char	*save[OPEN_MAX];
	ssize_t		offset;
	ssize_t		index;

	if (fd < 0 || fd > OPEN_MAX || line == NULL || BUFFER_SIZE <= 0)
		return (FT_FAIL);
	if ((buf = (char *)malloc(sizeof(char) * (BUFFER_SIZE + 1))) == NULL)
		return (FT_FAIL);
	while ((index = find_newline(save[fd])) == FT_FAIL && \
			(offset = read(fd, buf, BUFFER_SIZE)) > 0)
	{
		buf[offset] = '\0';
		if (save[fd] == NULL)
			temp = ft_strndup(buf, offset);
		else
			temp = ft_strjoin(save[fd], buf);
		str_free(save[fd]);
		save[fd] = temp;
	}
	str_free(buf);
	if (offset < 0)
		return (FT_FAIL);
	return (make_line(line, &save[fd], index));
}
