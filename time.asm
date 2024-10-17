%include    'functions.asm'

section .data
    msg     db      'Seconds since Jan 01 1970: ', 0x0

section .text
    global _start

_start:
    mov     eax, msg
    call    sprint

    mov     eax, SYS_TIME
    int     0x80

    call    iprintln
    call    exit