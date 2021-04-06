/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_tolower.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/28 15:24:26 by kirkim            #+#    #+#             */
/*   Updated: 2020/12/28 15:24:28 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

int		ft_tolower(int character)
{
	if (character >= 'A' && character <= 'Z')
		character += ('a' - 'A');
	return (character);
}
