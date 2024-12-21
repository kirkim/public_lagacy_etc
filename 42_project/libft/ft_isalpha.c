/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_isalpha.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/28 15:11:28 by kirkim            #+#    #+#             */
/*   Updated: 2020/12/28 15:12:07 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

int		ft_isalpha(int character)
{
	if ((character >= 'A' && character <= 'Z') \
		|| (character >= 'a' && character <= 'z'))
		return (1);
	return (0);
}
