.PHONY: all clean

ASM = nasm
LD = i686-linux-gnu-ld
ASMFLAGS = -f elf
LDFLAGS =

TARGETS = helloworld helloworld-len
OBJS = $(TARGETS:%=%.o)

all: $(TARGETS)

$(TARGETS): %: %.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(TARGETS) $(OBJS)
