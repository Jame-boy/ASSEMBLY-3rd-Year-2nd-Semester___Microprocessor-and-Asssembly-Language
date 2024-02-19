.model small
.stack 100h
.data
.code
main proc
    
    mov ah, 1
    int 21h
    
    mov bx, ax  
    mov dx, bx
    mov ah, 2
    int 21h
    
    mov ah, 1
    int 21h
    
    mov bh, al 
    add bl, bh
    sub bl, 48
    
    mov dx, bx
    
    mov ah, 2
    int 21h
main endp
end main