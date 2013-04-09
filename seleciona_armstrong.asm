global seleciona_armstrong

extern fopen
extern fclose
extern fscanf
extern printf

;_calcula: retorna 0 se não for,e 1 se for

    ;push   ebp
    ;mov    ebp, esp

    ;push   dx

    ;sub    esp, 40

;_loop 

section .text
seleciona_armstrong:

    push    ebp
    mov     ebp, esp
    ; sub     esp, 8
    ; mov eax,

    ; Idêntico ao fopen(file_name, file_mode)
    push    file_mode
    push    file_name
    call    fopen
    add     esp,8

    ; Ponteiro para uma estruct *FILE vai ser retornado em EAX.
    ; add     esp, 8   ; libera o espaço usado pelos parametros de fopen
    mov     [fp], eax ;

    ; Leituras dos numeros pelo fscanf(FILE* stream, const char * format,...)
       
    ; push DWORD [numero]
    ; push tipolido
    ; push DWORD [fp]
    ; ; mov    DWORD eax, numero
    ; ; push   eax
    ; ; mov    eax, tipolido
    ; ; push   eax
    ; ; mov    eax, [fp]
    ; ; push   eax
    ; call   fscanf 
    ; CMP    eax,0
    
    ; numero deve estar com seu valor, e f a função deve retornar 1
    
    ;Impressão na tela
    ; mov     [lido],eax
    ; mov     eax, [tipolido]
    ; push    eax
    ; mov     eax, [numero]
    ; push    eax
    ; call    printf
    
    ; int fclose(FILE *string)
    push DWORD[fp]
    call fclose
    add  esp,4

    ; void exit(int status);
    mov eax,1   ; numero da chamada ao sistema (exit)
    mov ebx,0   ; primeiro argumento: codigo de saida (sucesso)
    int 80h     ; chamada ao nucleo do SO

section .data                     ; Declaração de variaveis.

file_name: db "entrada", 0  ; alterar pra pegar do código C depois
file_mode: db "r", 0
tipolido : db "d", 0

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
fp:      resd   1
lido:    resd   1
