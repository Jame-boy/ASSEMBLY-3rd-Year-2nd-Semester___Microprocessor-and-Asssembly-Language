;2. Using only MOV, ADD, SUB, INC, DEC and NEG translate the
;following high level language assignment statements into assembly
;language. A, B and C are word variables. 

;    i. A=B-A
;   ii. A= - (A+1)
;  iii. C=A+B
;   iv. B=3*B+7
;    v. A=B-A-1


;Assuming A and B are 2 Digit Numbers

.model small              ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h               ;stack segment directory <-- Specifies the storage for stack
.data                     ;data segment directory  <-- variables are defined here 

     A         db 0
     B         db 0
     opsn      db 0 
     finalRslt db 0
     
     cnt     dw 3
     msg1    dw 'Enter the value of A and B = $' 
     msg2    dw 13, 10, 13, 10, 'Choose option (problem number): $'
     
     endl    dw 13, 10, 13, 10, ' The result of $'
     end2    dw ' no. problem is = $'
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
        
        ;for input A
        call inputNumber
        mov A, bh
        
        ;for input B
        call inputNumber
        mov B, bh
        
        
        ;for print msg2
        mov dx, offset msg2
        mov ah, 9h
        int 21h
        
        ;taking the option number 
        mov ah, 01h
        int 21h     
        mov opsn, al ;store the value
        sub al, 48 
        
        
;*****************************************   OPTION  *****************************************
;*****************************************           *****************************************  
        cmp al, 5
        je  case5
        
        cmp al, 4
        je  case4
        
        cmp al, 3
        je  case3 
        
        cmp al, 2
        je  case2
        
        case1: 
        ; i. A=B-A
             
             mov ax, 0 ;reset
             mov al, B
             sub al, A
             
             mov finalRslt, al      
        call Display16bitsNumber
        
        case2:
        ;   ii. A= - (A+1)
             
             mov ax, 0 ;reset
             mov al, A
             inc al
             neg al
             
             mov finalRslt, al
        call Display16bitsNumber
            
        case3:
        ;  iii. C=A+B
             
             mov ax, 0 ;reset
             mov al, A
             add al, B
             
             mov finalRslt, al     
        call Display16bitsNumber
        
        case4:
        ;   iv. B=3*B+7
         
            mov ax, 0 ;reset
            mov al, B
            add al, B
            add al, B
            add al, 7
            
            mov finalRslt, al
        call Display16bitsNumber
        
        case5:
        ;    v. A=B-A-1
        
             mov ax, 0 ;reset
             mov al, B
             sub al, A
             sub al, 1
             
             mov finalRslt, al
        call Display16bitsNumber 
        
        
main endp

;***************************************** PROCEDURE *****************************************
;*****************************************           *****************************************

inputNumber proc
      
    ;here we can input 2^8 - 1 = 255 maximum 
    ;program will work -128 to +127 bcz we use sign mul & div here
	;input number will store in bh register
	mov bh, 0
	mov bl, 10d
       
    
       INPUT: 
       
       ;for input a single character
       mov ah, 1
       int 21h
       
       cmp al, 13d ;13d is the ASCII of enter key
       jne NUMBER 
       
       jmp EXIT
       
       
       NUMBER:
       SUB AL,30H ;zero ASCII 48d = 30h
       
       mov cl, al ;store the al value bcz after mul it will be corrupted
       mov al, bh 
       
       mul bl     ;8 bits multiplication
                  ;ax = al * 8-bits reg
       add al, cl               
       mov bh, al
       
       JMP INPUT
       
	EXIT: ret
                  
inputNumber endp 
 

;Printing 16 bit number using stack in 8086 Assembly language  
Display16bitsNumber proc
                             
       ;print the endl
       mov dx, offset endl
       mov ah, 9
       int 21h
       
       ;print the option number
       mov dl, opsn
       mov ah, 02h
       int 21h
       
       ;print the msg2
       mov dx, offset end2
       mov ah, 9
       int 21h
       
       
       mov ax, 0 ;reset                  
       mov al, finalRslt ;A is 8 bits and we
       
       ;here we work with 8 bits thats why ax will not allow
       cmp al, 0            ;al < 0
       jge repeat           ;if al >= 0 ;for jg 0 result will -0 that is not right ans

       
       ;if negative
       push ax              ;mov ah, 02h e value change hoye jabe
       mov dl, '-'
       mov ah, 02h
       int 21h
       
       pop ax
       neg al               ;again 2's compliment so that we can get the proper value
       
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