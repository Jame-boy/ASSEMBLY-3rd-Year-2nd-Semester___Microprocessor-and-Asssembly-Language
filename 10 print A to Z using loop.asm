.model small
.stack 100h
.data
.code
main proc
    
    mov cx, 26 ;mov ch or cl 26 dile infinite loop hoy
    mov dx, 65
    
    iteration:    
             
              mov ah, 2
              int 21h  
              
              mov bx, dx
              
              ;print new line
              mov dx, 10
              mov ah, 2
              int 21h
              
              mov dx, 13
              mov ah, 2
              int 21h
              
              mov dx, bx
              inc dx
    
    loop iteration 
    
    mov ah, 4ch
    int 21h
main endp
end main