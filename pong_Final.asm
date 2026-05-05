;AUTOR:ARTHUR HENRIQUE
;JOGO PING-PONG FINALIZADO


;BASE
.model small
.stack 100h

;AREA PARA DECLARACAO DE VARIAVEIS
.data
cursorLin db 2
cursorCol db 2
paginaVideo db 0
MSG db "*$"
tecla db 0
scanCode db 0
caracterRepeticao dw 1
dlin db 1
dcol db 1
;DEFININDO RAQUETE 1(TAMANHO)
raqueteCol db 2 
raqueteLin db 2
raqueteTam db 10

caracterCor db 28h

;DEFININDO RAQUETE 2(TAMANHO)
raqueteCol2 db 2 
raqueteLin2 db 2
raqueteTam2 db 10


cont db 0

;CRIANDO AS LINHAS LIMITES SUPERIORES
linhaSUP db 0
colunaSUP db 0
;CRIANDO AS LINHAS LIMITES INFERIORES
linhaINF db 24
colunaINF db 0
;CRIANDO AS LINHAS LIMITES SUPERIORES NA ESQUERDA
linhaSESQ db 1
colunaSESQ db 0
;CRIANDO AS LINHAS LIMITES INFERIORES NA ESQUERDA
linhaIESQ db 24
colunaIESQ db 0
;CRIANDO AS LINHAS LIMITES SUPERIORES NA DIREITA
linhaSDIR db 1
colunaSDIR db 79
;CRIANDO AS LINHAS LIMITES INFERIORES NA DIREITA
linhaIDIR db 24
colunaIDIR db 79

;DEFININDO A PONTUA??O DOS JOGADORES
pontoESQ db 0
pontoDIR db 0





.code


main:
    mov ax, @data
    mov ds, ax
    
    ;POSI??O INICIAL DA BOLINHA
    mov cursorLin,5
    mov cursorCol,10
    ;POSI??O INICIAL DA RAQUETE
    mov raqueteLin,14
    mov raqueteCol,3
     ;POSI??O INICIAL DA RAQUETE
    mov raqueteLin2,7
    mov raqueteCol2,76
    
    mov dcol,1
    mov dlin,1   
   
    
    
    
    
    
    loopX1:
    ;CRIANDO A LINHA SUPERIOR
    ;DEFINIR POSICAO CURSOR
    ;SETAR POSICAO DO CURSOR
    mov ah,02h   ;CODIGO FUNCAO
    mov bh,paginaVideo
    mov dh,linhaSUP
    mov dl,colunaSUP
    int 10h

    ;ESCREVER CARACTER e ATRIBUTO 
    mov al,"_"
    mov bh,paginaVideo
    mov bl,1eh      ;0001 1110 = 1e
    mov cx,1
    mov ah,0ah ;CODIGO FUNCAO
    int 10h

    inc colunaSUP
    
    inc cont
    cmp cont,80
    jne loopX1

;CRIANDO LINHA INFERIOR
loopX2:    
    ;DEFINIR POSICAO CURSOR
    mov ah,02h
    mov bh,paginaVideo
    mov dh,linhaINF
    mov dl,colunaINF
    int 10h
;ESCREVER CARACTER e ATRIBUTO 
    mov al,"_"
    mov bh,paginaVideo
    mov bl,1eh
    mov cx,1
    mov ah,0ah
    int 10h

    inc colunaINF
    
    inc cont
    cmp cont,76
    jne loopX2
  
loopX3:
    ;CRIANDO A LINHA SUPERIOR ESQUERDA 
     mov ah,02h
    mov bh,paginaVideo
    mov dh,linhaSESQ
    mov dl,colunaSESQ
    int 10h
    
    mov al,"|"
    mov bh,paginaVideo
    mov bl,1eh
    mov cx,1
    mov ah,0ah
    int 10h
    
    inc linhaSESQ
    cmp linhaSESQ,7
    jne loopX3
    


loopX4:
    ;CRIANDO LINHA INFERIOR ESQUEDA PARA FORMAR OS PONTOS
    mov ah,02h
    mov bh,paginaVideo
    mov dh,linhaIESQ
    mov dl,colunaIESQ
    int 10h

    mov al,"|"
    mov bh,paginaVideo
    mov bl,1eh
    mov cx,1
    mov ah,0ah
    int 10h
    
    dec linhaIESQ
    cmp linhaIESQ,14
    jne loopX4
    
loopX5:
    ;CRIANDO LINHA DIREITA SUPERIOR PARA FORMAR OS PONTOS
    mov ah,02h
    mov bh,paginaVideo
    mov dh,linhaSDIR
    mov dl,colunaSDIR
    int 10h
    
     mov al,"|"
     mov bh,paginaVideo
      mov bl,1eh
     mov cx,1
      mov ah,0ah
      int 10h
    
    inc linhaSDIR
    cmp linhaSDIR,7
     jne loopX5
     
 loopX6:
     ;CRIANDO A LINHA INFERIOR NA DIREITA
     mov ah,02h
    mov bh,paginaVideo
    mov dh,linhaIDIR
    mov dl,colunaIDIR
    int 10h

    mov al,"|"
    mov bh,paginaVideo
    mov bl,1eh
    mov cx,1
    mov ah,0ah
    int 10h
    
    dec linhaIDIR
    cmp linhaIDIR,14
    jne loopX6
    
loop:
    
    ; =========================
; MOSTRAR PLACAR
; =========================

; jogador esquerdo
mov ah,02h
mov bh,0
mov dh,1
mov dl,35
int 10h

mov al,pontoESQ
add al,'0'
mov ah,0Eh
int 10h

; jogador direito
mov ah,02h
mov bh,0
mov dh,1
mov dl,45
int 10h

mov al,pontoDIR
add al,'0'
mov ah,0Eh
int 10h
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
      ;POSICIONAR O CURSO
      mov bh,paginaVideo
      mov dh,cursorLin
      mov dl,cursorCol
      mov ah,02h   
      int 10h

      mov al,"*"
     mov bh,paginaVideo
     mov cx,caracterRepeticao
     mov ah,0Ah  
     int 10h 
     
loop_raquete1:

    mov cl,raqueteTam
    mov ch,0
    
    mov dh,raqueteLin   ; s? aqui, fora do loop

raquete1:
    push cx

    mov ah,02h
    mov bh,paginaVideo
    mov dl,raqueteCol   ; coluna fixa
    int 10h

    mov al,"|"
    mov ah,09h          ; ? desenha 1 caractere
    mov bh,0
    mov bl,1eh 
    mov cx,1
    int 10h

    inc dh              ; ? desce uma linha

    pop cx
    loop raquete1
     
     
    

     
 loop_raquete2: 
   ;COLOCANDO A RAQUETE 2
   mov cl,raqueteTam2
mov ch,0
   
    mov dh,raqueteLin2   ; s? aqui, fora do loop

raquete2:
    push cx

    mov ah,02h
    mov bh,paginaVideo
    mov dl,raqueteCol2 ; coluna fixa
    int 10h

    mov al,"|"
    mov ah,09h          ; ? desenha 1 caractere
    mov bh,0
    mov bl,1eh 
    mov cx,1
    int 10h

    inc dh              ; ? desce uma linha

    pop cx
    loop raquete2  
     
     
      mov ah,10h
     int 16h
     mov tecla,al
     mov scanCode,ah
     
; APAGAR BOLINHA

    mov ah,02h
    mov bh,paginaVideo
    mov dh,cursorLin
    mov dl,cursorCol
    int 10h

    mov al," "
    mov bh,paginaVideo
    mov cx,caracterRepeticao
    mov ah,0Ah
    int 10h
     
     
     
     
    mov cl,raqueteTam
mov ch,0
    mov dh,raqueteLin

apaga_r1:
    push cx

    mov ah,02h
    mov bh,paginaVideo
    mov dl,raqueteCol
    int 10h

    mov al," "
    mov ah,09h
    mov bh,0
    mov bl,0
    mov cx,1
    int 10h

    inc dh

    pop cx
    loop apaga_r1
     
     ;APAGANDO RAQUETE 2
     mov cl,raqueteTam2
mov ch,0
     
      mov dh,raqueteLin2

apaga_r2:
    push cx

    mov ah,02h
    mov bh,paginaVideo
    mov dl,raqueteCol2
    int 10h

    mov al," "
    mov ah,09h
    mov bh,0
    mov bl,0
    mov cx,1
    int 10h

    inc dh

    pop cx
    loop apaga_r2
     
     
     
     
     
     
     
     
     
 ;MOVENDO RAQUETE PRA CIMA
     
 cmp tecla,"o"
 jnz mover_baixo_r2 
 cmp raqueteLin2,2 
 je  mover_baixo_r2
 dec raqueteLin2
    
mover_baixo_r2:
   ;MOVER RAQUETE PRA BAIXO
   cmp tecla,"l"
     jnz fim_r2
     cmp raqueteLin2,21
     je fim_r2
     inc raqueteLin2
     
     
fim_r2:    
     
     ;MOVER RAQUETE ESQUERDA
     cmp tecla,"w"
     jnz mover_baixo_r1
     cmp raqueteLin,2
     je mover_baixo_r1
     dec raqueteLin
     
 mover_baixo_r1:
     ;MOVER RAQUETE DIREITA
     cmp tecla,"s"
     jnz fim_r1
     cmp raqueteLin,23
     je fim_r1 
     inc raqueteLin
     
     
 fim_r1:    
     ;TESTAR MOVIMENTO BOLINHA RAQUETE
     
 ; =========================
; COLIS?O RAQUETE ESQUERDA
; =========================

mov al,cursorCol
mov bl,raqueteCol
inc bl
cmp al,bl
jne col_r2

mov al,cursorLin
mov bl,raqueteLin
cmp al,bl
jb col_r2

mov bl,raqueteLin
add bl,raqueteTam
cmp al,bl
ja col_r2

mov dcol,1


; =========================
; COLIS?O RAQUETE DIREITA
; =========================
col_r2:

mov al,cursorCol
mov bl,raqueteCol2
dec bl
cmp al,bl
jne fim_colisao

mov al,cursorLin
mov bl,raqueteLin2
cmp al,bl
jb fim_colisao

mov bl,raqueteLin2
add bl,raqueteTam2
cmp al,bl
ja fim_colisao

mov dcol,-1

fim_colisao:
 
 
       
     
     
     
     
     ;MAQUINA DE MOVIMENTO DA BOLINHA
    mov al,cursorCol
    mov bl,dcol
    add al,bl
    mov cursorCol,al
    
    mov al,cursorLin
    mov bl,dlin
    add al,bl
    mov cursorLin,al
   
    ;COMPARAR LIMITES
    ;LIMITE LINHA INFERIOR
    cmp cursorLin,22
    jbe desvio1
    mov dlin,-1
    
    desvio1:  
   
    ;LIMITE COLUNA DIREITA
    cmp cursorCol,77
    jbe desvio2
    
    
    inc pontoESQ      ; ponto pra esquerda
    call reset_bola
    jmp loop
    
    
    
    desvio2:
    
    ;LIMITE  COLUNA ESQUEDA
    cmp cursorCol,2
    jae desvio3
    
    inc pontoDIR      ; ponto pra direita
    call reset_bola
    jmp loop
    
    
    
    
    
desvio3:
    ;LIMITE LINHA 0
    cmp cursorLin,2
    jae desvio4
    mov dlin,1
    
    
desvio4:
    
 
    
    
    
    
jmp loop
   reset_bola:
    mov cursorLin,12
    mov cursorCol,40

    mov dcol,-1
    mov dlin,1

    ret 


sairPrograma:

 mov ah, 4Ch  
 int 21h     

end main   
