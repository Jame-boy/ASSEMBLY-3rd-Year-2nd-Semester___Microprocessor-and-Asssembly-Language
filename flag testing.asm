.model small
.stack 100h
.data

  base dw 10
  counter dw 0
  sum  dw 0
  
.code
     
flag proc
        mov ax, @data
        mov ds, ax 
       
       ;mov cx, 0 
       ;mov cx, 33239 ;81D7
       ;add cx, 41861 ;A385 
       
       mov cx, 0
       mov cx, 8321
       add cx, 130
       
       ;cmp cx, 1
       ;je ed
       ;ed:  
       call Display16bitsNumber
       
     
flag endp 

;Printing 16 bit number using stack in 8086 Assembly language  
Display16bitsNumber proc
       
       ;mov cx, 0                      
       ;mov ax, sum    
       mov ax, cx
       
repeat:  
       mov dx, 0            ; dx = dividend high (To avoid divide overflow error)
       div base             ; ax = Quotient, dx = remainder
       push dx              ; push e always 16 bit dite hoy
       inc [counter]        ;number of digit count
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


end flag