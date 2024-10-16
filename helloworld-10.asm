%include    'functions.asm'

section .text
    global _start

_start:
    mov     ecx, 0

next_number:
    inc     ecx

    mov     eax, ecx
    add     eax, 48
    push    eax
    mov     eax, esp
    call    sprintln

    pop     eax
    cmp     ecx, 10
    jne     next_number

    call    exit
