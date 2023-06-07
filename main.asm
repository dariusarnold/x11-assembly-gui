BITS 64
CPU X64

%define SYSCALL_EXIT 60
%define RETURN_SUCCESS 0

section .text
global _start
; Intel syntax:
; <instruction> <destination>, <source>
_start:
    ; Invoke syscall by writing system call code into rax and up to 6 parameters
    ; in rdi, rsi, rdx, rcx, r8, r9 (and additonal parameters on the stack)
    ; The return value will be placed in rax.
    mov rax, SYSCALL_EXIT
    mov rdi, RETURN_SUCCESS ; rdi holds first argument of syscall
    syscall