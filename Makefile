CC=g++
DEBUG = -g -DDEBUG

EXPERIMENTS = -DEXPERIMENTS

CFLAGS=-c -Wall
LDFLAGS=-Wall -lm

EXT=

SOURCES=compression_toolkit/coding_factory.cpp compression_toolkit/pfor_coding.cpp compression_toolkit/rice_coding2.cpp compression_toolkit/s9_coding.cpp compression_toolkit/vbyte_coding.cpp coding_policy.cpp compression_toolkit/null_coding.cpp compression_toolkit/rice_coding.cpp compression_toolkit/s16_coding.cpp compression_toolkit/unpack.cpp
OBJECTS=$(SOURCES:.cpp=.o)
	
MAINSRC=
MAINOBJ=$(MAINSRC:.cpp=.o)

EXECUTABLE=

#all: CFLAGS += -O9
all: $(SOURCES) $(MAINSRC) $(MAINOBJ) $(OBJECTS) $(EXECUTABLE) 

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

clean: cleanobj cleanexe

cleanobj:
	rm -f $(OBJECTS) $(MAINOBJ)

cleanexe:
	rm -f $(EXECUTABLE)

