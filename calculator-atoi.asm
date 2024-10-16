%include    'functions.asm'

section .text
    global _start

_start:
    pop     ecx
    pop     edx
    sub     ecx, 1
    mov     edx, 0

next_arg:
    cmp     ecx, 0x0
    jz      no_more_args
    pop     eax
    call    atoi
    add     edx, eax
    dec     ecx
    jmp     next_arg

no_more_args:
    mov     eax, edx
    call    iprintln
    call    exit
