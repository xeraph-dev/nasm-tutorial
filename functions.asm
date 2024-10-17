%define SYS_EXIT        1
%define SYS_FORK        2
%define SYS_READ        3
%define SYS_WRITE       4
%define SYS_OPEN        5
%define SYS_CLOSE       6
%define SYS_CREAT       8
%define SYS_UNLINK      10
%define SYS_EXECV       11
%define SYS_TIME        13
%define SYS_LSEEK       19
%define SYS_SOCKETCALL  102

%define STDIN   0
%define STDOUT  1

%define EXIT_SUCCESS 0

%define O_RDONLY    0
%define O_WRONLY    1
%define O_RDWR      2

%define SEEK_SET    0
%define SEEK_CUR    1
%define SEEK_END    2

%define IPPROTO_TCP 6

%define SOCK_STREAM 1

%define AF_INET     2

%define PF_INET     2

%define SOCKET      1
%define BIND        2
%define LISTEN      4


;--------------------------------------------
; int atoi(Integer number)
; Ascii to integer function (atoi)
atoi:
    push    ebx
    push    ecx
    push    edx
    push    esi
    mov     esi, eax
    mov     eax, 0
    mov     ecx, 0

.multiply_loop:
    xor     ebx, ebx
    mov     bl, [esi+ecx]
    cmp     bl, 48
    jl      .finished
    cmp     bl, 57
    jg      .finished

    sub     bl, 48
    add     eax, ebx
    mov     ebx, 10
    mul     ebx
    inc     ecx
    jmp     .multiply_loop

.finished:
    cmp     ecx, 0
    je      .restore
    mov     ebx, 10
    div     ebx

.restore:
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    ret

;--------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0

.divide_loop:
    inc     ecx
    mov     edx, 0
    mov     esi, 10
    idiv    esi
    add     edx, 48
    push    edx
    cmp     eax, 0
    jnz     .divide_loop

.print_loop:
    dec     ecx
    mov     eax, esp
    call    sprint
    pop     eax
    cmp     ecx, 0
    jnz     .print_loop

    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret


;--------------------------------------------
; void iprintln(Integer number)
; Integer printing function with linefeed (itoa)
iprintln:
    call    iprint

    push    eax
    mov     eax, 0xA
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret


;--------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    ebx
    mov     ebx, eax

.nextchar:
    cmp     byte [eax], 0
    jz      .finished
    inc     eax
    jmp     .nextchar

.finished:
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
; void sprintln(String message)
; String printing with line feed function
sprintln:
    call    sprint

    push    eax
    mov     eax, 0xA
    push    eax

    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret


;--------------------------------------------
; void exit()
; Exit program and restore resources
exit:
    mov     ebx, EXIT_SUCCESS
    mov     eax, SYS_EXIT
    int     0x80
    ret
