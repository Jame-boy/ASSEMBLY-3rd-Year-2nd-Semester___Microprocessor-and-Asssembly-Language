;Program to convert capital letter to small letter

.model small ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h  ;stack segment directory <-- Specifies the storage for stack
.data        ;data segment directory  <-- variables are defined here
.code        ;code segment directory 

main proc
    ;input a single char
    mov ah, 1
    int 21h
      
    ;This is also right
    ;mov dx, ax
    ;add dx, 32 
    
    mov dl, al
    add dl, 32 ;for convert to small  
    
    ;This is wrong
    ;mov dh, ah
    ;add dh, 32  
    
    
    ;output a single char
    mov ah, 2
    int 21h
    
    ;to execute from ah register
    mov ah, 4ch
    int 21h
    
main endp 
end main