%define SYS_EXIT 1
%define SYS_WRITE 4

%define STDOUT 1

%define EXIT_SUCCESS 0

section .data
    msg     db      'Hello World!', 0xA
    msg_len equ     $ - msg

section .text
    global _start

_start:
    mov     eax, SYS_WRITE
    mov     ebx, STDOUT
    mov     ecx, msg
    mov     edx, msg_len
    int     0x80

exit:
    mov     eax, SYS_EXIT
    mov     ebx, EXIT_SUCCESS
    int     0x80
