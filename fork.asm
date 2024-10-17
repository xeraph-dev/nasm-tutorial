%include    'functions.asm'

section .data
    child_msg   db  'This is the child process', 0x0
    parent_msg  db  'This is the parent process', 0x0

section .text
    global _start

_start:
    mov     eax, SYS_FORK
    int     0x80

    cmp     eax, 0
    jz      child

parent:
    mov     eax, parent_msg
    call    sprintln

    call    exit

child:
    mov     eax, child_msg
    call    sprintln

    call    exit