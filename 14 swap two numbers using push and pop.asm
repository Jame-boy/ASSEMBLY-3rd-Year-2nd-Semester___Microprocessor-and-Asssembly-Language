;swap two numbers using push and pop
.model medium
.stack 100h
.data
.code

main proc
    
    mov ax, '1'
    mov bx, '2'
    
    push ax;copies 1 to stack
    push bx;copies 2 to stack
    
    pop ax ;moves 2 from stack to ax
    pop bx ;moves 1 from stack to bx
    
    mov dx, ax
    mov ah, 2
    int 21h
    
    mov dx, bx
    mov ah, 2
    int 21h
    
    mov ah, 4ch
    int 21h
    
main endp
end main