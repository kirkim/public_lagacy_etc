/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/04/06 13:33:13 by kirkim            #+#    #+#             */
/*   Updated: 2021/04/06 14:14:39 by kirkim           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FT_PRINTF_H
# define FT_PRINTF_H

# include <stdarg.h>
# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>

# if !defined TRUE
#  define TRUE	1
# endif

# if !defined FALSE
#  define FALSE	0
# endif

# define FLAGS		"0#+ -"
# define POSITION	"0123456789.*-"
# define FORMAT		"cspdiuxX%onfge"
# define LOWHEXA	"0123456789abcdef"
# define HIGHHEXA	"0123456789ABCDEF"
# define OCTAL		"01234567"
# define DIGITS		"0123456789"

typedef struct	s_flags
{
	int						back_minus;
	int						star;
	int						left;
	int						blank;
	int						zero;
	int						point;
	int						cnt;
	int						padding_back;
	int						padding_front;
	int						data_length;
	char					plus;
	char					c;
	char					result[26];
	long long int			lli;
	unsigned long long int	ulli;
}				t_flag;

size_t			ft_strchr(const char *s, char c);
size_t			ft_strlen(const char *str);
void			ft_print_str(const char *str, int *len);
size_t			ft_print_word(char c, int cnt, int *len);
void			set_form(va_list ap, const char **format, int *len);
void			ft_ullitoa_cpy(unsigned long long int num, \
				char *num_version, char *str);
int				ft_printf(const char *format, ...);
void			print_diuo(va_list ap, t_flag *fg, const char c, int *len);
void			print_x(va_list ap, t_flag *fg, const char c, int *len);
void			print_p(va_list ap, t_flag *fg, const char c, int *len);
void			va_arg_di(va_list ap, t_flag *fg);
void			va_arg_uox(va_list ap, t_flag *fg);
void			print_c(va_list ap, t_flag *fg, int *len);
void			print_s(va_list ap, t_flag *fg, int *len);
void			set_print_cpy(va_list ap, t_flag *fg, char c);
void			print_f(va_list ap, t_flag *fg, int *len);
void			*ft_memset(void *ptr, int value, size_t size);
void			print_pct(t_flag *fg, int *len);
void			set_front(char *str, int *len, t_flag *fg);
void			set_ullitoa_cpy(va_list ap, t_flag *fg, char c);

#endif
