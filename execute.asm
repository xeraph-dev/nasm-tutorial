%include    'functions.asm'

section .data
    command         db  '/bin/echo', 0x0
    arg1            db  'Hello World!', 0x0
    arguments       dd  command
                    dd  arg1
                    dd  0x0
    environment     dd  0x0

section .text
    global _start

_start:
    mov     edx, environment
    mov     ecx, arguments
    mov     ebx, command
    mov     eax, SYS_EXECV
    int     0x80

    call    exit
