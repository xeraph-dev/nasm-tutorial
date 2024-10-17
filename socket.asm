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

_bind:
    mov     edi, eax
    push    dword 0x00000000
    push    word 0x2923
    push    word AF_INET
    mov     ecx, esp
    push    byte 16
    push    ecx
    push    edi
    mov     ecx, esp
    mov     ebx, BIND
    mov     eax, SYS_SOCKETCALL
    int     0x80

_listen:
    push    byte 1
    push    edi
    mov     ecx, esp
    mov     ebx, LISTEN
    mov     eax, SYS_SOCKETCALL
    int     0x80

_exit:
    call    exit