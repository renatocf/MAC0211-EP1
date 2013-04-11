; /******************************************************/
; /**  MAC 0211  -  Introdução à  Computação           **/
; /**  IME-USP   -  Primeiro  Semestre  de    2012     **/
; /**  Turma 45  -  Kelly Rosa Bragheto                **/
; /**                                                  **/
; /**  Primeiro  Exercício-Programa                    **/
; /**  Arquivo:  armstrong.c                           **/
; /**                                                  **/
; /**  Renato Cordeiro Ferreira            7990933     **/
; /**  Diego Martos                        6880528     **/
; /**                                                  **/
; /**  10/04/13                                        **/
; /******************************************************/ 

global seleciona_armstrong

extern fopen
extern fclose
extern fscanf
extern fprintf

;----------------------------------------------------------------------
section .text
seleciona_armstrong:

    push    ebp           ; empilha endereco da base da pilha
    mov     ebp, esp      ; muda base da pilha
    
    ; Nome da entrada e da saida
    mov     eax,[ebp+8]   ; Salva endereco da entrada
    mov     [i_addr],eax
    mov     eax,[ebp+12]  ; Salva endereco da saida
    mov     [o_addr],eax
    
    ; inicializa total
    mov     DWORD [total],0
    ; pusha                 ; empilha valores dos registradores

    ; Identico ao fopen(file_name, file_mode)
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
    
    ; fscanf(FILE* stream, const char * format,...)
tag_fscanf:
    push    DWORD numero
    push    DWORD inteiro
    push    DWORD [fpi]
    call    fscanf 
    add     esp,12
    
    cmp     eax,-1
    je      fim 
    
    call    _calcula    ; verfica se é um numero de armstrong
    cmp     eax,-1
    je      tag_fscanf
    
tag_fprintf:
    inc     DWORD [total]
    push    DWORD [numero]
    push    DWORD inteiro
    push    DWORD [fpo]
    call    fprintf
    add     esp,12
    
    jmp     tag_fscanf

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
    ; popa             ; desempilha antigos valores dos registradores
    mov     eax,[total]
    pop     ebp      ; valor original de ebp em eax
    
    ret 

;----------------------------------------------------------------------
_calcula: ;retorna 0 se não for,e 1 se for
    push   ebp
    mov    ebp, esp
    ; pusha

    mov    eax,[numero]          ; Armazena o numero no registrador
    mov    DWORD[quociente],eax  ; Quociente começa com o numero 
    mov    ecx,0                 ; Inicializa o contador de digitos
    mov    ebx, 10               ; Armazena 10 no EBX,que será usado 
                                 ; como divisor
    
; Conta os digitos e os empilha
conta_digitos:
    mov    edx,0
    mov    eax,[quociente]       ; Armazena o conteudo de numero no
                                 ; registrador eax
    div    ebx                   ; Divide EAX por EBX,armazenando o 
                                 ; quociente em EAX e o resto em EDX
    push   edx                   ; Empilha o resto que também é o digito
    ; add    esp,4
    
    mov    DWORD [quociente],eax ; Armazena o quociente da divisão
    inc    ecx                   ; Incrementa o contador
    
    cmp    eax, 0                ; Checa se o número acabou (= 0)
    jne    conta_digitos         ; Se for != 0, itera novamente

    mov    DWORD [ndigitos],ecx        ; Apenas para impressao

;RODA CORRETAMENTE ATÈ AQUI

    mov    ebx,0  ; Calcula a soma dos digitos elevados ao valor 
                  ; armazenado em ecx, portanto não alterar ECX
    mov    ecx,0  ; contador
    mov    DWORD[soma],0

calculo:
    pop    eax            ; pega o primeiro digito do numero da pilha
    mov    [digito],eax;  ; move o digito para a variavel digito
    inc    ecx            ; incrementa ecx
    push   ecx
    
    call   _exponencial
    pop    ecx
    add    DWORD[soma],eax ; supondo que EAX devolva o valor corretamente
    cmp    ecx,[ndigitos]  ; compara ecx com o numero de digitos
    jne    calculo         ; se forem diferentes, reitera
    
teste:
    mov    eax,-1         ; coloca -1 em EAX
    mov    ebx,[soma]
    cmp    ebx,[numero]   ; compara ebx com o numero
    jne    final          ; se forem diferentes retorna -1
     
    mov    eax,1          ; caso for igual, retorna 1
    
final:
    ; popa
    pop    ebp            ; devolve o valor de ebp
    ret                   ; retorna
;----------------------------------------------------------------------
            
_exponencial:
    push   ebp
    mov    ebp, esp
    ; pusha
      
    mov    eax,1 
    mov    ebx,[digito]
    mov    ecx,0

loop:
    mul    ebx
    inc    ecx
    cmp    ecx,[ndigitos]
    jne    loop

finale:
    ; popa
    pop    ebp
    ret   
;----------------------------------------------------------------------
    
    
;----------------------------------------------------------------------

; Dados estaticos
section .data

    inteiro:    db "%d ",0
    read_mode:  db "r",0
    write_mode: db "w",0
    contadigito db 1,0

    o_pos:      db 12
    i_pos:      db 16
    msg:        db "blah "
    mss:        db "%s\n"

; Memoria alocada nao inicializada
section .bss

    digito:     resd 1
    ndigitos:   resd 1
    quociente:  resd 1
    fpi:        resd 1
    fpo:        resd 1
    soma:       resd 1
    total:      resd 1
    numero:     resd 1
    i_name:     resd 1
    o_name:     resd 1
    i_addr:     resd 1
    o_addr:     resd 1
