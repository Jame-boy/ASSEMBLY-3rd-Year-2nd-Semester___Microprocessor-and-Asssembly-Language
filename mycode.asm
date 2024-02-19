.model small
.stack 100h
.data
var1 db '1'
var2 db ?
var3 db '1234$'

.code
main proc
    
    mov ax, @data ;It moves the memory locattion of @Data into the ax register(16 bits register)
    mov ds, ax ;Moves data address to ds so that data segment gets initialized as heap memory to access variables fast  
  
    
    
    mov dl, var1 ;dx will not work because var1 8 bits 
    
    mov ah, 2
    int 21h
    
    mov var2, bl  ;here bl valu contains nothins so var2 is also nothigs holds
    mov dl, var2
    mov ah, 2
    int 21h
    
    
    ;for print the string
    ;mod, dx, offset var3 ;holds the beginning address of variable as 16 bits ;offset address is 16 bits so dx
    lea dx, var3;same as line 23  
    mov ah, 9
    int 21h       
    
    mov ah, 4ch
    int 21h
    
main endp
end main     