;4. Whether a input number is prime or not Prime check  

;div (8-bit register)
;ax = ax / 8-bit register
;al = quotient, ah = remainder

.model small
.stack 100h
.data
    
    prm  dw 10, 13, 'PRIME$'        ;10, 13 for new line + carriage return
    nprm dw 10, 13, 'NOT PRIME$'
    
.code
main proc  
       
       mov bx, @data
       mov ds, bx     ;initialize heap memory
       
    
       mov ah, 1   ;we should remove this 1 when mov bl, 2 will occur
       int 21h
       
       ;sub al, 48 ;form keyboard there contains ASCII value
       
       cmp al, '1' ;this is bug ---- cmp al, 1
       jle notPRIME
       
       cmp al, '3'
       jle PRIME
       
       mov ah, 0 ;this is very inportant
       mov dx, ax; sotre the ax value
       ;sub al, 48 ;from keyboard there contains ASCII vlue
       mov cx, ax
       sub cx, 2 
       sub cx, 30h ;48 is ASCII of zero 48 = 30h (h na dile hobe na)
              
       mov bl, 2  
       
chkPrime:    
        
        div bl 
       
        cmp ah, 0
        je notPrime   
        
        inc bl
        mov ax, dx

loop chkPrime  
    

PRIME:
      
     lea dx, prm
     mov ah, 9
     int 21h
     
     ;for successfully return
     mov ah, 4ch
     int 21h
     
        
notPRIME:
     
     lea dx, nprm
     mov ah, 9
     int 21h
     
     ;for successsfully return
     mov ah, 4ch
     int 21h
        
main endp 

end main