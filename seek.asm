%include    'functions.asm'

section .data
    filename        db  'readme.txt', 0x0
    contents        db  '-updated-', 0x0
    contents_len    equ $ - contents

section .text
    global _start

_start:
    mov     ecx, O_WRONLY
    mov     ebx, filename
    mov     eax, SYS_OPEN
    int     0x80

    mov     edx, SEEK_END
    mov     ecx, 0
    mov     ebx, eax
    mov     eax, SYS_LSEEK
    int     0x80

    mov     edx, contents_len
    mov     ecx, contents
    mov     ebx, ebx
    mov     eax, SYS_WRITE
    int     0x80

    call    exit