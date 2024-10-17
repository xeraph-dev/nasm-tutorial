%include    'functions.asm'

section .data
    request         db  'GET / HTTP/1.1', 0xD, 0xA, 'Host: 139.162.39.66:80', 0xD, 0xA, 0xD, 0xA, 0x0
    request_len     equ $ - request

section .bss
    buffer resb 1,

section .text
    global _start

_start:
    xor     eax, eax
    xor     ebx, ebx
    xor     edi, edi

_socket:
    push    byte IPPROTO_TCP
    push    byte SOCK_STREAM
    push    byte PF_INET
    mov     ecx, esp
    mov     ebx, SOCKET
    mov     eax, SYS_SOCKETCALL
    int     0x80

_connect:
    mov     edi, eax
    push    dword 0x4227a28b
    push    word 0x5000
    push    word AF_INET
    mov     ecx, esp
    push    byte 16
    push    ecx
    push    edi
    mov     ecx, esp
    mov     ebx, CONNECT
    mov     eax, SYS_SOCKETCALL
    int     0x80

_write:
    mov     edx, request_len
    mov     ecx, request
    mov     ebx, edi
    mov     eax, SYS_WRITE
    int     0x80

_read:
    mov     edx, 1
    mov     ecx, buffer
    mov     ebx, edi
    mov     eax, SYS_READ
    int     0x80

    cmp     eax, 0
    jz      _close
    
    mov     eax, buffer
    call    sprint
    jmp     _read

_close:
    mov     ebx, edi
    mov     eax, SYS_CLOSE
    int     0x80

_exit:
    call    exit

 