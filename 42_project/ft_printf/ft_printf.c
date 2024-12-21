/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 13:34:27 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 13:34:28 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft_printf.h"

int	ft_printf(const char *format, ...)
{
	va_list	ap;
	int		read_len;

	read_len = 0;
	if (format == NULL)
		return (-1);
	va_start(ap, format);
	{
		while (*format != '\0')
		{
			if (*format != '%')
			{
				write(1, format++, 1);
				read_len++;
			}
			else
			{
				++format;
				set_form(ap, &format, &read_len);
			}
		}
	}
	va_end(ap);
	return (read_len);
}
