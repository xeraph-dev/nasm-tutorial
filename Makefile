.PHONY: all clean

ASM = nasm
LD = i686-linux-gnu-ld
ASMFLAGS = -f elf
LDFLAGS =

TARGETS = helloworld namespace fizzbuzz execute \
			$(addprefix helloworld-,len inc lf args input 10 itoa) \
			$(addprefix calculator-,addition subtraction multiplication division atoi) \

OBJS = $(TARGETS:%=%.o)

all: $(TARGETS)

$(TARGETS): %: %.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm functions.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(TARGETS) $(OBJS)
