;4. Whether a input number is prime or not/ Prime check

.model small
.stack 100h
.data  
    
    prm  dw 10, 13, 'PRIME$'        ;10, 13 for new line + carriage return
    nprm dw 10, 13, 'NOT PRIME$'    
    
.code
main proc 
	 
	mov bx, @data
    mov ds, bx     ;initialize heap memory
        
	;here we can input 2^8 - 1 = 255 (maximum)
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
       sub al, 30h ;zero ASCII 48d = 30h
       
       mov cl, al ;store the al value bcz after mul it will be corrupted
       mov al, bh 
       
       mul bl     ;8 bits multiplication
                  ;ax = al * 8-bits reg
       add al, cl               
       mov bh, al
       
       JMP INPUT
       
	EXIT:
	
	  
	  cmp bh, 1
      jle notPRIME
      
      mov cx, 0  ;reset
      mov cl, bh     
      
      isPRIME:
             
             ;prepare for div operation
             mov ax, 0 ;reset
             mov al, bh
             
             dec cl    ;we will check value till n-1
             cmp cl, 3
             jle PRIME
             
             div cl     ;div (8-bit register)
                        ;ax = ax / 8-bit register
                        ;al = quotient, ah = remainder
             cmp ah, 0
             je notPRIME
             jmp isPRIME ;unconditional jump


PRIME:
     
     ;print the string 
     lea dx, prm
     mov ah, 9
     int 21h
     
     ;for successfully return
     mov ah, 4ch
     int 21h
     
        
notPRIME:
     
     ;print the string
     lea dx, nprm
     mov ah, 9
     int 21h
     
     ;for successsfully return
     mov ah, 4ch
     int 21h
         
main endp
end main