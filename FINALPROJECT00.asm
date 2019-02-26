.MODEL SMALL
.STACK 100H

.DATA
STANDLEN DB 40
;CIRCLE PARAMETERS
MODE DB 18 ;640 x 480
 X_CENTER DW ?
 Y_CENTER DW ?
 Y_VALUE DW 0
 X_VALUE DW 28
 CHOICE DW 1
 COLOUR DB 7 ;7=white
 ;CIRCLE PARAMETERS
 
TURN DB 0
PROMPT DB 'ENTER YOUR MOVE: ',0DH,0AH,'$' 
MOVE DB ?
MARKARRAY DB 15 DUP(0)
PLAYER DB 0
WINNER DB 0
SUM1 DW 0
SUM2 DB 0
SUM3 DB 0
PLAYERONEWON DB 'PLAYER 1 HAS WON THIS GAME:D$'
PLAYERTWOWON DB 'PLAYER 2 HAS WON THIS GAME:D$'
DRAWMSG DB 'THIS GAME WAS DRAWN :|       $'
REMAINDER DW 0
NEXTMOVE DB 0
NOMOVEFIRSTPLAYER DB 0
MANVSMAN DB 'MAN VS MAN$'
MANVSPC DB 'MAN VS PC$'
PLAYER1WON DB 'PLAYER ONE HAS WON$'
PLAYER2WON DB 'PLAYER TWO HAS WON$'
PLAYERWON DB 'PLAYER HAS WON        $'
PCWON DB 'PC HAS WON         $'
PLAYER1SCORE DB 0
PLAYER2SCORE DB 0
PLAYERSCORE DB 0
PCSCORE DB 0
PLAYER1MOVE DB 'PLAYER ONE WILL MAKE MOVE$'
PLAYER2MOVE DB 'PLAYER TWO WILL MAKE MOVE$'
PLAYERMOVE DB 'PLAYER WILL MAKE MOVE$'
PCMOVED DB 'PC WILL MAKE MOVE$'
PLAY1 DB 'PLAYER 1: $'
PLAY2 DB 'PLAYER 2: $'
PLAY3 DB 'PLAYER: $'
PC DB 'PC: $'
TICTACTOE DB 'TICTACTOE GAME  $'
 
STARTMSG DB 'START AGAIN$'
EXITMSG DB 'EXIT $'
CLICKMSG DB 0DH,0AH,'CLICK RIGHT TO CONTINUE $'
PLAYAGAIN DB 0

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
    ;SET CGA 640X200 HIGH RES MODE
    MOV AX,6
    INT 10h
    
    ;SET PALETTE
    MOV AH,0BH
    MOV BH,1
    MOV BL,1
    INT 10H
    
    ;SET BGD COLOR
    MOV BH,0
    MOV BL,4
    INT 10H
    
    MOV AH,2
    MOV DH,0
    MOV DL,190
    INT 10H
    
    MOV AH,9
    LEA DX,TICTACTOE
    INT 21H
    
    MOV AH,2
    MOV DH,2
    MOV DL,177
    INT 10H
    
    MOV AH,9
    LEA DX,MANVSMAN
    INT 21H
    
    MOV AH,2
    MOV DH,8
    MOV DL,177
    INT 10H
    
    MOV AH,9
    LEA DX,MANVSPC
    INT 21H
 
    GETMOUSECLICK: 
    MOV TURN,0  
    MOV AX,1
    INT 33H
    MOV AX,3
    INT 33H
    CMP BX,1
    JNE GETMOUSECLICK
    CMP CX,100
    JL GETMOUSECLICK
    CMP CX,220
    JG GETMOUSECLICK
    CMP DX,65
    JG PROTHOM
    CMP DX,20
    JG DITIYO
    JMP GETMOUSECLICK
    
    DITIYO:
    CMP DX,30
    JL CALLMANVSMANGAME
    JMP GETMOUSECLICK
    PROTHOM:
    CMP DX,75
    JL CALLMANVSPCGAME
    JMP GETMOUSECLICK
    
    CALLMANVSMANGAME:
    CALL MANVSMANGAME
    MOV AX,6
    INT 10H
    MOV AX,0
    INT 33H
    MOV CX,9
    MOV DI,0
    LOOPBACK:
    MOV MARKARRAY[DI],0
    INC DI
    LOOP LOOPBACK
    MOV TURN,0
    MOV WINNER,0
    CMP PLAYAGAIN,1
    JE EXITTHISMAIN
    JMP CALLMANVSMANGAME
    
    CALLMANVSPCGAME: 
    CALL MANVSPCGAME
    MOV AX,6
    INT 10H
    MOV AX,0
    INT 33H
    MOV CX,9
    MOV DI,0
    LOOPBACK1:
    MOV MARKARRAY[DI],0
    INC DI
    LOOP LOOPBACK1
    MOV WINNER,0
    MOV TURN,0
    CMP PLAYAGAIN,1
    JE EXITTHISMAIN
    JMP CALLMANVSPCGAME 
    
    EXITTHISMAIN:
    
        
        ;SET TO TEXT MODE
        MOV AX, 3
        INT 10h
    
         
        
        MOV AH, 4CH
        INT 21h
    
MAIN ENDP    

MANVSMANGAME PROC NEAR
    MOV AX,6
    INT 10h
 
   MOV AH, 0CH
   MOV AL, 1;WRITE PIXEL VALUE
 
    
   MOV CX, 150 ; COLOUMN
   MOV DX, 125 ; ROW
    
   L1M: INT 10h
        INC CX
        CMP CX, 450
        JLE L1M
        
       
        
    MOV CX,150
    MOV DX,65
    
    L2M: INT 10h
        INC CX
        CMP CX, 450
        JLE L2M
        
     
        
    MOV CX,240
    MOV DX,20
    
    L3M: INT 10h
        INC DX
        CMP DX, 170
        JLE L3M
        
        
        
    MOV CX,360
    MOV DX,20
    
    L4M: INT 10h
        INC DX
        CMP DX, 170
        JLE L4M
         
      
        ;PRINT 1 
        MOV AH,2; THESE ALL ARE MOVE CURSOR FUNC
        MOV DH,2
        MOV DL,177
        INT 10H
        
        MOV AH,2
        MOV DL,49
        INT 21H
        
        ;PRINT 2
        MOV AH,2
        MOV DH,2
        MOV DL,191
        INT 10H
        
        MOV AH,2
        MOV DL,50
        INT 21H
        
        ;PRINT 3
        MOV AH,2
        MOV DH,2
        MOV DL,206
        INT 10H
        
        MOV AH,2
        MOV DL,51
        INT 21H
        
        ;PRINT 4 
        MOV AH,2
        MOV DH,8
        MOV DL,177
        INT 10H
        
        MOV AH,2
        MOV DL,52
        INT 21H
        
        ;PRINT 5
        MOV AH,2
        MOV DH,8
        MOV DL,191
        INT 10H
        
        MOV AH,2
        MOV DL,53
        INT 21H
        
        ;PRINT 6
        MOV AH,2
        MOV DH,8
        MOV DL,206
        INT 10H
        
        MOV AH,2
        MOV DL,54
        INT 21H
        
        
       ;PRINT 7 
        MOV AH,2
        MOV DH,16
        MOV DL,177
        INT 10H
        
        MOV AH,2
        MOV DL,55
        INT 21H
        
        ;PRINT 8
        MOV AH,2
        MOV DH,16
        MOV DL,191
        INT 10H
        
        MOV AH,2
        MOV DL,56
        INT 21H
        
        ;PRINT 9
        MOV AH,2
        MOV DH,16
        MOV DL,206
        INT 10H
        
        MOV AH,2
        MOV DL,57
        INT 21H 
        
        MOV AH,2
        MOV DX,0000
        INT 10H
        
        
        MOUSECLICKEDM:
        MOV AX,1
        INT 33H
        MOV AX,3
        INT 33H
        CMP BX,0
        JNE MOUSECLICKEDM
        
        CALL PLAYERMOVEPRINT
        
        JMP INPUTM
        
        WINNER1M:
        JMP ONEHASWONM
        WINNER2M:
        JMP TWOHASWONM
        
        DRAWMSGSHOWHOBE:
        JMP DRAWMSGSHOWM
    
        INPUTM:
        MOV AX,1
        INT 33H
        MOV AX,3
        INT 33H
        CMP BX,1
        JNE INPUTM
         
        MOV AX,2
        INT 33H
        ;CALL PLAYERMOVEPRINT
        CALL CHECKER
        CMP WINNER,1
        JE WINNER1M
        CMP WINNER,2
        JE WINNER2M
        CMP WINNER,3
        JE DRAWMSGSHOWHOBE
        CALL PLAYERMOVEPRINT 
        
        CMP DX,65
        JLE CONS1M
        CMP DX,125
        JLE PARTM
        JMP CONS3M
        
        CONS1M:
        CMP CX,240
        JLE ONEM
        CMP CX,360
        JLE TWOM
        JMP THREEM
        
        PARTM:
        JMP CONS2M
        ONEM:
        MOV DI,0
        CMP MARKARRAY[DI],0
        JNE INPUTM
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEONEM
        MOV TURN,0
        MOV CX,170
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        CIRCLEONEM:
        MOV X_CENTER,205
        MOV Y_CENTER,35
        CALL CIRCLEDRAW
        JMP INPUTM
        INP2M:
        JMP INPUTM
        
        TWOM:
        MOV DI,1
        CMP MARKARRAY[DI],0
        JNE INP2M
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLETWOM
        MOV TURN,0
        MOV CX,265
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        CIRCLETWOM:
        MOV X_CENTER,300
        MOV Y_CENTER,35
        CALL CIRCLEDRAW
        JMP INPUTM
        INPM:
        JMP INPUTM
        
        THREEM:
        MOV DI,2
        CMP MARKARRAY[DI],0
        JNE INPM
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLETHREEM
        MOV TURN,0
        MOV CX,385
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        CIRCLETHREEM:
        MOV X_CENTER,420
        MOV Y_CENTER,35
        CALL CIRCLEDRAW
        JMP INPUTM
        
        CONS2M:
        CMP CX,240
        JLE FOURM
        CMP CX,360
        JLE FIVEM
        JMP SIXM
        
        CONS3M:
        CMP CX,240
        MOV BX,1
        JLE MIDM 
        CMP CX,360
        MOV BX,2
        JLE MIDM 
        MOV BX,3
        JMP NINEM
        INP4M:
        JMP INPUTM
        
        FOURM:
        MOV DI,3
        CMP MARKARRAY[DI],0
        JNE INP4M
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEFOURM
        MOV TURN,0
        MOV CX,170
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        MIDM:
        JMP MIDWAYM
        
        CIRCLEFOURM:
        MOV X_CENTER,205
        MOV Y_CENTER,95
        CALL CIRCLEDRAW
        JMP INPUTM
        INP3M:
        JMP INPUTM
        
        FIVEM:
        MOV DI,4
        CMP MARKARRAY[DI],0
        JNE INP3M
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEFIVEM
        MOV TURN,0
        MOV CX,265
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        CIRCLEFIVEM:
        MOV X_CENTER,300
        MOV Y_CENTER,95
        CALL CIRCLEDRAW
        JMP INPUTM
        
        MIDWAYM:
        CMP BX,1
        JE SEVENM
        CMP BX,2
        JE EIGHT1M
        JMP NINEM
        INP6M:
        JMP INPUTM
        
        SIXM:
        MOV DI,5
        CMP MARKARRAY[DI],0
        JNE INP6M
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLESIXM
        MOV TURN,0
        MOV CX,385
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        EIGHT1M:
        JMP EIGHTM
        
        CIRCLESIXM:
        MOV X_CENTER,420
        MOV Y_CENTER,95
        CALL CIRCLEDRAW
        INP7M:
        JMP INPUTM
        
        SEVENM:
        MOV DI,6
        CMP MARKARRAY[DI],0
        JNE INP7M
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLESEVENM
        MOV TURN,0
        MOV CX,170
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        CIRCLESEVENM:
        MOV X_CENTER,205
        MOV Y_CENTER,155
        CALL CIRCLEDRAW
        INP8M:
        JMP INPUTM
        
        EIGHTM:
        MOV DI,7
        CMP MARKARRAY[DI],0
        JNE INP8M
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEEIGHTM
        MOV TURN,0
        MOV CX,265
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        CIRCLEEIGHTM:
        MOV X_CENTER,300
        MOV Y_CENTER,155
        CALL CIRCLEDRAW
        INP9M:
        JMP INPUTM
        
        NINEM:
        MOV DI,8
        CMP MARKARRAY[DI],0
        JNE INP9M
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLENINEM
        MOV TURN,0
        MOV CX,385
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUTM
        
        CIRCLENINEM:
        MOV X_CENTER,420
        MOV Y_CENTER,155
        CALL CIRCLEDRAW
        JMP INPUTM
        
        ONEHASWONM:
        MOV AH,2
        MOV DH,0
        MOV DL,0
        INT 10H
        MOV AH,9
        LEA DX,PLAYERONEWON
        INT 21H
        LEA DX,CLICKMSG
        INT 21H
        JMP SHOWTHIRDSCREENTAG
        JMP EXITMM
        
        
        TWOHASWONM:
        MOV AH,2
        MOV DH,0
        MOV DL,0
        INT 10H
        MOV AH,9
        LEA DX,PLAYERTWOWON
        INT 21H
        LEA DX,CLICKMSG
        INT 21H
        JMP SHOWTHIRDSCREENTAG
        JMP EXITMM
        
        DRAWMSGSHOWM:
        MOV AH,2
        MOV DH,0
        MOV DL,0
        INT 10H
        MOV AH,9
        LEA DX,DRAWMSG
        INT 21H
        LEA DX,CLICKMSG
        INT 21H
        
        SHOWTHIRDSCREENTAG:
        MOV AX,1
        INT 33H
        MOV AX,3
        INT 33H
        CMP BX,2 
        JNE SHOWTHIRDSCREENTAG
        MOV AX,6
        INT 10h
        CALL SHOWTHIRDSCREEN
        
        EXITMM:
        ;READ KEYSTROKE
        ;MOV AH, 0
        ;INT 16h
        
        ;SET TO TEXT MODE
        ;MOV AX, 3
        ;INT 10h
    
         
        
        ;MOV AH, 4CH
        ;INT 21h
    
    RET
MANVSMANGAME ENDP

SHOWTHIRDSCREEN PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    ;MOV AH,6
    ;INT 10H
    
    MOV AH,2
    MOV DH,2
    MOV DL,100
    INT 10H
    CMP WINNER,1
    JE PLAYER1WONTAG
    CMP WINNER,3
    JE DRAWTAG
    
    MOV AH,9
    LEA DX,PLAYER2WON
    INT 21H
    INC PLAYER2SCORE
    JMP PART2                  
    PLAYER1WONTAG:
    MOV AH,9
    LEA DX,PLAYER1WON
    INT 21H
    INC PLAYER1SCORE
    JMP PART2
    DRAWTAG:
    MOV AH,9
    LEA DX,DRAWMSG
    INT 21H
    PART2:
    MOV AH,2
    MOV DH,5
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,PLAY1
    INT 21H
    MOV AH,2
    MOV DL,PLAYER1SCORE
    ADD DL,48
    INT 21H
    
    MOV AH,2
    MOV DH,6
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,PLAY2
    INT 21H
    MOV AH,2
    MOV DL,PLAYER2SCORE
    ADD DL,48
    INT 21H
    
    MOV AH,2
    MOV DH,10
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,STARTMSG
    INT 21H
    
    MOV AH,2
    MOV DH,12
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,EXITMSG
    INT 21H
    
    LOOPBACK2:  
    MOV AX,1
    INT 33H
    MOV AX,3
    INT 33H
    CMP BX,1
    JNE LOOPBACK2
    
    CMP CX,145
    JL LOOPBACK2
    CMP CX,250
    JG LOOPBACK2
    CMP DX,93
    JG FULLYEXIT
    CMP DX,81
    JG STARTMSGTAG
    JMP LOOPBACK2
    
    STARTMSGTAG:
    CMP DX,92
    JG LOOPBACK2
    JMP EXITTHISPART
    
    
    
    EXITTHISPART:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
    FULLYEXIT:
    CMP DX,103
    JG LOOPBACK2
    POP DX
    POP CX
    POP BX
    POP AX
    MOV PLAYAGAIN,1
    RET
SHOWTHIRDSCREEN ENDP


SHOWTHIRDSCREENPC PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    ;MOV AH,6
    ;INT 10H
    
    MOV AH,2
    MOV DH,2
    MOV DL,100
    INT 10H
    CMP WINNER,1
    JE PLAYER1WONTAGM
    CMP WINNER,3
    JE DRAWTAGM
    
    MOV AH,9
    LEA DX,PCWON
    INT 21H
    INC PCSCORE
    JMP PART2M                  
    PLAYER1WONTAGM:
    MOV AH,9
    LEA DX,PLAYERWON
    INT 21H
    INC PLAYERSCORE
    JMP PART2M
    DRAWTAGM:
    MOV AH,9
    LEA DX,DRAWMSG
    INT 21H
    PART2M:
    MOV AH,2
    MOV DH,5
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,PLAY3
    INT 21H
    MOV AH,2
    MOV DL,PLAYERSCORE
    ADD DL,48
    INT 21H
    
    MOV AH,2
    MOV DH,6
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,PC
    INT 21H
    MOV AH,2
    MOV DL,PCSCORE
    ADD DL,48
    INT 21H
    
    MOV AH,2
    MOV DH,10
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,STARTMSG
    INT 21H
    
    MOV AH,2
    MOV DH,12
    MOV DL,100
    INT 10H
    
    MOV AH,9
    LEA DX,EXITMSG
    INT 21H
    
    LOOPBACK2M:  
    MOV AX,1
    INT 33H
    MOV AX,3
    INT 33H
    CMP BX,1
    JNE LOOPBACK2M
    
    CMP CX,145
    JL LOOPBACK2M
    CMP CX,250
    JG LOOPBACK2M
    CMP DX,93
    JG FULLYEXITM
    CMP DX,81
    JG STARTMSGTAGM
    JMP LOOPBACK2M
    
    STARTMSGTAGM:
    CMP DX,92
    JG LOOPBACK2M
    JMP EXITTHISPARTM
    
    
    
    EXITTHISPARTM:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
    FULLYEXITM:
    CMP DX,103
    JG LOOPBACK2M
    POP DX
    POP CX
    POP BX
    POP AX
    MOV PLAYAGAIN,1
    RET
    SHOWTHIRDSCREENPC ENDP

PLAYERMOVEPRINT PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AH,2
    MOV DH,0
    MOV DL,0
    INT 10H
    CMP TURN,0
    JE PRINT1
    MOV AH,9
    LEA DX,PLAYER2MOVE
    INT 21H
    JMP EXITTHIS
    PRINT1:
    MOV AH,9
    LEA DX,PLAYER1MOVE
    INT 21H

    EXITTHIS:
    POP DX
    POP CX
    POP BX
    POP AX
    RET    

PLAYERMOVEPRINT ENDP

PLAYERMOVEPRINT2 PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AH,2
    MOV DH,0
    MOV DL,0
    INT 10H
    CMP TURN,0
    JE PRINT11
    MOV AH,9
    LEA DX,PCMOVED
    INT 21H
    JMP EXITTHISS
    PRINT11:
    MOV AH,9
    LEA DX,PLAYERMOVE
    INT 21H

    EXITTHISS:
    POP DX
    POP CX
    POP BX
    POP AX
    RET    

    PLAYERMOVEPRINT2 ENDP

MANVSPCGAME PROC NEAR    
    MOV AX,6
    INT 10H
    
 
   MOV AH, 0CH
   MOV AL, 1;WRITE PIXEL VALUE
    
   MOV CX, 150 ; COLOUMN
   MOV DX, 125 ; ROW
    
    L1: INT 10h
        INC CX
        CMP CX, 450
        JLE L1
        
       
        
    MOV CX,150
    MOV DX,65
    
    L2: INT 10h
        INC CX
        CMP CX, 450
        JLE L2
        
     
        
    MOV CX,240
    MOV DX,20
    
    L3: INT 10h
        INC DX
        CMP DX, 170
        JLE L3
        
        
        
    MOV CX,360
    MOV DX,20
    
    L4: INT 10h
        INC DX
        CMP DX, 170
        JLE L4
        
         
    
        ;MOV X_CENTER,405
        ;MOV Y_CENTER,95    
        ;CALL CIRCLE  
      
        ;PRINT 1 
        MOV AH,2; THESE ALL ARE MOVE CURSOR FUNC
        MOV DH,2
        MOV DL,177
        INT 10H
        
        MOV AH,2
        MOV DL,49
        INT 21H
        
        ;PRINT 2
        MOV AH,2
        MOV DH,2
        MOV DL,191
        INT 10H
        
        MOV AH,2
        MOV DL,50
        INT 21H
        
        ;PRINT 3
        MOV AH,2
        MOV DH,2
        MOV DL,206
        INT 10H
        
        MOV AH,2
        MOV DL,51
        INT 21H
        
        ;PRINT 4 
        MOV AH,2
        MOV DH,8
        MOV DL,177
        INT 10H
        
        MOV AH,2
        MOV DL,52
        INT 21H
        
        ;PRINT 5
        MOV AH,2
        MOV DH,8
        MOV DL,191
        INT 10H
        
        MOV AH,2
        MOV DL,53
        INT 21H
        
        ;PRINT 6
        MOV AH,2
        MOV DH,8
        MOV DL,206
        INT 10H
        
        MOV AH,2
        MOV DL,54
        INT 21H
        
        
       ;PRINT 7 
        MOV AH,2
        MOV DH,16
        MOV DL,177
        INT 10H
        
        MOV AH,2
        MOV DL,55
        INT 21H
        
        ;PRINT 8
        MOV AH,2
        MOV DH,16
        MOV DL,191
        INT 10H
        
        MOV AH,2
        MOV DL,56
        INT 21H
        
        ;PRINT 9
        MOV AH,2
        MOV DH,16
        MOV DL,206
        INT 10H
        
        MOV AH,2
        MOV DL,57
        INT 21H 
        
        MOV AH,2
        MOV DX,0000
        INT 10H
        
        MOUSECLICKED:
        MOV AX,1
        INT 33H
        MOV AX,3
        INT 33H
        CMP BX,0
        JNE MOUSECLICKED
     
        JMP INPUT
        
        
        ZEROCROSS:
        MOV CX,170
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[0],4
        JMP INPUT
        
        FIRSTCROSS:
        MOV CX,265
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[1],4
        JMP INPUT
        SECONDCROSS:
        MOV CX,385
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[2],4
        JMP INPUT
        THIRDCROSS:
        MOV CX,170
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[3],4
        JMP INPUT
        FOURTHCROSS:
        MOV CX,265
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[4],4
        JMP INPUT
        ZEROJUMP:
        FIFTHCROSS:
        MOV CX,385
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[5],4
        JMP INPUT
        SIXTHCROSS:
        MOV CX,170
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[6],4
        JMP INPUT
        SEVENCROSS:
        MOV CX,265
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[7],4
        JMP INPUT
        EIGHTCROSS:
        MOV CX,385
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[8],4
        JMP INPUT
        
        ZEROTHJUMP:
        JMP ZEROCROSS
        FIRSTJUMP:
        JMP FIRSTCROSS
        SECONDJUMP:
        JMP SECONDCROSS
        THIRDJUMP:
        JMP THIRDCROSS
        FOURTHJUMP:
        JMP FOURTHCROSS
        FIFTHJUMP:
        JMP FIFTHCROSS
        SIXTHJUMP:
        JMP SIXTHCROSS
        SEVENTHJUMP:
        JMP SEVENCROSS
        EIGHTJUMP:
        JMP EIGHTCROSS
        
        PCMOVE:
        CMP REMAINDER,0
        JE ZEROTHJUMP
        CMP REMAINDER,1
        JE FIRSTJUMP
        CMP REMAINDER,2
        JE SECONDJUMP
        CMP REMAINDER,3
        JE THIRDJUMP
        CMP REMAINDER,4
        JE FOURTHJUMP
        CMP REMAINDER,5
        JE FIFTHJUMP
        CMP REMAINDER,6
        JE SIXTHJUMP
        CMP REMAINDER,7
        JE SEVENTHJUMP
        JMP EIGHTJUMP
        JMP INPUT
        
        WINNER1:
        JMP ONEHASWON
        WINNER2:
        JMP TWOHASWON
        DRAW:
        JMP DRAWMSGSHOW 
        
        INPUT:
        MOV AX,1
        INT 33H
        MOV AX,3
        INT 33H
        CMP BX,1
        JNE INPUT
        MOV AX,2
        INT 33H
        ;CALL PLAYERMOVEPRINT2
        CALL CHECKER
        CMP WINNER,1
        JE WINNER1
        CMP WINNER,2
        JE WINNER2
        CMP WINNER,3
        JE DRAWKORSI
        CMP TURN,0
        JE PORER_MOVE
        CALL NEXTMOVERETURN
        MOV TURN,0
        JMP PCMOVE
        
        DRAWKORSI:
        JMP DRAWMSGSHOW
        
        PORER_MOVE:
        CMP DX,65
        JLE CONS1
        CMP DX,125
        JLE PART
        JMP CONS3
        
        CONS1:
        CMP CX,240
        JLE ONE
        CMP CX,360
        JLE TWO
        JMP THREE
        
        PART:
        JMP CONS2
        ONE:
        MOV DI,0
        CMP MARKARRAY[DI],0
        JNE INPUT
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEONE
        MOV TURN,0
        MOV CX,170
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        CIRCLEONE:
        MOV X_CENTER,205
        MOV Y_CENTER,35
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        JMP INPUT
        INP2:
        JMP INPUT
        
        TWO:
        MOV DI,1
        CMP MARKARRAY[DI],0
        JNE INP2
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLETWO
        MOV TURN,0
        MOV CX,265
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        CIRCLETWO:
        MOV X_CENTER,300
        MOV Y_CENTER,35
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        JMP INPUT
        INP:
        JMP INPUT
        
        THREE:
        MOV DI,2
        CMP MARKARRAY[DI],0
        JNE INP
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLETHREE
        MOV TURN,0
        MOV CX,385
        MOV DX,20
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,20
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        CIRCLETHREE:
        MOV X_CENTER,420
        MOV Y_CENTER,35
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        JMP INPUT
        
        CONS2:
        CMP CX,240
        JLE FOUR
        CMP CX,360
        JLE FIVE
        JMP SIX
        
        CONS3:
        CMP CX,240
        MOV BX,1
        JLE MID 
        CMP CX,360
        MOV BX,2
        JLE MID 
        MOV BX,3
        JMP NINE
        INP4:
        JMP INPUT
        
        FOUR:
        MOV DI,3
        CMP MARKARRAY[DI],0
        JNE INP4
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEFOUR
        MOV TURN,0
        MOV CX,170
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        MID:
        JMP MIDWAY
        
        CIRCLEFOUR:
        MOV X_CENTER,205
        MOV Y_CENTER,95
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        JMP INPUT
        INP3:
        JMP INPUT
        
        FIVE:
        MOV DI,4
        CMP MARKARRAY[DI],0
        JNE INP3
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEFIVE
        MOV TURN,0
        MOV CX,265
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        CIRCLEFIVE:
        MOV X_CENTER,300
        MOV Y_CENTER,95
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        JMP INPUT
        
        MIDWAY:
        CMP BX,1
        JE SEVEN
        CMP BX,2
        JE EIGHT1
        JMP NINE
        INP6:
        JMP INPUT
        
        SIX:
        MOV DI,5
        CMP MARKARRAY[DI],0
        JNE INP6
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLESIX
        MOV TURN,0
        MOV CX,385
        MOV DX,75
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,75
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        EIGHT1:
        JMP EIGHT
        
        CIRCLESIX:
        MOV X_CENTER,420
        MOV Y_CENTER,95
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        INP7:
        JMP INPUT
        
        SEVEN:
        MOV DI,6
        CMP MARKARRAY[DI],0
        JNE INP7
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLESEVEN
        MOV TURN,0
        MOV CX,170
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,210
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        CIRCLESEVEN:
        MOV X_CENTER,205
        MOV Y_CENTER,155
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        INP8:
        JMP INPUT
        
        EIGHT:
        MOV DI,7
        CMP MARKARRAY[DI],0
        JNE INP8
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLEEIGHT
        MOV TURN,0
        MOV CX,265
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,305
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        CIRCLEEIGHT:
        MOV X_CENTER,300
        MOV Y_CENTER,155
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        INP9:
        JMP INPUT
        
        NINE:
        MOV DI,8
        CMP MARKARRAY[DI],0
        JNE INP9
        MOV MARKARRAY[DI],1
        CMP TURN,0
        JE CIRCLENINE
        MOV TURN,0
        MOV CX,385
        MOV DX,135
        CALL DIAGFIRST
        MOV CX,425
        MOV DX,135
        CALL DIAGSECOND
        MOV MARKARRAY[DI],4
        JMP INPUT
        
        CIRCLENINE:
        MOV X_CENTER,420
        MOV Y_CENTER,155
        CALL CIRCLEDRAW
        INC NOMOVEFIRSTPLAYER
        JMP INPUT
        
         
        
        ONEHASWON:
        MOV AH,2
        MOV DH,0
        MOV DL,0
        INT 10H
        MOV AH,9
        LEA DX,PLAYERWON
        INT 21H
        LEA DX,CLICKMSG
        INT 21H
        JMP SHOWTHIRDSCREENTAGM
        JMP EXIT
        
        
        TWOHASWON:
        MOV AH,2
        MOV DH,0
        MOV DL,0
        INT 10H
        MOV AH,9
        LEA DX,PCWON
        INT 21H
        LEA DX,CLICKMSG
        INT 21H
        JMP SHOWTHIRDSCREENTAGM
        JMP EXIT
        
        DRAWMSGSHOW:
        MOV AH,2
        MOV DH,0
        MOV DL,0
        INT 10H
        MOV AH,9
        LEA DX,DRAWMSG
        INT 21H
        LEA DX,CLICKMSG
        INT 21H
        
        SHOWTHIRDSCREENTAGM:
        MOV AX,1
        INT 33H
        MOV AX,3
        INT 33H
        CMP BX,2 
        JNE SHOWTHIRDSCREENTAGM
        MOV AX,6
        INT 10h
        CALL SHOWTHIRDSCREENPC
        
        EXIT:
      
        RET
        MANVSPCGAME ENDP


        
RANDOMGEN PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AH,2CH
    INT 21H
    MOV AL,DL
    MOV SUM1,9
    MOV AH,0
    MOV DX,0
    DIV SUM1
    MOV REMAINDER,DX
    
    
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
    
RANDOMGEN ENDP   

NEXTMOVERETURN PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    
    SHOULDGEN:
    CALL RANDOMGEN
    MOV DI,REMAINDER
    CMP MARKARRAY[DI],0
    JE EXXX 
    JMP SHOULDGEN
    EXXX:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
NEXTMOVERETURN ENDP     
        

CHECKER PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV DI,0
    MOV AL,0
    MOV AL,MARKARRAY[DI]
    ADD AL,MARKARRAY[DI+3]
    ADD AL,MARKARRAY[DI+6]
    CMP AL,3
    JE WIN11
    CMP AL,12
    JE WIN22
    MOV AL,MARKARRAY[DI+1]
    ADD AL,MARKARRAY[DI+4]
    ADD AL,MARKARRAY[DI+7]
    CMP AL,3
    JE WIN11
    CMP AL,12
    JE WIN22
    MOV AL,MARKARRAY[DI+2]
    ADD AL,MARKARRAY[DI+5]
    ADD AL,MARKARRAY[DI+8]
    CMP AL,3
    JE WIN11
    CMP AL,12
    JE WIN22
    
    JMP NEXT
    WIN11:
    JMP WIN1
    WIN22:
    JMP WIN2
    NEXT:
    MOV AL,MARKARRAY[DI]
    ADD AL,MARKARRAY[DI+1]
    ADD AL,MARKARRAY[DI+2]
    CMP AL,3
    JE WIN1
    CMP AL,12
    JE WIN2
    MOV AL,MARKARRAY[DI+3]
    ADD AL,MARKARRAY[DI+4]
    ADD AL,MARKARRAY[DI+5]
    CMP AL,3
    JE WIN1
    CMP AL,12
    JE WIN2
    MOV AL,MARKARRAY[DI+6]
    ADD AL,MARKARRAY[DI+7]
    ADD AL,MARKARRAY[DI+8]
    CMP AL,3
    JE WIN1
    CMP AL,12
    JE WIN2
    
    MOV AL,MARKARRAY[DI+0]
    ADD AL,MARKARRAY[DI+4]
    ADD AL,MARKARRAY[DI+8]
    CMP AL,3
    JE WIN1
    CMP AL,12
    JE WIN2
    MOV AL,MARKARRAY[DI+2]
    ADD AL,MARKARRAY[DI+4]
    ADD AL,MARKARRAY[DI+6]
    CMP AL,3
    JE WIN1
    CMP AL,12
    JE WIN2
    
    MOV CX,9
    MOV DI,0
    CHECKIFFDRAW:
    CMP MARKARRAY[DI],0
    JE EXX
    INC DI
    LOOP CHECKIFFDRAW
    MOV WINNER,3
   
    
    
    JMP EXX
    WIN1:
    MOV WINNER,1
    JMP EXX
    WIN2:
    MOV WINNER,2
    
    EXX:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CHECKER ENDP
        
        
CIRCLEDRAW PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    INC TURN
    MOV X_VALUE,26
    MOV Y_VALUE,0
    CALL CIRCLE
    
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET 
CIRCLEDRAW ENDP    
        

DIAGFIRST PROC NEAR
    MOV AH, 0CH
    MOV AL, 1
    MOV BX,CX
    ADD BX,40
    L5:                                                   
        INT 10h
        INC CX
        INC DX
        CMP CX, BX
        JLE L5
        
        RET
DIAGFIRST ENDP

DIAGSECOND PROC NEAR
    MOV AH, 0CH
    MOV AL, 1
    MOV BX,DX
    ADD BX,40
    L6:                                                   
        INT 10h
        DEC CX
        INC DX
        CMP DX, BX
        JLE L6
        
        RET
        DIAGSECOND ENDP
        

    
    
        
        
CIRCLE PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
     
   

START:
 
 MOV AH, 0CH
 MOV AL, 1
    
 MOV BX,X_VALUE
 SUB CHOICE,BX
  
 MOV AH,0CH

 DRAWCIRCLE:
  
 MOV AH,0CH
 

 MOV CX,X_VALUE 
 ADD CX,X_CENTER ;  (XV+X,YV+Y)
 MOV DX,Y_VALUE
 ADD DX,Y_CENTER
 INT 10H

 MOV CX,X_VALUE
 NEG CX
 ADD CX,X_CENTER ; (-XV+X,YV+Y)
 INT 10H

 MOV CX,Y_VALUE  
 ADD CX,X_CENTER ; (YV+X,XV+Y)
 MOV DX,X_VALUE
 ADD DX,Y_CENTER
 INT 10H

 MOV CX,Y_VALUE  
 NEG CX
 ADD CX,X_CENTER ; (-YV+X,XV+Y)
 INT 10H

 MOV CX,X_VALUE  
 ADD CX,X_CENTER ; (XV+X,-YV+Y)
 MOV DX,Y_VALUE
 NEG DX
 ADD DX,Y_CENTER
 INT 10H

 MOV CX,X_VALUE
 NEG CX
 ADD CX,X_CENTER ; (-XV+X,-YV+Y)
 INT 10H

 MOV CX,Y_VALUE
 ADD CX,X_CENTER ; (YV+X,-XV+Y)
 MOV DX,X_VALUE
 NEG DX
 ADD DX,Y_CENTER
 INT 10H

 MOV CX,Y_VALUE
 NEG CX
 ADD CX,X_CENTER ; (-YV+X,-XV+Y)
 INT 10H

 INC Y_VALUE

 COND1:
 CMP CHOICE,0
 JG COND2
 MOV CX,Y_VALUE
 ADD CX,2
 ADD CHOICE,CX
 MOV BX,Y_VALUE
 MOV DX,X_VALUE
 CMP BX,DX
 JG ENDPROGG
 JMP DRAWCIRCLE
 
  

 COND2:
 DEC X_VALUE
 MOV CX,Y_VALUE
 SUB CX,X_VALUE
 INC CX
 ADD CHOICE,CX
 MOV DX,X_VALUE
 MOV BX,Y_VALUE
 CMP BX,DX
 JG ENDPROGG
 JMP DRAWCIRCLE
 
        
        
        
 ENDPROGG:      
             
 POP DX
 POP CX
 POP BX
 POP AX
    
 RET 
 CIRCLE ENDP   
        
 END MAIN
