;program to add two number

.model small ;model directory         <-- Specifies the total amount of memory the program would take
.stack 100h  ;stack segment directory <-- Specifies the storage for stack
.data        ;data segment directory  <-- variables are defined here
.code        ;code segment directory 

main proc
    ;give one value
    mov bl, 1
    ;mov cl, 2
    mov bh, 2  
    
    ;add bl, 48
;    mov dh, bl
;    mov ah, 2
;    int 21h
    
    ;add bl, cl 
    add bl, bh
    add bl, 48 ;immediate addressing mode +48 for maintain ASCII value
    
    mov dl, bl
    
    ;output a single char
    mov ah, 2
    int 21h
    
    ;to execute from ah register
    mov ah, 4ch
    int 21h
    
main endp 
end main