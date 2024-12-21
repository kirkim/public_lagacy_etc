/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memset.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/28 15:08:53 by kirkim            #+#    #+#             */
/*   Updated: 2020/12/28 15:08:54 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*ft_memset(void *ptr, int value, size_t num)
{
	unsigned char	*pb;
	size_t			i;

	i = 0;
	pb = ptr;
	while (i < num)
	{
		pb[i] = value;
		i++;
	}
	return (pb);
}
