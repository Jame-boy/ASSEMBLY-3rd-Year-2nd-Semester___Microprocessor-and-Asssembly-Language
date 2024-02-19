;2. Using only MOV, ADD, SUB, INC, DEC and NEG translate the
;following high level language assignment statements into assembly
;language. A, B and C are word variables. 

;    i. A=B-A
;   ii. A= - (A+1)
;  iii. C=A+B
;   iv. B=3*B+7
;    v. A=B-A-1


;Assuming A and B are 1 Digit Numbers

.model small              ;model directory <-- Specifies the total amount of memory the program would take
.stack 100h               ;stack segment directory <-- Specifies the storage for stack
.data                     ;data segment directory  <-- variables are defined here 

     A         db 0
     B         db 0
     opsn      db 0 
     finalRslt db 0
     
     cnt     dw 3
     msg1    dw 'Enter the value of A and B = $' 
     msg2    dw 13, 10, 13, 10, 'Choose option (problem number): $'
     
     endl    dw 13, 10, 13, 10, ' The result of $'
     end2    dw ' no. problem is = $'
     counter dw 0
     base    dw 10
     
.code                     ;code segment directory
main proc
        
        mov ax, @data
        mov ds, ax
        
        ;print the msg1
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        
        ;for input A
        mov ah, 01
        int 21h
        mov A, al
        
        ;for print a space
        mov dl, ' '
        mov ah, 02
        int 21h
        
        ;for input B
        mov ah, 01
        int 21h
        mov B, al
        
        
        ;for print msg2
        mov dx, offset msg2
        mov ah, 9h
        int 21h
        
        ;taking the option number 
        mov ah, 01h
        int 21h     
        mov opsn, al ;store the value
        
       ;print the endl
       mov dx, offset endl
       mov ah, 9
       int 21h
       
       ;print the option number
       mov dl, opsn
       mov ah, 02h
       int 21h
       
       ;print the msg2
       mov dx, offset end2
       mov ah, 9
       int 21h
       
       mov al, opsn 
       sub al, 48
        
;*****************************************   OPTION  *****************************************
;*****************************************           *****************************************  
        cmp al, 5
        je  case5
        
        cmp al, 4
        je  case4
        
        cmp al, 3
        je  case3 
        
        cmp al, 2
        je  case2
        
        case1: 
        ; i. A=B-A
             
             mov ax, 0 ;reset
             mov al, B
             sub al, A
             
             add al, 48
             mov finalRslt, al      
        call DisplaySingleDigit
        
        case2:
        ;   ii. A= - (A+1)
             
             mov ax, 0 ;reset
             mov al, A
             inc al
             
             mov finalRslt, al
             mov dl, 45 ;ASCII or - = 48
             mov ah, 2        
             int 21h          
             
        call DisplaySingleDigit
            
        case3:
        ;  iii. C=A+B
             
             mov ax, 0 ;reset
             mov al, A
             add al, B
             
             sub al, 48
             mov finalRslt, al     
        call DisplaySingleDigit
        
        case4:
        ;   iv. B=3*B+7
         
            mov ax, 0 ;reset 
            sub B, 48
            mov al, B       
            add al, B
            add al, B
            add al, 7
            
            add al, 48
            mov finalRslt, al
        call DisplaySingleDigit
        
        case5:
        ;    v. A=B-A-1
             
             mov ax, 0 ;reset
             mov al, B
             sub al, A
             sub al, 1
             
             mov finalRslt, al
             
             ;for print -ve
             cmp al, 0 
             add al, 48
             mov finalRslt, al
             jge call DisplaySingleDigit
             
             
             mov dl, '-'
             mov ah, 02
             int 21h
             neg finalRslt
             
        call DisplaySingleDigit 
        
        
main endp

;***************************************** PROCEDURE *****************************************
;*****************************************           ***************************************** 
  
DisplaySingleDigit proc
       
       mov dx, 0 ;reset
       mov dl, finalRslt
       ;sub dl, 48
       mov ah, 02
       int 21h
       
DisplaySingleDigit endp

       ;for successfully return
       mov ah, 4ch
       int 21h                                       
end main