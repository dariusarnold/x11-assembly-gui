BITS 64
CPU X64

%define SYSCALL_WRITE 1
%define SYSCALL_EXIT 60
%define STDOUT 1
%define RETURN_SUCCESS 0
%define NEWLINE 0xA


print_hello:
    ; Save rbp to restore it at the end of the function
    push rbp
    mov rbp, rsp
    ; Put Hello on stack
    sub rsp, 16
    mov BYTE [rsp + 0], 'H'
    mov BYTE [rsp + 1], 'e'
    mov BYTE [rsp + 2], 'l'
    mov BYTE [rsp + 3], 'l'
    mov BYTE [rsp + 4], 'o'
    mov BYTE [rsp + 5], ' '
    ; Write to stdout
    mov rax, SYSCALL_WRITE
    mov rdi, STDOUT
    lea rsi, [rsp]
    mov rdx, 6
    syscall
    
    add rsp, 16

    pop rbp
    ret


print_world:
    ; Prologue 
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov BYTE [rsp + 0], 'W'
    mov BYTE [rsp + 2], 'r'
    mov BYTE [rsp + 3], 'l'
    mov BYTE [rsp + 1], 'o'
    mov BYTE [rsp + 4], 'd'
    mov BYTE [rsp + 5], NEWLINE
    mov rax, SYSCALL_WRITE
    mov rdi, STDOUT
    mov rsi, rsp
    mov rdx, 6
    syscall
    ; Epilogue
    add rsp, 16
    pop rbp
    ret

section .text
global _start
; Intel syntax:
; <instruction> <destination>, <source>
; The stack
; grows downwards, so decrease rsp to reserve space on stack
; functions must restore rsp to original value before returning
; rsp needs to be 16 bytes aligned before a function call
_start:
    call print_hello
    call print_world
    ; Invoke syscall by writing system call code into rax and up to 6 parameters
    ; in rdi, rsi, rdx, rcx, r8, r9 (and additonal parameters on the stack)
    ; The return value will be placed in rax.
    mov rax, SYSCALL_EXIT
    mov rdi, RETURN_SUCCESS ; rdi holds first argument of syscall
    syscall