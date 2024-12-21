/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_split.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/28 15:20:01 by kirkim            #+#    #+#             */
/*   Updated: 2021/01/02 17:56:52 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

static size_t	ft_cntword(const char *str, char c)
{
	size_t	cnt;
	size_t	flag;
	size_t	i;

	if (!str)
		return (0);
	i = 0;
	cnt = 0;
	flag = 0;
	while (str[i])
	{
		if (str[i] != c && flag == 0)
		{
			flag = 1;
			cnt++;
		}
		else if (str[i] == c)
			flag = 0;
		i++;
	}
	return (cnt);
}

static size_t	ft_wordlen(char const *s, char c)
{
	size_t len;

	len = 0;
	while (s[len] && s[len] != c)
		len++;
	return (len);
}

static char		*ft_strndup(const char *s, size_t num)
{
	size_t	i;
	char	*word;

	i = 0;
	if (!(word = (char *)malloc(sizeof(char) * (num + 1))))
		return (0);
	while (i < num)
	{
		word[i] = s[i];
		i++;
	}
	word[i] = '\0';
	return (word);
}

static void		ft_free_str(char **s, int i)
{
	while (i--)
		free(s[i]);
	free(s);
}

char			**ft_split(char const *s, char c)
{
	size_t	nb;
	size_t	wordlen;
	size_t	cnt;
	char	**result;

	cnt = ft_cntword(s, c);
	if (!s || !(result = (char **)malloc(sizeof(char *) * (cnt + 1))))
		return (0);
	nb = 0;
	while (nb < cnt)
	{
		while (*s && *s == c)
			s++;
		wordlen = ft_wordlen(s, c);
		if (!(result[nb] = ft_strndup(s, wordlen)))
		{
			ft_free_str(result, nb - 1);
			return (0);
		}
		s += wordlen;
		nb++;
	}
	result[cnt] = 0;
	return (result);
}
