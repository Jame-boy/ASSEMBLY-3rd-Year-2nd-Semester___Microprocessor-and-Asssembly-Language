;1. Draw the following pattern (N.B. the length of the pyramid can be changed)

.model small
.stack 100h
.data        
.code

main proc
         
        
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
	
        mov cx, 0 ;reset
        mov cl, bh 
        
        mov bx, 0 ;reset
        mov bx, 1
        
outerLoop:    
        
        push cx ;store the counter value   
        
;for print the space
SPACE:    

        mov dx, ' '
        mov ah, 2
        int 21h

loop SPACE         
 
        mov cx, bx   
        
        innerLoop:    
           
                 mov dx, '*'
                 mov ah, 2
                 int 21h
                 
        loop innerLoop
        
        ;for new line
        mov dx, 10
        mov ah, 2
        int 21h
        ;for carriage return
        mov dx, 13
        mov ah, 2
        int 21h
        
        
        add bx, 2
        
        pop cx  ;assign counter of loop again
        
loop outerLoop
        

;for successfully return
mov ah, 4ch
int 21h
    
main endp
end main
