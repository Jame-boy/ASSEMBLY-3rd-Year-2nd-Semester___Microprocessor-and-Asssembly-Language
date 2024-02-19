;Program to input a character from user and print it

.model small ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h  ;stack segment directory <-- Specifies the storage for stack
.data        ;data segment directory  <-- variables are defined here
.code        ;code segment directory 

main proc
    
 
    mov dl, 'A'
    ;output a single char
    mov ah, 2
    int 21h
    
    mov dl, 'l'
    ;output a single char
    mov ah, 2
    int 21h
    
    mov dl, 'i'
    ;output a single char
    mov ah, 2
    int 21h
    
    ;to exit from ah register or to command consol window back
    mov ah, 4ch
    int 21h
    
main endp 
end main