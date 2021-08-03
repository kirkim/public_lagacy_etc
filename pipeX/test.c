#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define BUFSIZE (30)

int main(int argc, char **argv)
{
	int fd[2];
	char buffer[BUFSIZE];
	pid_t pid;
	int state;

	if(pipe(fd) == -1)
	{
		printf("pipe error");
		exit(1);
	}

	pid = fork();

	if (pid == -1)
	{
		printf("fork() error");
		exit(1);
	}
	else if (pid == 0)
	{
		write(fd[1], "connect\n", 25);
		sleep(2);
		read(fd[0], buffer, BUFSIZE);
		printf("Output of child process : %s\n\n", buffer);
	}
	else
	{
		read(fd[0], buffer, BUFSIZE);
		printf("Output of parent process: %s\n\n", buffer);
		write(fd[1], "good job", 25);
		sleep(2);
	}

	return (0);
}
