;Program to input two numbers and add them

.model small ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h  ;stack segment directory <-- Specifies the storage for stack
.data        ;data segment directory  <-- variables are defined here
.code        ;code segment directory 

main proc
    ;input a single char
    mov ah, 1 ;mov ah, '1'
    int 21h
    
    mov cl, al
    
    ;input a sigle char
    mov ah, 1
    int 21h
    
    add cl, al
    sub cl, 48 ;to maintain ASCII value
    
    mov dl, cl 
    ;output a single char
    mov ah, 2
    int 21h
    
    ;to execute from ah register
    mov ah, 4ch
    int 21h
    
main endp 
end main