%include    'functions.asm'

section .data
    msg1    db      'Hello, brave new world!', 0x0
    msg2    db      'This is how we recycle in nasm.', 0x0

section .text
    global _start

_start:
    mov     eax, msg1
    call    sprintln

    mov     eax, msg2
    call    sprintln

    call    exit
