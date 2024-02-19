;program to subtract two numbers

.model small ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h  ;stack segment directory <-- Specifies the storage for stack
.data        ;data segment directory  <-- variables are defined here
.code        ;code segment directory 

main proc
    
    mov bl, 3
    mov cl, 1
    
    sub bl, cl  
    add bl, 48 ;to maintain ASCII value   
    
;    sub cl, bl
;    add cl, 48
    
    mov dl, bl
    ;mov dl, cl
    ;output a single char
    mov ah, 2
    int 21h
    
    ;to execute from ah register
    mov ah, 4ch
    int 21h
    
main endp 
end main