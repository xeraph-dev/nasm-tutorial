%include        'functions.asm'

section .text
    global _start

_start:
    pop     ecx

next_arg:
    cmp     ecx, 0x0
    jz      no_more_args
    pop     eax
    call    sprintln
    dec     ecx
    jmp     next_arg

no_more_args:
    call    exit
