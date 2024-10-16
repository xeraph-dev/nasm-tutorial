%include    'functions.asm'

section .data
    msg1    db  'Jumping to finished label.', 0x0
    msg2    db  'Inside subroutine number: ', 0x0
    msg3    db  'Inside subrouting "finished".', 0x0

section .text
    global _start

_start:

subroutine_one:
    mov     eax, msg1
    call    sprintln
    jmp     .finished

.finished:
    mov     eax, msg2
    call    sprint
    mov     eax, 1
    call    iprintln

subroutine_two:
    mov     eax, msg1
    call    sprintln
    jmp     .finished

.finished:
    mov     eax, msg2
    call    sprint
    mov     eax, 2
    call    iprintln

    mov     eax, msg1
    call    sprintln
    jmp     finished

finished:
    mov     eax, msg3
    call    sprintln
    call    exit
