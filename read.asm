%include    'functions.asm'

section .data
    filename        db  'readme.txt', 0x0
    contents        db  'Hello, World!', 0x0
    contents_len    equ $ - contents

section .bss
    file_contents   resb    255

section .text
    global _start

_start:
    mov     ecx, 0o0777
    mov     ebx, filename
    mov     eax, SYS_CREAT
    int     0x80

    mov     edx, contents_len
    mov     ecx, contents
    mov     ebx, eax
    mov     eax, SYS_WRITE
    int     0x80

    mov     ecx, O_RDONLY
    mov     ebx, filename
    mov     eax, SYS_OPEN
    int     0x80

    mov     edx, contents_len
    mov     ecx, file_contents
    mov     ebx, eax
    mov     eax, SYS_READ
    int     0x80

    mov     eax, file_contents
    call    sprintln

    call    exit