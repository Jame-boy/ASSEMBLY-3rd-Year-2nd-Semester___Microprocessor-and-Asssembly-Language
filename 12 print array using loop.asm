;program to print an arry using loop
.model small
.stack 100h
.data
  
  array db 'a', 'b', 'c'
  ;array db 1, 2, 3, 4
  
.code
main proc
    
    mov bx, @data ; mov anyReg, @data
    mov ds, bx
    
    ;mov si, offset array
    lea si, array  
    mov cx, 3
    
    for:
    mov dx, [si] ;but dx = 16 bits [si] = 8 bits???? ;mov dl, [si] dileo kaz hbe 
    
    mov ah, 2
    int 21h
    
    add si, 1
    ;inc si
    loop for  
    
    
    ;for return from ah register
    mov ah, 4ch
    int 21h
      
main endp
end main