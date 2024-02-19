;program to Reverse an input string.

.model small
.stack 100h
.data
.code

main proc
   
        ;put ASCII 13 to mark end of string
        mov ax, 13
        push ax
    
INPUT:
    
        mov ah, 1
        int 21h
        
        cmp al, 13 ;13 is ASCII of Enter key
        je reversePrint
        push ax
    
jmp INPUT ;unconditional jump   
    
    
    
reversePrint:
           
       print:
           
            pop dx
            
            cmp dx, 13 ;end of string
            je endPrint
            
            mov ah, 2 ;single char print tai vul astese na ; ekhane bug ase
            int 21h
            
       jmp print ;unconditional jump       
    
    
endPrint:
     
       mov ah, 4ch
       int 21h
       
            
main endp

end main