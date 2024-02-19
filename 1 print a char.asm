;Program to input a character from user and print it

;tiny, small, medium, compact, large, huge
.model small ;code <= 64KB & Data <= 64KB ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h  ;it's a directive or command that reserves 100h bytes for stack
             ;stack segment directory <-- Specifies the storage for stack
.data        ;data segment directory  <-- variables are defined here
.code        ;code segment directory 

main proc
    
    mov dl, 'A'
    
    ;output a single char
    mov ah, 2 ;must give the ah (ax, al will not work)
    int 21h
    
    ;to execute from ah register
    mov ah, 4ch
    int 21h
    
main endp 
end main
