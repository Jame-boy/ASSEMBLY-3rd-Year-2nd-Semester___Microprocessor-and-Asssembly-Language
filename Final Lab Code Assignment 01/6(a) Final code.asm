; 6. Using only MOV, ADD, SUB, INC, DEC, and NEG, translate the
;following high-level language assignment statements Into assembly language. 
;A, B, and C are word variables.
 
;a. A = B - A

;Assuming A and B are 2 Digit Numbers

.model small              ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h               ;stack segment directory <-- Specifies the storage for stack
.data                     ;data segment directory  <-- variables are defined here 

     A       dw 0
     B       dw 0
     cnt     dw 3
     msg1    dw 'Enter A ( 2 Digit ).... $'
     msg2    dw 13, 10, 'Enter B ( 2 Digit ).... $'  
     
     endl    dw 13, 10, 13, 10, 'The result of A = B - A is .... $'
     counter dw 0
     base    dw 10
     
.code                     ;code segment directory
main proc
        
        mov ax, @data
        mov ds, ax
        
        ;print the msg1
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        
        
        mov cx, 0         ;so that cx contain a proper value
takingInput:        
        
        cmp cnt, 1
        je negative
        
        add A, cx
        dec cnt  
        cmp cnt, 0         
jnz input2DigitNumber                        
        
        negative:
              sub cx, A  ;cx = B, sum = A so B = B - A
              mov A, cx  ;bcz in display cx will override
              
        call Display16bitsNumber
        
main endp

;***************************************** PROCEDURE *****************************************
;*****************************************           *****************************************

input2DigitNumber proc
      
        ;taking the first digit
        mov ah, 01h
        int 21h  
        sub al, 30h      ; 30h = 48 ;ASCII to integer
        mov bh, al       ; bx = bh bl 
                         
        ;taking the second digit
        mov ah, 01h
        int 21h
        sub al, 30h
                          
                          
        mov ch, al       ;store the second digit
        mov al, bh       ;for multi
        mov bl, 10       ;bx = bh bl
                            ;= 05 10
        mul bl           ;8 bits multiplication
                         ;ax = al * 8-bits reg
        
        add al, ch       ;al containx num * 10 
                         ;al = al + ch
                         ;   = 50 + 2
                         ;   = 52
        
        mov cx, ax       
        ;print the msg2
        mov dx, offset msg2
        mov ah, 09h
        int 21h
        
jmp takingInput      
                  
input2DigitNumber endp 
 

;Printing 16 bit number using stack in 8086 Assembly language  
Display16bitsNumber proc
                             
       ;print the endl
       mov dx, offset endl
       mov ah, 9
       int 21h
       
                         
       mov ax, A
       
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