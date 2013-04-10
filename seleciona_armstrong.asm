global seleciona_armstrong

extern fopen
extern fclose
extern fscanf
extern fprintf

;_calcula: retorna 0 se não for,e 1 se for

    ;push   ebp
    ;mov    ebp, esp

    ;push   dx

    ;mov    EAX,[numero] 
    ;mov    [quociente],EAX 	 ;quociente começa com o numero 	
    ;mov    ECX,0

;Conta os digitos e os empilha

;loop:
    ;mov    DWORD eax,[quociente];Armazena o conteudo de numero no reistrador eax
    ;mov    EBX, 10		 ;Armazena 10 no EBX,que será usado como divisor
    ;div    EBX			 ;Divide EAX por EBX,armazenando o quociente em EAX e o resto em EDX
    ;push   EDX			 ;Empilha o resto que também é o digito
    ;mov    quociente,eax	 ;Armazenda o quociente da divisão
    ;add    EXC,[contadigito]
    ;
    ;cmp    quociente, 0 
    ;jne    loop
    
;Calcula a soma dos digitos elevados ao valor armazenado em ECX,portanto não alterar ECX

    ;mov    EBX,0

;loop2:
    ;pop   EAX ;EAX recebe o digito que tinha sido empilhado
    ; exponencial?
    ;add   EBX,EAX  ;supondo que EAX devolva o valor corretamente
    ;usar uma variavel para determianr quantos digitos ainda faltam pra POP
    ;comparar,se > 0 continuar, se = 0 sair de loop2

    ;Comaprar numero com e EBX e verificar se é igual
    ;se sim,de volver 1,caso contrário,-1.

    ;sub    esp, 40

;_exponencial:


section .text
seleciona_armstrong:

    push    ebp         ; empilha endereco da base da pilha
    mov     ebp, esp    ; muda base da pilha
    
    
    mov     eax,[ebp+8]   ; Salva endereco da entrada
    mov     [i_addr],eax
    
    mov     eax,[ebp+12]  ; Salva endereco da saida
    mov     [o_addr],eax
    
    pusha               ; empilha valores dos registradores

    ; Idêntico ao fopen(file_name, file_mode)
    push    DWORD read_mode
    push    DWORD [i_addr] ;file_name
    call    fopen
    mov     [fpi], eax ;
    add     esp,8

    ; Idêntico ao fopen(file_name, file_mode)
    push    DWORD write_mode
    push    DWORD [o_addr] ;out_name
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
    ;call    _calcula	; chamada de para verficar se é um numero de armstrong
    
    cmp     eax,-1
    je      fim 
    
printf:
    push    DWORD [numero]
    push    DWORD inteiro
    push    DWORD [fpo]
    call    fprintf
    add     esp,12
    
    jne     scanf

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
    popa             ; desempilha antigos valores dos registradores
    pop     ebp      ; valor original de ebp em eax
    
    ret 

section .data                     ; Declaração de variaveis.

inteiro:    db "%d ",0
read_mode:  db "r", 0
write_mode: db "w", 0
;contadigito   db 1,0

o_pos:      db   12
i_pos:      db   16

; endereço das varáveis a ser calculada

section .bss

;quociente:	resd	1
fpi:     resd   1
fpo:     resd   1
soma:	 resd   1
numero:  resd   1
i_name:  resd   1
o_name:  resd   1
i_addr:  resd   1
o_addr:  resd   1
