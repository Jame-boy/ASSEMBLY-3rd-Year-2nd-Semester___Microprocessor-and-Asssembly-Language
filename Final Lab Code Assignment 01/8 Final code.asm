;8.Write a program to (a) display a "?", (b) read two decimal digits
;whose sum "is less than 10, (c) display them and their sum on the
;next line, with an appropriate message. 

;Sample execution:
;?27
;THE SUM OF 2 AND 7 IS 9

.model small
.stack 100h
.data 

   msg1 dw ' ?$'
   msg2 dw 13, 10, 'THE SUM OF $'
   msg3 dw ' AND $'
   msg4 dw ' IS $'
   
   sum  db 0
   
.code

main proc
    ;for access data directly from Data Segment
    mov ax, @data
    mov ds, ax
    
    ;print the msg1
    mov dx, offset msg1   ;same as -- lea dx, msg1 
    mov ah, 9
    int 21h
    
    ;******************** INPUT ********************************
    ;input first digit
    mov ah, 1
    int 21h                              
    mov ch, al    ;cx = ch cl ;store the first digit 
                     ;= 02 
    add sum, al 
    
    ;input second digit
    mov ah, 1
    int 21h 
    mov cl, al    ;cx = ch cl ;store the second digit  
                     ;= 02 07
    add sum, al
    
    ;******************** OUTPUT *******************************
    ;print the msg2
    mov dx, offset msg2
    mov ah, 9
    int 21h
    
    ;print the first digit
    mov dl, ch  
    mov ah, 2
    int 21h
    
    ;print the msg3
    mov dx, offset msg3
    mov ah, 9
    int 21h
    
    ;print the second digit
    mov dl, cl
    mov ah, 2
    int 21h
    
    ;print the msg4
    mov dx, offset msg4
    mov ah, 9
    int 21h
    
    ;print the sum
    sub sum, 48   ;maintain the ASCII value
    mov dl, sum
    mov ah, 2
    int 21h 
     
    ;to execute from ah register
    mov ah, 4ch
    int 21h
main endp
end main