# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kirkim <kirkim@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/06 13:34:50 by kirkim            #+#    #+#              #
#    Updated: 2021/04/06 13:45:18 by kirkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC		= 	gcc
#CC		= 	clang
CFLAGS	= 	-Wall -Wextra -Werror
RM		= 	rm -f

NAME	= 	libftprintf.a

SRCS	=	ft_printf.c \
			ft_printf_setting.c \
			ft_printf_utils1.c \
			ft_printf_utils2.c \
			ft_setting_integer.c \
			ft_printf_cspct.c \
			6.c \
			ft_printf_integer.c \
			

OBJS	= 	$(SRCS:.c=.o)

.c.o:
			@$(CC) $(CFLAGS) -c $< -o $(<:.c=.o)

all:		$(NAME)

$(NAME):	$(OBJS)
			@ar -rcs $(NAME) $(OBJS)

bonus:		all

clean:
			@$(RM) $(OBJS)

fclean:		clean
			@$(RM) $(NAME)

re:			fclean all

rebonus:	fclean bonus

.PHONY:		all clean fclean re bonus rebonus
