.model small
.stack 100h
.data  

    cnt  db ?
    temp db ?
    
.code
main proc
    
    mov ax,@data
    mov ds,ax   ;load data segment
    
    mov bx,1 ;for space
    mov cx,0 ;reset   
    
    
    ;taking input
    mov ah, 1
    int 21h
    mov cl, al 
    
    sub cx ,30h ;Ascii of zero is 48 = 40h
    sub al,30h  
    
    ;input * 2 - 1
    mov bh,0
    mov ah,0
    mov bl,2
    mul bl  ;ax = al * 8bit register
    dec ax
    mov cnt,al ;store the limit value in cnt
    

    ;for new line
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
      mov bx,1   ;for controlling space
OUTER:
      push cx
      mov cx,bx
    
;for space
INNER1:
    
      mov dx,' '
      mov ah,2
      int 21h
loop INNER1
    
     
          
          
      mov cl,cnt ;for looping
      mov temp,1 ;for print from 1
  
INNER2:  
      
      ;for print the temp value
      mov dl,temp
      add dl,30h ;ascii of 0 
      
      mov ah,2
      int 21h 
      
      ;for print space 
      mov dx,' '
      mov ah,2
      int 21h
      
      inc [temp] ;for print the next integer
loop INNER2 
    
    
    
    ;for printing new line  
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    
    
    
    sub [cnt], 2 ;this is limit value
    add bx, 2    ;for controlling space
    
    
    pop cx
loop OUTER
    

    
    ;for successfully exit
    mov ah, 4ch
    int 21h 
    
main endp
end main