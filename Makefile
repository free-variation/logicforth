CC     = clang
CFLAGS = -O3 -march=native -Wall -Wextra
LDLIBS = -lm

ISOCLINE_DIR = third_party/isocline
ISOCLINE_OBJ = $(ISOCLINE_DIR)/isocline.o
ISOCLINE_INC = -I$(ISOCLINE_DIR)/include

SRCS = src/c/core.c src/c/words.c src/c/collections.c src/c/matrix.c src/c/functional.c
HDRS = src/c/logicforth.h

logicforth: $(SRCS) $(HDRS) $(ISOCLINE_OBJ)
	$(CC) $(CFLAGS) $(ISOCLINE_INC) -o logicforth $(SRCS) $(ISOCLINE_OBJ) $(LDLIBS)

$(ISOCLINE_OBJ): $(ISOCLINE_DIR)/src/isocline.c
	$(CC) -O2 -c $(ISOCLINE_DIR)/src/isocline.c -o $(ISOCLINE_OBJ)

test: logicforth
	sh tests/run.sh

clean:
	rm -f logicforth $(ISOCLINE_OBJ)

.PHONY: clean test
