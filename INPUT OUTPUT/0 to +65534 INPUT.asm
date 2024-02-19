;   Author      : Md Jubayer Hossen Jame
;   Study       : CSE, BRUR
;   Today       : Sunday, 27 February, 2022
;*************************************************************************
;*************************************************************************


;https://www.youtube.com/watch?v=X4NVgPp5LhU&list=PLdavwjuHtWJ-ISERt-UXpwjB_JsVup7Li&index=7

;help ---- > 6.How to input grater then 9 and store the number in Assembly Language. 

;It is created by me

.model small
.stack 100h
.data

     base dw 10
     
.code
main proc 
	 
	 mov bx, @data
	 mov ds, bx   ;load data segment
	 
	;here we can input 0 to +65534 maximum
	;input number will store in bx register
	mov bx, 0
	;mov bl, 10d
       
    
       INPUT: 
       
       ;for input a single character
       mov ah, 1
       int 21h
       
       cmp al, 13d ;13d is the ASCII of enter key
       jne NUMBER 
       
       jmp EXIT
       
       
       NUMBER:
       SUB AL,30H ;zero ASCII 48d = 30h
       
       mov cx, 0 ;reset
       mov cl, al ;store the al value bcz after mul it will be corrupted
       mov ax, 0 ;reset
       mov ax, bx 
       
       ;mov bx, 10
       ;mul bx     ;16 bits multiplication
                  ;dxax = ax * 16-bits reg
       ; or mul base   
       
       add ax, cx               
       mov bx, ax
       
       JMP INPUT
       
	EXIT: 
	;neg bx ;for negative value    
	

;for successfully return
;mov ah, 4ch
;int 21h
    
main endp
end main