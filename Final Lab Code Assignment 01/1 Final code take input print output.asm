; 1. A Simple assembly code to take a input (a number/character/string) from keyboard and print the input.

.model small              ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h               ;stack segment directory <-- Specifies the storage for stack
.data                     ;data segment directory  <-- variables are defined here

string db 100 dup('$')                      
msg1   db 'Give the input String $'
msg    db 'The input String is..........  $'

.code                     ;code segment directory
main proc 
    
    mov bx, @data
    mov ds, bx            ;initialize heap memory   
    ;or .startup  it will load the data into DS memory
    
    ;print the msg1
    mov dx, offset msg1
    mov ah, 9
    int 21h
    
    lea si, string        ;same as -> mov si, offset string
    
input:
    mov ah, 1
    int 21h 
    cmp al, 13            ;13 is the ASCII value of enter key  
    
    je Display            ;conditional jump
    mov [si], al
    add si, 1             ;same as -> inc si 
jmp input                 ;unconditional jump    
     
    
Display:    
   mov dx, offset msg
   mov ah, 9
   int 21h
    
   ;print the string 
   mov dx, offset string
   mov ah, 9
   int 21h
        
   ;return from ah register
   mov ah, 4ch
   int 21h
    
main endp
end main