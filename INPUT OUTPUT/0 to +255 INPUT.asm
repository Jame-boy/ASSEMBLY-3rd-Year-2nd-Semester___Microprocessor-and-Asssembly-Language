;   Author      : Md Jubayer Hossen Jame
;   Study       : CSE, BRUR
;   Today       : Sunday, 27 February, 2022
;*************************************************************************
;*************************************************************************


;https://www.youtube.com/watch?v=X4NVgPp5LhU&list=PLdavwjuHtWJ-ISERt-UXpwjB_JsVup7Li&index=7

;6.How to input grater then 9 and store the number in Assembly Language.

.model small
.stack 100h
.data
.code
main proc 
	 
	 
	;here we can input 0 to 2^8 - 1 = 255 maximum 
	;input number will store in bh register
	mov bh, 0
	mov bl, 10d
       
    
       INPUT: 
       
       ;for input a single character
       mov ah, 1
       int 21h
       
       cmp al, 13d ;13d is the ASCII of enter key
       jne NUMBER 
       
       jmp EXIT
       
       
       NUMBER:
       SUB AL,30H ;zero ASCII 48d = 30h
       
       mov cl, al ;store the al value bcz after mul it will be corrupted
       mov al, bh 
       
       mul bl     ;8 bits multiplication
                  ;ax = al * 8-bits reg
       add al, cl               
       mov bh, al
       
       JMP INPUT
       
	EXIT:
	;neg bh ;for negative value by me
	;mov bh, -10    
	

;for successfully return
mov ah, 4ch
int 21h
    
main endp
end main