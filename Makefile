.PHONY: all clean

ASM = nasm
LD = i686-linux-gnu-ld
ASMFLAGS = -f elf
LDFLAGS =

TARGETS = helloworld helloworld-len helloworld-inc helloworld-lf helloworld-args helloworld-input helloworld-10 helloworld-itoa calculator-addition calculator-subtraction
OBJS = $(TARGETS:%=%.o)

all: $(TARGETS)

$(TARGETS): %: %.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm functions.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(TARGETS) $(OBJS)
