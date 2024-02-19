;1. Draw the following pattern (N.B. the length of the pyramid can be changed)

.model small
.stack 100h
.data   

     ;endl dw 10, 13, '$'
     
.code

main proc
     
        ;mov bx, @data
        ;mov ds, bx     ;initialize heap memory
        
        mov bx, 1
        mov cx, 4 ;0 assign thai will make infinite loop 
        
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
