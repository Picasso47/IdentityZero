;use the follwing commands to compile and make a executable
;nasm -f elf64 -o calc.o calc.asm
;ld -o calc.exe calc.o
;objdump -M intel -d kerne.exe
;NOTE: ONLY FOR EDUCATIONAL PURPOSE

section .data
my_str db "calc.exe",0

section .bss

section .text
    global _start

_start:
    xor rbx,rbx
    mov bl,60h
    push QWORD gs:[rbx]     ;pointer to PEB
    pop rbx
    mov rbx,[rbx+0x18]      ;PEB+0x18->LDR
    mov rbx,[rbx+0x20]      ;LDR+0x20h->inmemordermodulelist struct(flink) -> ptr to my.exe
    push QWORD [rbx]        ;flink of my.exe (ntdll)
    pop rbx                 ;inmemordermodulelist of 1st LDR_DATA_TABLE_ENTRY->ntdll.dll
    push QWORD [rbx]        ;flink of ntdll.dll (kernel32)
    pop rbx                 ;inmemordermodulelist of 1st LDR_DATA_TABLE_ENTRY->kernel32.dll
    mov rbx,[rbx+0x20]      ;base address of kernel32.dll
    xor rdx,rdx
    mov edx,0x70B           ;bx=WinexecAddress-Kernel32BaseAddress -> 70B00
    shl edx,8               ;70B --> 70B00
    add rbx,rdx             ;Winexec
    sub rsp,16
    xor rcx,rcx
    mov rcx,my_str          ;LPCSTR (rcx->64bit)
    xor rdx,rdx             
    inc rdx
    call rbx
