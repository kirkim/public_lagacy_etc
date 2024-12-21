/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   3.c                                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 13:21:14 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 13:21:32 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

void	print_diuo(va_list ap, t_flag *fg, const char c, int *len)
{
	set_print_cpy(ap, fg, c);
	if (fg->plus != 0)
		fg->padding_front--;
	set_front(&fg->plus, len, fg);
	ft_print_str(fg->result, len);
	if (fg->left == 1)
		ft_print_word(' ', fg->padding_front, len);
}

void	print_x(va_list ap, t_flag *fg, const char c, int *len)
{
	set_print_cpy(ap, fg, c);
	if (fg->plus != 0)
		fg->padding_front -= 2;
	if (c == 'x')
		set_front("0x", len, fg);
	else if (c == 'X')
		set_front("0X", len, fg);
	ft_print_str(fg->result, len);
	if (fg->left == 1)
		ft_print_word(' ', fg->padding_front, len);
}

void	print_p(va_list ap, t_flag *fg, const char c, int *len)
{
	set_print_cpy(ap, fg, c);
	fg->padding_front -= 2;
	if (fg->left != 1)
		ft_print_word(' ', fg->padding_front, len);
	ft_print_str("0x", len);
	ft_print_str(fg->result, len);
	if (fg->left == 1)
		ft_print_word(' ', fg->padding_front, len);
}
