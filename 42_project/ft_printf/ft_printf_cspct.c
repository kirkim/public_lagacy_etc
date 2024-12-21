/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   5.c                                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 13:43:25 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 13:44:29 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

void	print_c(va_list ap, t_flag *fg, int *len)
{
	fg->c = (char)va_arg(ap, int);
	if (fg->left != 1)
		fg->padding_front -= ft_print_word(' ', fg->padding_front - 1, len);
	ft_print_word(fg->c, 1, len);
	if (fg->left == 1)
		fg->padding_front -= ft_print_word(' ', fg->padding_front - 1, len);
}

void	print_s(va_list ap, t_flag *fg, int *len)
{
	int		cnt;
	char	*temp;

	temp = va_arg(ap, char*);
	if (temp == NULL)
		temp = "(null)";
	cnt = ft_strlen(temp);
	if (fg->point == 1 && fg->padding_back >= 0)
		cnt = (cnt > fg->padding_back) ? fg->padding_back : cnt;
	fg->padding_front -= cnt;
	if (fg->left != 1)
		fg->padding_front -= ft_print_word(' ', fg->padding_front, len);
	write(1, temp, cnt);
	*len += cnt;
	if (fg->left == 1)
		fg->padding_front -= ft_print_word(' ', fg->padding_front, len);
}

void	print_pct(t_flag *fg, int *len)
{
	fg->padding_front -= 1;
	if (fg->left == 0)
	{
		if (fg->zero == 0)
			ft_print_word(' ', fg->padding_front, len);
		else
			ft_print_word('0', fg->padding_front, len);
	}
	ft_print_str("%", len);
	if (fg->left == 1)
		ft_print_word(' ', fg->padding_front, len);
}
