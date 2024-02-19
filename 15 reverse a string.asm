;program to reverse a string

.model small
.stack 100
.data   

string db 'Ali$'

.code
main proc 
    
    mov ax, @data
    mov ds, ax  
    
    mov si, offset string
    mov cx, 3
    
lp1:
    mov bx, [si]
    push bx
    inc si
loop lp1
 
    
    mov cx, 3;loop will work 3 times
lp2:        
    pop dx
    
    mov ah, 2
    int 21h 
    
    ;print new line
    mov dx, 10
    mov ah, 2
    int 21h
    
    mov dx, 13
    mov ah, 2
    int 21h
    
loop lp2 
     
     mov ah, 4ch
     int 21h   
     
main endp
end main