;tiny, small, medium, compact, large, huge
.model small ;code <= 64KB & Data <= 64KB ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h  ;it's a directive or command that reserves 100h bytes for stack
             ;stack segment directory <-- Specifies the storage for stack
.data        ;data segment directory  <-- variables are defined here 

     msg  db 13, 10, 'Enter a 2-digit number $'
     sum  dw 0
     cnt  dw 3 
     
     endl    dw 13, 10, 13, 10, 'The sum is .... $'
     counter dw 0
     base    dw 10
     
.code
main proc
        
        mov ax, @data
        mov ds, ax
        
takingInput:        
     
        add sum, bx
        dec cnt  
        cmp cnt, 0         
jnz input2DigitNumber                        
       
       call Display16bitsNumber
        
main endp

;***************************************** PROCEDURE *****************************************
;*****************************************           *****************************************

input2DigitNumber proc
        
        ;print the message
        lea dx, msg
        mov ah, 09h
        int 21h
        
        mov bx, 0
        
        ;taking the first digit
        mov ah, 01h
        int 21h  
        sub al, 30h ; 30h = 48 ;ASCII to integer
        mov bh, al ; bx = bh bl 
                         
        ;taking the second digit
        mov ah, 01h
        int 21h
        sub al, 30h
                          
                          
        mov ch, al ; store the second digit
        mov al, bh ;for multi
        mov bl, 10 ;bx = bh bl
                        ;5  10
        mul bl    ;8 bits multiplication
                  ;ax = al * 8-bits reg
        
        add al, ch ;al containx num * 10 
                    ;al = al + ch
                     ;  = 50 + 2
                      ; = 52
                      
        mov bx, ax 
jmp takingInput      
                  
input2DigitNumber endp 
 
                      
;https://www.youtube.com/watch?v=6nTpsaZ-uf0
;Printing 16 bit number using stack in 8086 Assembly language  
Display16bitsNumber proc
                            ;ax = dividend law
       ;mov ax, inputNum    ;unsigned 0 to 2^16-1 (0 to 65535)
                            ;signed -32768 to +32767   
       ;print a new line
       mov dx, offset endl
       mov ah, 9
       int 21h
       
                         
       mov ax, sum
       
       cmp ax, 0            ;ax < 0
       jge repeat           ;if ax >= 0 ;for jg 0 result will -0 that is not right ans

       
       ;if negative
       push ax              ;mov ah, 02h e value change hoye jabe
       mov dl, '-'
       mov ah, 02h
       int 21h
       
       pop ax
       neg ax               ;again 2's compliment so that we can get the proper value
       
repeat:  
       ;cwd
       mov dx, 0            ; dx = dividend high (To avoid divide overflow error)
       div base             ; ax = Quotient, dx = remainder
       push dx              ; push e always 16 bit dite hoy
       inc [counter]        ;number of digit count
       cmp ax, 0
jne repeat 
       
      
       mov cx, [counter]
       mov ah, 02h
again:
       pop dx
       add dx, 30h          ;30h = 48;integer to ASCII; character
       int 21h
loop again

       
       
Display16bitsNumber endp

       ;for successfully return
       mov ah, 4ch
       int 21h                      
                      
                      
end main