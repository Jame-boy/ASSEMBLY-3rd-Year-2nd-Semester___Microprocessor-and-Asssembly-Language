.MODEL SMALL
 .STACK 100H

 .DATA
    PROMPT  DB  'print 12345 four times $\'  
    D DB 10,13,"$"
    M DB 10,13,"$"

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS 
     MOV DS, AX

     LEA DX, PROMPT               ; load and print PROMPT 
     MOV AH, 9
     INT 21H
     MOV BL,4  
     
     CHECK:
     LEA DX,D
     MOV AH,9
     INT 21H
     
     MOV CX,5                     ;initialize CX
     
     MOV AH,2
     MOV DL,49
     

     @LOOP:                       ; loop label
       INT 21H                    ; print character

       INC DL                     ; increment DL to next ASCII character
       DEC CX                     ; decrement CX
     JNZ @LOOP  
     
     DEC BL
     JNZ CHECK                  ; jump to label @LOOP if CX is 0

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP
 END MAIN
