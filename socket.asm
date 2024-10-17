%include    'functions.asm'

section .text
    global _start

_start:
    xor     eax, eax
    xor     ebx, ebx
    xor     edi, edi
    xor     esi, esi

_socket:
    push    byte IPPROTO_TCP
    push    byte SOCK_STREAM
    push    byte PF_INET
    mov     ecx, esp
    mov     ebx, SOCKET
    mov     eax, SYS_SOCKETCALL
    int     0x80

    call    iprintln

_exit:
    call    exit