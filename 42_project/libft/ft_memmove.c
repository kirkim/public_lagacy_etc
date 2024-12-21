/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memmove.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/28 15:14:20 by kirkim            #+#    #+#             */
/*   Updated: 2020/12/30 00:59:05 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*ft_memmove(void *dst, const void *src, size_t num)
{
	const unsigned char	*sp;
	unsigned char		*dp;
	size_t				i;

	i = 0;
	sp = src;
	dp = dst;
	if (!dst && !src)
		return (0);
	if (dst > src)
		while (i < num)
		{
			dp[num - 1 - i] = sp[num - 1 - i];
			i++;
		}
	else
	{
		while (i < num)
		{
			dp[i] = sp[i];
			i++;
		}
	}
	return (dst);
}
