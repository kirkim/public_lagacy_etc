/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_itoa.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/28 15:26:34 by kirkim            #+#    #+#             */
/*   Updated: 2020/12/30 15:04:37 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

static char	*ft_putnum(unsigned int num, size_t *sz)
{
	char	*rst;

	if (!(rst = (char *)malloc(sizeof(char) * (*sz + 1))))
		return (0);
	rst[*sz] = '\0';
	while (num)
	{
		rst[*sz - 1] = num % 10 + '0';
		num /= 10;
		(*sz)--;
	}
	return (rst);
}

char		*ft_itoa(int n)
{
	size_t			size;
	char			*result;
	unsigned int	nb;

	size = n > 0 ? 0 : 1;
	nb = n > 0 ? n : -n;
	while (n)
	{
		n /= 10;
		size++;
	}
	result = ft_putnum(nb, &size);
	if (size == 1 && result[1] == '\0')
		result[0] = '0';
	else if (size == 1 && result[1] != '\0')
		result[0] = '-';
	return (result);
}
