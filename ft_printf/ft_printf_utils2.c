/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf_utils2.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 13:34:06 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 13:34:08 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

void	*ft_memset(void *ptr, int value, size_t size)
{
	unsigned char	*pb;

	pb = ptr;
	while (size-- > 0)
		*pb++ = value;
	return (ptr);
}
