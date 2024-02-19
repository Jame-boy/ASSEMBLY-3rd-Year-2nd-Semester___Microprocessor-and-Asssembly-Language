;4.  Case Conversion of a character/ a string

.model small              ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h               ;stack segment directory <-- Specifies the storage for stack
.data                     ;data segment directory   

string db 100 dup('$')
msg1   db 'Give the input String  .....  $'
msg2   db 13, 10, 'The Output is          .....  $'

.code                     ;code segment directory
conversion proc
    
           mov bx, @data
           mov ds, bx
           ;or .startup
           
           ;print the msg1
           mov dx, offset msg1
           mov ah, 9
           int 21h
            
            
           mov si, offset string
 takeInput:
          mov ah, 1
          int 21h
          cmp al, 13            ;13 is the ASCII value of enter key
          je Display            ;conditional jump
          
          cmp al, 32            ;32 is the ASCII value of space
          je space:                  
          
          cmp al, 96            ;96 is the ASCII value of (a)
          jg upper:
          jl lower:
jmp takeInput                   ;unconditional jump
     
    space:
         mov [si], al
         inc si
jmp takeInput
        
    upper: 
         sub al, 32  
         mov [si], al
         inc si
jmp takeInput
         
    lower:
         add al, 32
         mov [si], al
         inc si
jmp takeInput
        
        
         
    Display:
           ;print the msg2
           mov dx, offset msg2
           mov ah, 9
           int 21h
            
           ;print the string
           mov dx, offset string
           mov ah, 9
           int 21h
           
           ;return from ah register successfully
           mov ah, 4ch
           int 21h
          
conversion endp
end conversion