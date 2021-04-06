/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf_setting.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 13:33:37 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 14:43:00 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

static void	star_arg(t_flag *fg, va_list ap)
{
	fg->star = va_arg(ap, int);
	if (fg->point == 0)
	{
		if (fg->star < 0)
		{
			fg->left = 1;
			fg->star *= -1;
		}
		fg->padding_front = fg->star;
	}
	else
		fg->padding_back = fg->star;
}

static void	set_position(t_flag *fg, va_list ap, char format)
{
	if (format == '.')
		fg->point = 1;
	else if (format == '*')
		star_arg(fg, ap);
	else if (fg->point == 0)
		fg->padding_front = 10 * fg->padding_front + (format - '0');
	else if (fg->point == 1)
	{
		if (format == '-')
			fg->back_minus = 1;
		else
			fg->padding_back = 10 * fg->padding_back + (format - '0');
	}
}

static void	set_flag(va_list ap, t_flag *fg, const char **format)
{
	while (ft_strchr(FLAGS, **format) == TRUE)
	{
		if (**format == '-')
			fg->left = 1;
		if (**format == '+')
			fg->plus = '+';
		if (**format == ' ')
			fg->plus = ' ';
		if (**format == '#')
			fg->plus = '0';
		if (**format == '0')
			fg->zero = 1;
		(*format)++;
	}
	while (ft_strchr(POSITION, **format) == TRUE)
	{
		set_position(fg, ap, **format);
		(*format)++;
	}
	if (fg->back_minus == 1)
		fg->padding_back *= -1;
	fg->back_minus = fg->padding_back;
}

static void	form_spec(va_list ap, const char *c, t_flag *fg, int *len)
{
	int		*n;

	if (*c == 'c')
		print_c(ap, fg, len);
	if (*c == 's')
		print_s(ap, fg, len);
	if (*c == 'd' || *c == 'i' || *c == 'u' || *c == 'o')
		print_diuo(ap, fg, *c, len);
	if (*c == 'x' || *c == 'X')
		print_x(ap, fg, *c, len);
	if (*c == 'p')
		print_p(ap, fg, *c, len);
	if (*c == 'n')
	{
		n = va_arg(ap, int *);
		*n = *len;
	}
	if (*c == '%')
		print_pct(fg, len);
	if (*c == 'f')
		print_f(ap, fg, len);
}

void		set_form(va_list ap, const char **format, int *len)
{
	t_flag	fg;

	ft_memset(&fg, 0, sizeof(t_flag));
	set_flag(ap, &fg, format);
	while (**format == 'l' || **format == 'h')
	{
		if (**format == 'l')
			fg.data_length++;
		if (**format == 'h')
			fg.data_length--;
		(*format)++;
	}
	form_spec(ap, *format, &fg, len);
	(*format)++;
}
