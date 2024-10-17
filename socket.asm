%include    'functions.asm'

section .data
    response        db  'HTTP/1.1 200 OK', 0xD, 0xA, 'Content-Type: text/html', 0xD, 0xA, 'Content-Length: 14', 0xD, 0xA, 0xD, 0xA, 'Hello World!', 0xD, 0xA, 0x0
    response_len    equ $ - response
 
section .bss
    buffer  resb    255,

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

_accept:
    push    byte 0
    push    byte 0
    push    edi
    mov     ecx, esp
    mov     ebx, ACCEPT
    mov     eax, SYS_SOCKETCALL
    int     0x80

_fork:
    mov     esi, eax
    mov     eax, SYS_FORK
    int     0x80

    cmp     eax, 0
    jz      _read

    jmp     _accept

_read:
    mov     edx, 255
    mov     ecx, buffer
    mov     ebx, esi
    mov     eax, SYS_READ
    int     0x80

    mov     eax, buffer
    call    sprintln

_write:
    mov     edx, response_len
    mov     ecx, response
    mov     ebx, esi
    mov     eax, SYS_WRITE
    int     0x80

_close:
    mov     ebx, esi
    mov     eax, SYS_CLOSE
    int     0x80

_exit:
    call    exit