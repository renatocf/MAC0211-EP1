global seleciona_armstrong

extern fopen
extern fclose
extern fscanf
extern fprintf

;_calcula: retorna 0 se não for,e 1 se for

    ;push   ebp
    ;mov    ebp, esp

    ;push   dx

    ;sub    esp, 40

;_loop 

section .text
seleciona_armstrong:

    pusha               ; empilha valores dos registradores
    push    ebp         ; empilha endereco da base da pilha
    mov     ebp, esp    ; muda base da pilha
    ; sub     esp, 8
    ; mov eax,

    ; Idêntico ao fopen(file_name, file_mode)
    push    read_mode
    push    file_name
    call    fopen
    mov     [fpi], eax ;
    add     esp,8

    ; Idêntico ao fopen(file_name, file_mode)
    push    write_mode
    push    out_name
    call    fopen
    mov     [fpo], eax ;
    add     esp,8
    
    ; mov     eax,[ebp+o_pos]
    ; mov     DWORD [o_name],eax
    
    ; mov     eax,[ebp+i_pos]
    ; mov     DWORD [i_name],eax
    
    ; Ponteiro para uma estruct *FILE vai ser retornado em EAX.
    ; add     esp, 8   ; libera o espaço usado pelos parametros de fopen

    ; Leituras dos numeros pelo fscanf(FILE* stream, const char * format,...)

scanf:
    push    DWORD numero
    push    DWORD inteiro
    push    DWORD [fpi]
    call    fscanf 
    add     esp,12
    
    mov     DWORD [lido],eax
    cmp     DWORD [lido], -1
    je      fim 
    
printf:
    push    DWORD [numero]
    push    DWORD inteiro
    push    DWORD [fpo]
    call    fprintf
    add     esp,12
    
    jne     scanf
    ; jmp fim

fim:    
    ; int fclose(FILE *string)
    push    DWORD[fpi]
    call    fclose
    add     esp,4

    ; int fclose(FILE *string)
    push    DWORD[fpo]
    call    fclose
    add     esp,4
    
    ; restaura as condicoes iniciais
    pop     eax      ; valor original de ebp em eax
    xchg    ebp,eax  ; troca ebp com eax
    popa             ; desempilha antigos valores dos registradores
    
    ; void exit(int status);
    mov     eax,1   ; numero da chamada ao sistema (exit)
    mov     ebx,0   ; primeiro argumento: codigo de saida (sucesso)
    int     80h     ; chamada ao nucleo do SO

section .data                     ; Declaração de variaveis.

file_name:  db "entrada", 0  ; alterar pra pegar do código C depois
out_name:   db "saida", 0
read_mode:  db "r", 0
write_mode: db "w", 0
inteiro:    db "%d ",0

o_pos:      db   12
i_pos:      db   16

; endereço das varáveis a ser calculada

;Digit1: equ  +16
;Digit2: equ  +20
;Digit3: equ  +24
;Digit4: equ  +28
;Digit5: equ  +32
;Digit6: equ  +36
;Digit7: equ  +40
;Digit8: equ  +44
;Digit9: equ  +48

;variáveis locais

;temp1: equ -4
;temp2: equ -8
;temp3: equ -12
;temp4: equ -16
;temp5: equ -20
;Temp6: equ -24
;temp7: equ -28
;temp8: equ -32
;temp9: equ -36
;temp10: equ -40

section .bss

numero:  resd   1
fpi:     resd   1
i_name:  resd   1
fpo:     resd   1
o_name:  resd   1
lido:    resd   1
