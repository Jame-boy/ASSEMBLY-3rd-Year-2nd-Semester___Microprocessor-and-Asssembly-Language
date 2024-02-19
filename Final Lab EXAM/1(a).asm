.model small
.stack 100h
.data
.code

main proc
        
        ;take a char in al
        mov ah, 1
        int 21h            
        
        cmp al, 'Z'
        jle PRINT
        
        ;exit from code
        mov ah, 4ch
        int 21h
        
        PRINT:
        mov dl, al
        mov ah, 2
        int 21h
        
        ;exit
        mov ah, 4ch
        int 21h
        
main endp
end main