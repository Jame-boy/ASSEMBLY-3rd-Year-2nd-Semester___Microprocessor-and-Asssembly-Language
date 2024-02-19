;7. Write instructions (not a complete program) to do the following. 

;a. Read a character, and display it at the next position on the same line

.model small
.stack 100h  
.data 
    
    msg1  dw  ' Enter a character .... $'
         
.code        

main proc
    mov ax, @data
    mov ds, ax
    
    ;print msg1
    mov dx, offset msg1
    mov ah, 9
    int 21h 
    
    ;input a character
    mov ah, 01h
    int 21h
    
    ;output a single char
    mov dl, al
    mov ah, 2 ;must give the ah (ax, al will not work)
    int 21h
    
    ;to execute from ah register
    mov ah, 4ch
    int 21h
    
main endp 
end main
