%define SYS_EXIT 1
%define SYS_WRITE 4

%define STDOUT 1

%define EXIT_SUCCESS 0

section .data
    msg     db      'Hello, brave new world!', 0xA

section .text
    global _start

_start:
    mov     ebx, msg
    mov     eax, ebx

nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar

finished:
    sub     eax, ebx
    mov     edx, eax
    mov     eax, SYS_WRITE
    mov     ebx, STDOUT
    mov     ecx, msg
    int     0x80

exit:
    mov     eax, SYS_EXIT
    mov     ebx, EXIT_SUCCESS
    int     0x80
