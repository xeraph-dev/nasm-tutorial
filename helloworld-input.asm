%include    'functions.asm'

%define INPUT_LEN   255

section .data
    msg1    db      'Please enter your name: ', 0x0
    msg2    db      'Hello, ', 0x0

section .bss
    sinput: resb     INPUT_LEN

section .text
    global _start

_start:
    mov     eax, msg1
    call    sprint

    mov     edx, INPUT_LEN
    mov     ecx, sinput
    mov     ebx, STDIN
    mov     eax, SYS_READ
    int     0x80

    mov     eax, msg2
    call    sprint

    mov     eax, sinput
    call    sprint

    call    exit
