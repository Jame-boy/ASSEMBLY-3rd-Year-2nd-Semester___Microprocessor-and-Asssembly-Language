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
; 


 
 

; 6. Using only MOV, ADD, SUB, INC, DEC, and NEG, translate the
;following high-level language assignment statements Into assembly language. 
;A, B, and C are word variables.
 
;d. B = 3 x B + 7  
 
.model small
.stack 100h
.data 
    
    A       dw ?
    B       dw ?
    msg1    dw 'Give the value of B ... $' 
    result  dw 0
    flag    dw 0 
    endl    dw 10, 13, 10, 13, 'The Result of B = 3 * B + 7 is ....... $'
    base    dw 10
    counter dw 0
    
.code
main proc
        
        .startup ;load DS
         
         ;print the msg1
         mov dx, offset msg1
         mov ah, 09h
         int 21h
         
         
         ;for input A
         call input8bits
while_end:
         ;bcz 3 bar gun korte hobe     
         ;mov ax, result
         ;add ax, result
         ;add ax, result
         ;add ax, 7
         
         mov ax, result ;ax contains the inputt value        
         ;clear the valu
         mov dx, 0      
          
         mov bl, 3h
         mul bl      ;4 bits multiplicatiton
         add ax, 7
         mov B, ax
         mov A, ax ;for print
          
         
         ;print the result
         call Display16bitsNumber       
         
main endp 


;***************************************** PROCEDURE *****************************************
;*****************************************           *****************************************
      
;procedure ;https://www.youtube.com/watch?v=97oDBapuj1o
input8bits proc   
      
       mov ax, 0
       mov bx, 10           ;we will multiply with 10
       mov cx, 0
       ;mov dx, 0
       mov result, 0 ;eita bug silo -__-
       
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
       
                         
       mov ax, A
       
       cmp ax, 0            ;ax < 0
       jge repeat           ;if ax > 0 ;for jg 0 result will -0 that is not right ans
       
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
       
end main