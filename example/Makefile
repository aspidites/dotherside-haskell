OBJS = main.c
CC = clang
COMPILER_FLAGS = -std=c11 -O2 -flto -Werror -Wshadow -fno-strict-aliasing -march=native
INCLUDE_FLAGS = -I/usr/include/DOtherSide 
LINKER_FLAGS = -lDOtherSide
OBJ_NAME = build/main

.PHONY: build
build: $(OBJS)
	mkdir -p build
	$(CC) $(OBJS) $(COMPILER_FLAGS) $(INCLUDE_FLAGS) $(LINKER_FLAGS) -o $(OBJ_NAME)

run: build
	$(OBJ_NAME)

clean:
	rm -rf build
