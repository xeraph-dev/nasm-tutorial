%include    'functions.asm'

section .data
    filename    db  'readme.txt', 0x0

section .text
    global _start

_start:
    mov     ebx, filename
    mov     eax, SYS_UNLINK
    int     0x80

    call    exit