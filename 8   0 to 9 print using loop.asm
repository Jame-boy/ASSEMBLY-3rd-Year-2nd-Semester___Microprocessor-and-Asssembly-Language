.model small
.stack 100h
.data
.code

main proc
    mov cx, 10
               
    mov dx, 48 
iteration:
  
    mov ah, 2
    int 21h  
    
    ;add dx, 1 
    inc dx
    
loop iteration
    
    mov ah, 4ch
    int 21h
main endp
end main
