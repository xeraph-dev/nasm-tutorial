%include    'functions.asm'

section .data
    filename    db      'readme.txt', 0x0

section .text
    global _start

_start:
    mov     ecx, 0o0777
    mov     ebx, filename
    mov     eax, SYS_CREAT
    int     0x80

    call    exit