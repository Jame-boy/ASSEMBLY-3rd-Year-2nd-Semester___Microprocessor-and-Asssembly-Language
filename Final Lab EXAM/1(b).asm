
.model small
.stack 100h
.data 
    
    msg1 dw 'The result FFh $'
    msg2 dw 'The result is 0 $ '
    
.code

main proc 
    
    mov bx, @data
    mov ds, bx  
    
        
        ;take a char in al
        mov ah, 1
        int 21h
        
        mov bl, al
        
        INPUT:
        mov ah, 1
        int 21h
        
        cmp al, 13
        je EXIT
        jmp INPUT             
        
        
        EXIT:
        cmp bl, '-'
        je PUT
        jmp LAST
        
        
        PUT:
        mov dx, offset msg1
        mov ah, 9h
        int 21h 
        
        mov ah, 255
        
        
        
        jmp DONE
        
        LAST:       
        mov dx, offset msg2
        mov ah, 9h
        int 21h
        
        mov ah, 0
        
        DONE:
        
main endp
end main