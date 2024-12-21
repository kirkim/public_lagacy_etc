/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_setting_integer.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 14:34:40 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 14:41:43 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

void	va_arg_di(va_list ap, t_flag *fg)
{
	if (fg->data_length == -2)
		fg->lli = (char)va_arg(ap, int);
	else if (fg->data_length == -1)
		fg->lli = (short)va_arg(ap, int);
	else if (fg->data_length == 0)
		fg->lli = va_arg(ap, int);
	else if (fg->data_length == 1)
		fg->lli = va_arg(ap, long int);
	else if (fg->data_length == 2)
		fg->lli = va_arg(ap, long long int);
	if (fg->lli < 0)
	{
		fg->ulli = fg->lli * (-1);
		fg->plus = '-';
	}
	else
		fg->ulli = fg->lli;
}

void	va_arg_uox(va_list ap, t_flag *fg)
{
	if (fg->data_length == -2)
		fg->ulli = (unsigned char)va_arg(ap, int);
	else if (fg->data_length == -1)
		fg->ulli = (unsigned short)va_arg(ap, int);
	else if (fg->data_length == 0)
		fg->ulli = va_arg(ap, unsigned int);
	else if (fg->data_length == 1)
		fg->ulli = va_arg(ap, unsigned long int);
	else if (fg->data_length == 2)
		fg->ulli = va_arg(ap, unsigned long long int);
}

void	set_ullitoa_cpy(va_list ap, t_flag *fg, char c)
{
	if (c == 'd' || c == 'i' || c == 'u')
	{
		(c == 'u') ? va_arg_uox(ap, fg) : va_arg_di(ap, fg);
		ft_ullitoa_cpy(fg->ulli, DIGITS, fg->result);
	}
	else if (c == 'x' || c == 'X' || c == 'o')
	{
		va_arg_uox(ap, fg);
		if (c == 'o')
			ft_ullitoa_cpy(fg->ulli, OCTAL, fg->result);
		if (c == 'x')
			ft_ullitoa_cpy(fg->ulli, LOWHEXA, fg->result);
		if (c == 'X')
			ft_ullitoa_cpy(fg->ulli, HIGHHEXA, fg->result);
		if (fg->result[0] == '0' && fg->result[1] == '\0')
			fg->plus = 0;
	}
	else if (c == 'p')
	{
		fg->ulli = va_arg(ap, unsigned long int);
		ft_ullitoa_cpy(fg->ulli, LOWHEXA, fg->result);
	}
}

void	set_print_cpy(va_list ap, t_flag *fg, char c)
{
	int cnt;

	set_ullitoa_cpy(ap, fg, c);
	if (fg->point == 1 && fg->padding_back == 0 && fg->result[0] == '0' \
			&& fg->result[1] == '\0')
		fg->result[0] = '\0';
	cnt = ft_strlen(fg->result);
	fg->padding_front = (fg->padding_front > cnt) ? \
						(fg->padding_front - cnt) : 0;
	fg->padding_back = (fg->padding_back > cnt) ? \
						(fg->padding_back - cnt) : 0;
}

void	set_front(char *str, int *len, t_flag *fg)
{
	if (fg->left != 1)
	{
		if (fg->zero == 1 && (fg->point == 0 || fg->back_minus < 0))
		{
			if (fg->plus != 0)
				ft_print_str(str, len);
			fg->padding_front -= ft_print_word('0', fg->padding_front, len);
		}
		else
		{
			fg->padding_front -= ft_print_word(' ', \
					fg->padding_front - fg->padding_back, len);
			if (fg->plus != 0)
				ft_print_str(str, len);
			fg->padding_back -= ft_print_word('0', fg->padding_back, len);
		}
	}
	else
	{
		if (fg->plus != 0)
			ft_print_str(str, len);
		fg->padding_front -= fg->padding_back;
		fg->padding_back -= ft_print_word('0', fg->padding_back, len);
	}
}
