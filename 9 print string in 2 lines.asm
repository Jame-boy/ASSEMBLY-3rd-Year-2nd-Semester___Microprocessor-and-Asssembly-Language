;program to print two different string on two differentt lines

.model small
 .stack 100h
 
 .data  
 msg1 db 'hello$'
 msg2 db 'world$'
 
 .code
 main proc  
    ;for access data directly
    mov cx, @data
    mov ds, cx
    
    mov dx, offset msg1
    ;lea dx, msg1
    mov ah, 9 ;for print a string
    int 21h
    
    ;22 - 28 line for print a new line
    mov dx, 10
    mov ah, 2
    int 21h
    
    mov dx, 13
    mov ah, 2
    int 21h                           
    
    ;mov dx, offset msg2 
    lea dx, msg2
    mov ah, 9 ;for print a string
    int 21h
    
    
    ;for return from ah register
    mov ah, 4ch
    int 21h
    
    
 main endp
 end main
    