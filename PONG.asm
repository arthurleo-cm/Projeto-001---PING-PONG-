;BASE
.model small
.stack 100h
; FAZENDO JOGO DO PING-PONG
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

raqueteCol db 2 
raqueteLin db 2
raqueteTam dw 10

raqueteCol2 db 2 
raqueteLin2 db 2
raqueteTam2 dw 10

caracterCor db 28h

cont db 0

linhaSUP db 0
colunaSUP db 0

linhaINF db 24
colunaINF db 0

linhaSESQ db 1
colunaSESQ db 0

linhaIESQ db 24
colunaIESQ db 0

linhaSDIR db 0
colunaSDIR db 79

linhaIDIR db 24
colunaIDIR db 79

.code


main:
    mov ax, @data
    mov ds, ax
    
    
     mov cursorLin,5
    mov cursorCol,10
    
    mov raqueteLin,12
    mov raqueteCol,63
    
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
   
    
      ;POSICIONAR O CURSO
      mov bh,paginaVideo
      mov dh,cursorLin
      mov dl,cursorCol
      mov ah,02h   
      int 10h
      ;POSICIONANDO A BOLINHA 
     mov al,"*"
     mov bh,paginaVideo
     mov cx,caracterRepeticao
     mov ah,0Ah  
     int 10h 
     



     ; COLOCANDO A RAQUETE
      mov ah,02h
     mov bh,paginaVideo
     mov dh,raqueteLin
    mov dl,raqueteCol
    int 10h
    
    mov al,"|"
     mov bh,paginaVideo
     mov cx,raqueteTam
    mov bl,31h
      mov ah,0Ah  
      int 10h 
     
     mov ah,10h
     int 16h
     mov tecla,al
     mov scanCode,ah
     
      ;POSICIONAR O CURSO
      mov bh,paginaVideo
      mov dh,cursorLin
      mov dl,cursorCol
      mov ah,02h   
      int 10h

      mov al," "
     mov bh,paginaVideo
     mov cx,caracterRepeticao
     mov ah,0Ah  
     int 10h 
     
     
     
     ;RAQUETE E CONTROLE
     ;apagar a raquete
     
    mov ah,02h
    mov bh,paginaVideo
    mov dh,raqueteLin
    mov dl,raqueteCol
    int 10h
    
    mov al," "
     mov bh,paginaVideo
     mov cx,raqueteTam
     mov bl,0h
     mov ah,0Ah  
     int 10h 
     
     ;MOVER RAQUETE ESQUERDA
     cmp tecla,"o"
     jnz desvioraquete001
     cmp raqueteCol,0
     je  desvioraquete001
     dec raqueteLin;aqui
     
 desvioraquete001:
     ;MOVER RAQUETE DIREITA
     cmp tecla,"l"
     jnz desvioraquete002
     cmp raqueteCol,60
     je desvioraquete002 
     inc raqueteLin ;aqui
     
     
     
 desvioraquete002:    
     
         ;TESTAR COLISAO BOLINHA RAQUETE 
    mov al,cursorLin
    mov bl,raqueteLin
    dec bl
    cmp al,bl
    jne desvio5
    mov al,cursorCol
    mov bl,raqueteCol
    cmp al,bl
    jb desvio5
    
     mov al,cursorCol
     mov bh,0
    mov bl,raqueteCol
    add bx,raqueteTam
    cmp al,bl
    ja desvio5
    mov dlin,-1
    
desvio5:
    
    
        ;TESTAR COLISAO BOLINHA RAQUETE 
    mov al,cursorLin
    mov bl,raqueteLin
    inc bl
    cmp al,bl
    jne desvio6
    mov al,cursorCol
    mov bl,raqueteCol
    cmp al,bl
    jb desvio6
    
     mov al,cursorCol
     mov bh,0
    mov bl,raqueteCol
    add bx,raqueteTam
    cmp al,bl
    ja desvio6
    mov dlin,1
    
desvio6:
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
    mov dcol, -1
    
    desvio2:
    
    ;LIMITE  COLUNA ESQUEDA
    cmp cursorCol,2
    jae desvio3
    mov dcol, 1
    
desvio3:
    ;LIMITE LINHA 0
    cmp cursorLin,2
    jae desvio4
    mov dlin,1
    
desvio4:
    
 
  
  
  
  
  
  
  
   
    
    
jmp loop



  


sairPrograma:

 mov ah, 4Ch  
 int 21h     

end main   
