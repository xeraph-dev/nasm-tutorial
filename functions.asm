%define SYS_EXIT 1
%define SYS_WRITE 4

%define STDOUT 1

%define EXIT_SUCCESS 0

;--------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    ebx
    mov     ebx, eax

nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar

finished:
    sub     eax, ebx
    pop     ebx
    ret


;--------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen

    mov     edx, eax
    pop     eax

    mov     ecx, eax
    mov     ebx, STDOUT
    mov     eax, SYS_WRITE
    int     0x80

    pop     ebx
    pop     ecx
    pop     edx
    ret

;--------------------------------------------
; void exit()
; Exit program and restore resources
exit:
    mov     ebx, EXIT_SUCCESS
    mov     eax, SYS_EXIT
    int     0x80
    ret
