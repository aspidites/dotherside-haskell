OBJS = hello.c
CC = clang
COMPILER_FLAGS = -std=c11 -O2 -flto -Werror -Wshadow -fno-strict-aliasing -o hello -march=native
INCLUDE_FLAGS = -I/usr/include/DOtherSide 
LINKER_FLAGS = -lDOtherSide
OBJ_NAME = build/hello

.PHONY: all
all: $(OBJS)
	mkdir build
	$(CC) $(OBJS) $(COMPILER_FLAGS) $(INCLUDE_FLAGS) $(LINKER_FLAGS) -o $(OBJ_NAME)
