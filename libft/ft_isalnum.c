/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_isalnum.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/28 15:25:32 by kirkim            #+#    #+#             */
/*   Updated: 2020/12/28 15:25:50 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

int		ft_isalnum(int character)
{
	if ((character >= 'A' && character <= 'Z') \
		|| (character >= 'a' && character <= 'z') \
		|| (character >= '0' && character <= '9'))
		return (1);
	return (0);
}
