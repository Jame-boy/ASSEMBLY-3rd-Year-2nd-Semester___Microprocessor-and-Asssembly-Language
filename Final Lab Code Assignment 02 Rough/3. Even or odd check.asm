;3. Even or odd check

;div (8-bit register)
;ax = ax / 8-bit register
;al = quotient, ah = remainder


.model small
;.stack 100h
.data   
    
     evn dw 10, 13, 'Given number is EVEN$' ;10, 13 for new line + carriage return
     odd  dw 10, 13, 'Given number is ODD$'
     
.code

main proc
       
    mov bx, @data
    mov ds, bx 
    
    
INPUT:
     mov ah, 1
     int 21h
     
     cmp al, 13 ;13 is ASCII of enter key 
     je chkEvenOdd                        
     
     mov cl, al ;or mov cx, ax --- for store the last digit
     
jmp INPUT


chkEvenOdd: 
          ;mov ah, 0 eta ekhane na dileo hobe bcz ax( 130 = 304d )
          
          mov al, cl ;or mov ax, cx
          mov bl, 2
          div bl
          
          cmp ah, 0
          je IsEVEN 
          
          ;print the odd message
          lea dx, odd
          mov ah, 9
          int 21h  
          
          ;for successfully terminate
          mov ah, 4ch
          int 21h
          
IsEVEN:
     
    ;print the even message 
    lea dx, evn
    mov ah, 9
    int 21h
    
    ;for successfully terminate
    mov ah, 4ch
    int 21h
    

main endp
end main

