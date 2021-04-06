/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf_utils1.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 13:33:56 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 13:33:57 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

size_t	ft_strchr(const char *s, char c)
{
	while (*s != '\0')
	{
		if (*s == c)
			return (1);
		s++;
	}
	return (0);
}

size_t	ft_print_word(char c, int cnt, int *len)
{
	int	result;

	result = 0;
	while (cnt-- > 0)
	{
		write(1, &c, 1);
		result++;
		(*len)++;
	}
	return (result);
}

void	ft_print_str(const char *str, int *len)
{
	const char	*temp;

	temp = str;
	while (*temp != '\0')
	{
		write(1, temp, 1);
		temp++;
		(*len)++;
	}
}

size_t	ft_strlen(const char *str)
{
	size_t	len;

	len = 0;
	while (*str != '\0')
	{
		str++;
		len++;
	}
	return (len);
}

void	ft_ullitoa_cpy(unsigned long long int num, char *num_version, char *str)
{
	size_t					num_len;
	int						cnt;
	unsigned long long int	nb;

	num_len = ft_strlen(num_version);
	nb = num / num_len;
	cnt = 1;
	while (nb > 0)
	{
		nb /= num_len;
		cnt++;
	}
	str[cnt] = '\0';
	while (cnt > 0)
	{
		str[cnt - 1] = num_version[num % num_len];
		cnt--;
		num /= num_len;
	}
}
