;6. Write a assembly code to perform the following:
;Put the sum 1+4+7+....+148 in AX

.model small
.stack 100h
.data  
    
    base    dw 10
    endl    dw 13, 10, 13, 10, 'The result of $'
    counter dw 0
    sum     dw 0
    
.code

main proc
        
        mov ax, @data
        mov ds, ax
        
        mov bx, 1
        mov ax, 0
repet:
        
        cmp bx, 148
        jg Display16bitsNumber
        
        add ax, bx
        add bx, 3
jmp repet ;unconditional jump
        
        
main endp


;***************************************** PROCEDURE *****************************************
;*****************************************           *****************************************

;Printing 16 bit number using stack in 8086 Assembly language  
Display16bitsNumber proc
                            ;ax = dividend law
       ;mov ax, inputNum    ;unsigned 0 to 2^16-1 (0 to 65535)
                            ;signed -32768 to +32767
       
       mov sum, ax                      
       ;print the endl
       mov dx, offset endl
       mov ah, 9
       int 21h
       
                         
       mov ax, sum
       
       cmp ax, 0            ;ax < 0
       jge repeat           ;if ax >= 0 ;for jg 0 result will -0 that is not right ans

       
       ;if negative
       push ax              ;mov ah, 02h e value change hoye jabe
       mov dl, '-'
       mov ah, 02h
       int 21h
       
       pop ax
       neg ax               ;again 2's compliment so that we can get the proper value
       
repeat:  
       mov dx, 0            ; dx = dividend high (To avoid divide overflow error)
       div base             ; ax = Quotient, dx = remainder
       push dx              ; push e always 16 bit dite hoy
       inc [counter]        ; number of digit count
       cmp ax, 0
jne repeat 
       
      
       mov cx, [counter]
       mov ah, 02h
again:
       pop dx
       add dx, 30h          ;30h = 48;integer to ASCII; character
       int 21h
loop again
       
Display16bitsNumber endp

       ;for successfully return
       mov ah, 4ch
       int 21h                                       
end main