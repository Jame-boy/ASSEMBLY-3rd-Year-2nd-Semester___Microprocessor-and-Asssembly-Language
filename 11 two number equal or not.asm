;program to print the input no is equal or not
.model small
.stack 100h                                   
.data
msg1 db 'number is equal$'
msg2 db 'number is not equal$'
.code
main proc
     mov ax, @data
     mov ds, ax ;initialize heap memory
     
     mov dl, '3' ; '' ASCII code
     mov ah, 1
     int 21h 
     
     cmp al, dl
     
     ;for new line
     mov dl, 10
     mov ah, 2
     int 21h
     
     mov dl, 13
     mov ah, 2
     int 21h
     
     je lebel1 
     
     lea dx, msg2
     mov ah, 9
     int 21h
     
     ;with out this msg1 will also be print
     mov ah, 4ch
     int 21h
     
     lebel1:
     lea dx, msg1
     mov ah, 9
     int 21h
     
     mov ah, 4ch
     int 21h 
     
main endp
end main