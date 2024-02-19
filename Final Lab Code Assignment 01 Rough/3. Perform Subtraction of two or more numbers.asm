;   Author      : Md Jubayer Hossen Jame
;   Study       : CSE, BRUR
;   Today       : Saturday, 18 December, 2021
;*************************************************************************
;*************************************************************************



;https://www.youtube.com/watch?v=D1bQ0u6WVQQ 
;8 bits input from user in 8086 microprocessor

;Algo
;           result = 0
;           AL = getche()
;           while( AL != 0dh) ; Odh = 13 in decimal
;           AL = AL - 48  
;           result = result * 10 + AL
;           AL = getche()
;           while_end
 
 
 
  
;3. Perform Subtraction of two or more numbers
.model small
.stack 100h
.data
    
    msg1 db 'How many numbers will you input $' 
    result dw 0 ;dw = 8 bits 
    rslt   dw 0
    inputNum dw ?
     
    
    counter dw 0
    base dw 10    
    
    sum dw 0
    
    endl dw 10, 13, 10, 13, 'Final result of the numbers ....... $'
    negative dw 0 ;to check number is negative or not             

.code
addition proc
    
    mov bx, @data
    mov ds, bx
    
    lea dx, msg1
    mov ah, 9
    int 21h  
    
    
    ;input the how many numbers
    call input8bits         ;this a procedure               
    while_end:
    ;mov inputNum, result This is wrong instruction
    mov ax, result
    mov inputNum, ax                        
    
    
add inputNum, 1             ;for dec at first in takeNum
takeNum:
    
       dec inputNum 
       ;mov ax, 0  
       mov ax, rslt 
       cmp negative, 1
       je Here: ;jmp bug silo -_-
       add sum, ax
   ;Here: ;neg ax
       
        
        
       ;add sum, ax 
       ;sub sum, ax
       
     
       cmp inputNum, 0
       ;call takeInputs
jnz takeInputs
     
    ;call er upore Here: ei Lebel dile hbe na
    call Display16bitsNumber 
    
    Here:
          sub sum, ax
          cmp inputNum, 0 
jnz takeInputs            
         
         ;if last input is neg then it will work
         call Display16bitsNumber
      
       
addition endp 
       
       
       
;***************************************** PROCEDURE *****************************************
;*****************************************           *****************************************
      
;procedure ;https://www.youtube.com/watch?v=97oDBapuj1o
input8bits proc   
      
       mov ax, 0
       mov bx, 10           ;we will multiply with 10
       mov cx, 0
       ;mov dx, 0
        
       while: 
             mov ah, 01h
             int 21h        ;al = 32h (suppose)
             cmp al, 0dh                  ;input sotre in al and odh = 13(Ascii of Enter key '\n')
             je while_end
             
            
             mov ah, 0      ;ah = 0       ; bcz ah e 01h chilo
             sub al, 30h    ;al = 2       ;convert ASCII to int;  30h = 48
             mov cx, ax     ;cx = 00 02   ;ax will change after mul or div 
             ;mov dx, ax
             mov ax, bx     ;ax = 00 0A
             mul [result]   ;ax = ax * 0 
                               ;= 10 * 0
                               ;= 0
             add ax, cx     ;ax = ax + cx
                               ;= 0 + 2
                               ;= 2 
             ;add ax, dx
             mov [result], ax;result = 2 
       jmp while            ;Unconditional Program Execution Transfer Instruction
      
       ;while_end:
       ;ret
input8bits endp
                                            
;same as input8bits -_-
takeInputs proc   
      
       mov ax, 0
       mov bx, 10           ;we will multiply with 10
       mov cx, 0
       ;mov dx, 0 
       mov rslt, 0          ;eita bug silo
       
       ;assuming at least one digit will be input 
       mov negative, 0 ; assuming num is positive
       mov ah, 01h
       int 21h
       cmp al, '-' ; - = 170
       je setNeg
       
       call Calculation
       setNeg:
             mov negative, 1
       
       INPUT: 
             mov ah, 01h
             int 21h        ;al = 32h (suppose)
             cmp al, 0dh                  ;input sotre in al and odh = 13(Ascii of Enter key '\n')
             je takeNum
             
            
Calculation: mov ah, 0      ;ah = 0       ; bcz ah e 01h chilo
             sub al, 30h    ;al = 2       ;convert ASCII to int;  30h = 48
             mov cx, ax     ;cx = 00 02   ;ax will change after mul or div 
             ;mov dx, ax
             mov ax, bx     ;ax = 00 0A
             mul [rslt]     ;ax = ax * 0 
                               ;= 10 * 0
                               ;= 0
             add ax, cx     ;ax = ax + cx
                               ;= 0 + 2
                               ;= 2 
             ;add ax, dx
             mov [rslt], ax ;result = 2 
       jmp INPUT            ;Unconditional Program Execution Transfer Instruction
      
       ;while_end:
       ;ret
takeInputs endp


;https://www.youtube.com/watch?v=6nTpsaZ-uf0
;Printing 16 bit number using stack in 8086 Assembly language  
Display16bitsNumber proc
                            ;ax = dividend law
       ;mov ax, inputNum    ;unsigned 0 to 2^16-1 (0 to 65535)
                            ;signed -32768 to +32767   
       ;print a new line
       mov dx, offset endl
       mov ah, 9
       int 21h
       
                         
       mov ax, sum
       
       cmp ax, 0            ;ax < 0
       jg repeat            ;if ax > 0
       
       ;if negative
       push ax              ;mov ah, 02h e value change hoye jabe
       mov dl, '-'
       mov ah, 02h
       int 21h
       
       pop ax
       neg ax               ;again 2's compliment so that we can get the proper value
       
repeat:  
       ;cwd
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

end addition