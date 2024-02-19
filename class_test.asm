.MODEL SMALL
.STACK 100h
.DATA

choice_msg  db 13,10,'ADD (+) OR SUB (-)?',13,10,'$' 
first_msg   db 13,10,'Enter A:',13,10,'$'
second_msg  db 13,10,'Enter B:',13,10,'$'
result_msg  db 13,10,'Result = :',13,10,'$'
new_line    db 13,10,'$'
val1        db ?
num1        db ?
num2        db ?
num3        db ?        ; purely a buffer variable 
ten         db 10   
t1          db 0
t2          db 0     
result      db 0

.CODE                   ;where the code is written
start:  

    mov ax, @data           ;Moves the address of the variables under .DATA into ax
    mov ds,ax           ;moves ax into ds. the two lines allow you to display string using the 21h interrupt sequence 9

    mov ah,09
    mov dx, offset choice_msg
    int 21h             ;displays the string in choice_msg

    mov ah,01
    int 21h             ;copies a value into the al, using subfunction 01

    cmp al,'+'          ;compares the entered value in with "+"
    jne subtract         ;if the enterd value is "+" then it jumps to addition else it jumps to subtraction

addition: 

    call read           ;Read the input
    call endl           ;output new line

    mov bl, num2        ;move the value of num 2 into bl

    add num1,bl         ;adds num2 and num1 to form the sum1
    mov al, num1        ;mov num1 to al
    mov result, al      ;store the result of the sum in result

    call write          ;write the output 
    jmp exit 
    
    
    subtract:

    call read           ;Read the input
    call endl           ;output new line

    mov bl, num2        ;move value of num2 to bl

    sub num1,bl         ;subtracts the value in num2 from the value in num1
    mov al, num1        ;move result to a register
    mov bl,al
    sub bl,1
    mov al,bl
    mov result, al      ;move the result of the subtraction to result

    call write          ;display result with write procedure
    jmp exit
    
    increment:

    call incrementinput           ;Read the input
    call endl           ;output new line

    mov bl, num1        ;move value of num2 to bl

    INC bl         ;subtracts the value in num2 from the value in num1
    mov al,bl         ;move result to a register
    mov result, al      ;move the result of the subtraction to result

    call write          ;display result with write procedure
    jmp exit

subtraction:

    call read           ;Read the input
    call endl           ;output new line

    mov bl, num2        ;move value of num2 to bl

    sub num1,bl         ;subtracts the value in num2 from the value in num1
    mov al, num1        ;move result to a register
    mov result, al      ;move the result of the subtraction to result

    call write          ;display result with write procedure
    jmp exit
    
    ;increment:

    ;call incrementinput           ;Read the input
    ;call endl           ;output new line

    ;mov bl, num1        ;move value of num2 to bl

    ;INC bl         ;subtracts the value in num2 from the value in num1
    ;mov al,bl         ;move result to a register
    ;mov result, al      ;move the result of the subtraction to result

    ;call write          ;display result with write procedure
    ;jmp exit


    ;-----------------------
    ;procedure declarations: 

    proc endl

        mov ah,09
        mov dx, offset new_line
        int 21h             ;goes to next line, i.e. "enter"

        ret

    endp


    proc read


        mov ah,09
        mov dx, offset first_msg
        int 21h             ;displays the string in first_msg

        mov ah,01           ;read char
        int 21h             ;copies a value into the al, using subfunction 01
        sub al,48           ;subtracts 48 from the vaule in the al
        mov num1,al         ;moves the value in the al to the variable num1

        mov ah,01           ;read second char
        int 21h             ;copies a value into the al, using subfunction 01
        sub al,48           ;subtracts 48 from the value in the al
        mov num2,al         ;moves the value in the al to the variable num2

        mov al,num1         ;moves the value in num1 into the al
        mul ten             ;multiplies the value in the al by ten
        add al,num2         ;adds the value in num2 to the al, to get the two-digit number
        mov num1,al         ;moves the two digit value into

        call endl

        mov ah,09
        mov dx, offset second_msg   ;displays the string in second_msg
        int 21h             

        mov ah,01
        int 21h             ;copies a value into the al, using subfunction 01
        sub al,48           ;subtracts 48 from the value in the al
        mov num2,al         ;moves the new value in the al into the variable num2

        mov ah,01
        int 21h             ;copies a value into the al, using subfunction 01
        sub al,48           ;subtracts 48 from the value in the al
        mov num3,al         ;moves the new value in the al into the variable num3

        mov al,num2         ;moves the value in num2 into the al
        mul ten             ;multiplies the value in the al by ten
        add al,num3         ;adds the value in num3 to the al, to get a two-digit number
        mov num2,al         ;moves the value in the al into the variable num2

        ret                 ;first number in num1, second in num2    
    endp
    
    proc incrementinput
        mov ah,09
        mov dx, offset first_msg
        int 21h             ;displays the string in first_msg

        mov ah,01           ;read char
        int 21h             ;copies a value into the al, using subfunction 01
        sub al,48           ;subtracts 48 from the vaule in the al
        mov num1,al         ;moves the value in the al to the variable num1

        mov ah,01           ;read second char
        int 21h             ;copies a value into the al, using subfunction 01
        sub al,48           ;subtracts 48 from the value in the al
        mov num2,al         ;moves the value in the al to the variable num2

        mov al,num1         ;moves the value in num1 into the al
        mul ten             ;multiplies the value in the al by ten
        add al,num2         ;adds the value in num2 to the al, to get the two-digit number
        mov num1,al         ;moves the two digit value into

        call endl
        
    endp
    
   


    ;The write procedure writes the decimal stored in result.
    ;by dividing by ten it seperates the two digits as quotient
    ;and remainder. Then it outputs the quotient and remainder
    ;in ascii form.
    proc write
            mov dx,offset result_msg
            mov ah,09h
            int 21h         ;display the result_msg string

            mov al,result   ;move the result from add/sub to al
            mov ah,00       ;initialize ah
            div ten         ;div al by ten, quotient is in al 
                            ;remainder is stored in ah.

            mov dl,ah       ;move the remainder to dl
            mov t2,dl       ;store the remainder in t2

            mov dl,al       ;move quotient into dl
            add dl,48       ;add 48 to dl, to convert it to ascii
            mov ah,02h      ;char display interupt code
            int 21h         ;display char in dl register

            mov dl,t2       ;move remainder to t2
            add dl,48       ;convert it to ascii by adding 48
            mov ah,02h      ;display character in dl interupt code
            int 21h         ;diplays contents of dl 

            call endl       ;output a new line
            ret             

    endp

    exit:
    mov ax, 4c00h               ;This is just a failsafe exit
    int 21h


END