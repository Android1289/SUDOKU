[org 0x100]
jmp start


t: db 'Timer:', 0
s: db 'Score:', 0
m: db 'Mistakes:', 0
win: db 'Congratulations!!', 0
u: db 'Pencil', 0
mess: db 'Welcome to sudoku!', 0  
easy: db 'Easy', 0
med: db 'Medium', 0
hard: db 'Hard', 0
over: db 'Game Over', 0 
new: db 'Play Again', 0
loc: dw 3857
score: db 0
mistake_count: dw 0
score_count: dw 0
level_choice db 1 
first_: db 1

stack: times 16*512 dw 0
moves: dw 0
music_length: dw 15644
music_data: incbin "getthem.imf"
freq:   incbin "freq.bin"
dura:   incbin "duration.bin"
;level_choice: db 0

i: db 0
j: db 0
pos: dw 0
flag: dw 0
row: dw 0
col: dw 0
time: dw 10
miliSec: dw 0
sec: dw 0
min: dw 0
position: db 0
points: db 0


check_array: times 9*81 dw 0
third_array: times 9*81 dw 0
notes_array : times 81*81 db 0
color : times 9*9 db 0
array : times 9*81 dw 0
		
solvedarray:  times 9*81 db 0

; 




		  
		  
locations:  dw 3857,  3877,  3897,  3918,  3938,  3958,  3979,  3999,  4019,
			dw 10257, 10277, 10297, 10318, 10338, 10358, 10379, 10399, 10419,
			dw 16657, 16677, 16697, 16718, 16738, 16758, 16779, 16799, 16819,
			dw 23377, 23397, 23417, 23438, 23458, 23478, 23499, 23519, 23539,
			dw 29777, 29797, 29817, 29838, 29858, 29878, 29899, 29919, 29939,
			dw 36177, 36197, 36217, 36238, 36258, 36278, 36299, 36319, 36339,
			dw 42897, 42917, 42937, 42958, 42978, 42998, 43019, 43039, 43059,
			dw 49297, 49317, 49337, 49358, 49378, 49398, 49419, 49439, 49459,
			dw 55697, 55717, 55737, 55758, 55778, 55798, 55819, 55839, 55859,



up1: dw 3857, 3877, 3897, 3918, 3938, 3958, 3979, 3999, 4019
up2: dw 23377, 23397, 23417, 23438, 23458, 23478, 23499, 23519, 23539, 42897, 42917, 42937, 42958, 42978, 42998, 43019, 43039, 43059
down1: dw	55697, 55717, 55737, 55758, 55778, 55798, 55819, 55839, 55859
down2: dw	16657, 16677, 16697, 16718, 16738, 16758, 16779, 16799, 16819, 36177, 36197, 36217, 36238, 36258, 36278, 36299, 36319, 36339
left1: dw 3857, 10257, 16657, 23377, 29777, 36177, 42897, 49297, 55697
left2: dw 3918, 10318, 16718, 23438, 29838, 36238, 42958, 49358, 55758, 3979, 10379, 16779, 23499, 29899, 36299, 43019, 49419, 55819
right1: dw 4019, 10419, 16819, 23539, 29939, 36339, 43059, 49459, 55859
right2: dw 3897, 10297, 16697, 23417, 29817, 36217, 42937, 49337, 55737, 3958, 10358, 16758, 23478, 29878, 36278, 42998, 49398, 55798

;Arrays
easysolvedarray: 
		db 	1, 8, 5, 9, 4, 3, 6, 7, 2,
		db  9, 2, 6, 7, 1, 5, 4, 3, 8,
	    db  3, 4, 7, 8, 2, 6, 9, 5, 1,
		db  4, 6, 8, 5, 9, 1, 3, 2, 7,
		db  2, 5, 1, 5, 3, 7, 8, 6, 9,
		db  7, 3, 9, 2, 6, 8, 1, 4, 5,
		db  5, 1, 2, 3, 8, 4, 7, 9, 6,
		db  8, 9, 4, 6, 7, 2, 5, 1, 3,
		db  6, 7, 3, 1, 5, 9, 2, 8, 4
		
mediumsolvedarray:
    db  2, 5, 1, 9, 7, 6, 3, 8, 4,
    db  8, 4, 9, 5, 3, 1, 2, 6, 7,
    db  7, 3, 6, 2, 8, 4, 9, 5, 1,
    db  1, 7, 8, 3, 2, 5, 6, 4, 9,
    db  6, 2, 4, 1, 9, 8, 7, 3, 5,
    db  5, 9, 3, 6, 4, 7, 8, 1, 2,
    db  9, 6, 7, 4, 5, 3, 1, 2, 8,
    db  4, 1, 2, 8, 6, 9, 5, 7, 3,
    db  3, 8, 5, 7, 1, 2, 4, 9, 6

extremesolvedarray:
    db  4, 2, 8, 3, 9, 1, 6, 7, 5
    db  1, 3, 5, 8, 7, 6, 2, 9, 4
    db  7, 6, 9, 2, 5, 4, 8, 3, 1
    db  5, 9, 1, 6, 2, 3, 7, 4, 8
    db  3, 8, 6, 4, 1, 7, 5, 2, 9
    db  2, 4, 7, 9, 8, 5, 3, 1, 6
    db  6, 7, 3, 5, 4, 9, 1, 8, 2
    db  9, 1, 2, 7, 6, 8, 4, 5, 3
    db  8, 5, 4, 1, 3, 2, 9, 6, 7


music:
		push si
		push dx
		push ax
		push bx
		push cx
		mov si, 200
	.next_note:
		mov dx, 388h
		mov al, [si + music_data + 0]
		out dx, al
		mov dx, 389h
		mov al, [si + music_data + 1]
		out dx, al
		mov bx, [si + music_data + 2]
		add si, 4
	.repeat_delay:
		mov cx, 610
	.delay:
		mov ah, 1
		int 16h
		jnz st
		loop .delay
		dec bx
		jg .repeat_delay
		cmp si, [music_length]
		jb .next_note
	st:
		mov dx, 388h
		mov al, 0xff
		out dx, al
		mov dx, 389h
		mov al, 0xff
		out dx, al
		mov bx, 0
		pop cx
		pop bx
		pop ax
		pop dx
		pop si
ret

speakerOn:
        and     ax, 0xfffe
        push    ax
        cli
        mov     al, 0xb6
        out     0x43, al
        pop     ax
        out     0x42, al
        mov     al, ah
        out     0x42, al
        in      al, 0x61
        mov     al, ah
        or      al, 3
        out     0x61, al
        sti
    ret
	
	
;;; speakerOff - silences the PC Speaker.
;;; Trashes AX.
speakerOff:
        in      al, 0x61
        and     al, 0xfc
        out     0x61, al
        ret

;functions

sleep:
push cx
mov cx, 0x750
delay:
loop delay
pop cx
ret
sleep2:
push cx
mov cx, 0xFFFF
delay2:
loop delay2
pop cx
ret
blink:
	call sleep2
	call sleep2
	call sleep2
	call sleep2
	call sleep2
	call sleep2
	call sleep2
	ret
	
	
clock:
		push bp
		mov bp,sp
		push es
		push ax
		push di
		push si
		push cx
		push bx
		
			lea si, [t] 
    mov bx, 26           ; Column 
    mov cx, 6           ; Length of the string
	mov dx, 2
	;push dx
printMessage_:
    mov al, [si]
    cmp al, 0 
    je donePrinting_ 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop printMessage_    

donePrinting_:
	mov di, 2176+320*10+3
		
		cmp word[min], 9
		ja noNeed
		push di
		call tprintnote0
		add di, 6
		
		noNeed:
		;print num
		mov ax,[min]
		mov bx,10
		mov cx,0
nextDigit1:
		mov dx,0
		div bx
		;add dl,0x30
		push dx
		inc cx
		cmp ax,0
		jnz nextDigit1
		
		;mov di,0
		
nextpos1:
		pop dx
		mov dh, 0x40
		
		cmp dl, 0
		jne num1
		push di
		call tprintnote0
		
		num1:
		cmp dl, 1
		jne num2
		push di
		call tprintnote1
		
		num2:
		cmp dl, 2
		jne num3
		push di
		call tprintnote2
		
		num3:
		cmp dl, 3
		jne num4
		push di
		call tprintnote3
		
		num4:
		cmp dl, 4
		jne num5
		push di
		call tprintnote4
		
		num5:
		cmp dl, 5
		jne num6
		push di
		call tprintnote5
		
		num6:
		cmp dl, 6
		jne num7
		push di
		call tprintnote6
		
		num7:
		cmp dl, 7
		jne num8
		push di
		call tprintnote7
		
		num8:
		cmp dl, 8
		jne num9
		push di
		call tprintnote8
		
		num9:
		cmp dl, 9
		jne num10
		push di
		call tprintnote9
		
		num10:
		
		;mov [es:di],dx
		add di,6
		loop nextpos1
		
		;mov dx,0x403A
		;mov word[es:di],0x403A
		mov word[es: 2176+320*12+3+18+5-10],4
		mov word[es: 2176+320*14+3+18+5-10],4
		add di,4
		
		cmp word[sec], 9
		ja againNoNeed
		push di
		call tprintnote0
		add di, 6
		
		againNoNeed:
		
		;print num
		mov ax,[sec]
		mov bx,10
		mov cx,0
nextDigit2:
		mov dx,0
		div bx
		;add dl,0x30
		push dx
		inc cx
		cmp ax,0
		jnz nextDigit2
		
		;mov di,0
		
nextpos2:
		pop dx
		mov dh, 0x40
		
		cmp dl, 0
		jne nums1
		push di
		call tprintnote0
		
		nums1:
		cmp dl, 1
		jne nums2
		push di
		call tprintnote1
		
		nums2:
		cmp dl, 2
		jne nums3
		push di
		call tprintnote2
		
		nums3:
		cmp dl, 3
		jne nums4
		push di
		call tprintnote3
		
		nums4:
		cmp dl, 4
		jne nums5
		push di
		call tprintnote4
		
		nums5:
		cmp dl, 5
		jne nums6
		push di
		call tprintnote5
		
		nums6:
		cmp dl, 6
		jne nums7
		push di
		call tprintnote6
		
		nums7:
		cmp dl, 7
		jne nums8
		push di
		call tprintnote7
		
		nums8:
		cmp dl, 8
		jne nums9
		push di
		call tprintnote8
		
		nums9:
		cmp dl, 9
		jne nums10
		push di
		call tprintnote9
		
		nums10:
		
		;mov [es:di],dx
		add di,6
		loop nextpos2
		
		;mov dx,0x4020
		;mov byte[es:di],0

		add di,2
		
		cmp word[miliSec], 5
		jne SecInc
		add word[sec], 1
		mov word[miliSec], 0
		
		SecInc:
		cmp word[sec], 60
		jne MinInc
		add word[min], 1
		mov word[sec], 0
		
		MinInc: 
		add word[miliSec], 1
		
		
		pop bx
		pop cx
		pop si
		pop di
		pop ax
		pop es
		mov sp,bp
		pop bp
ret

block:
	push di
	push ax
	push cx
	
	
	mov di, 205+320*10
	mov al, 0
againBlock:
	mov cx, 110
	rep stosb
	sub di, 110
	add di, 320
	cmp di, 63890-320*140
	jbe againBlock
	
	pop cx
	pop ax
	pop di
	
	ret
block_2:
	push di
	push ax
	push cx
	
	
	mov di, 260+320*10
	mov al, 0
againBlock_2:
	mov cx, 30
	rep stosb
	sub di, 30
	add di, 320
	cmp di, 63890-320*157
	jbe againBlock_2
	
	pop cx
	pop ax
	pop di
	
	ret
	
block_3:
	push di
	push ax
	push cx
	
	
	mov di, 280+320*50
	mov al, 0
againBlock_22:
	mov cx, 10
	rep stosb
	sub di, 10
	add di, 320
	cmp di, 63890-320*140
	jbe againBlock_22
	
	pop cx
	pop ax
	pop di
	
	ret
print_gameover:


	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
	
	mov al,4
	xor di,di
	mov dx,0

	
gameover_loop:

	
	mov bx,310	
	sub bx,dx
	
go_l2:
	mov cx,20
go_l1:
	mov byte [es:di],al
	add di,320
	loop go_l1
	
	call sleep
	sub di,6399
	dec bx
	jnz go_l2
	
	
	
	;sub di,10
	
	
	mov bx,200
	sub bx,dx
	
go_l3:
	mov cx,20
	rep stosb
	
	call sleep
	add di,300
	dec bx
	jnz go_l3
	
	
	sub di,6400
	
	
	mov bx,310
	sub bx,dx
	
go_l4:
	mov cx,20
go_l5:
	mov byte [es:di],al
	add di,320
	loop go_l5
	
	call sleep
	sub di,6401
	dec bx
	jnz go_l4
	
	
	; mov di,60800
	add di,6400
	
	
	mov bx,200
	sub bx,dx
	
go_l6:
	mov cx,20
	rep stosb
	
	call sleep
	sub di,340
	dec bx
	jnz go_l6
	
	add di,6420
	add dx,40
	cmp dx,200
	jne gameover_loop
	
	
	repeat:
	call game_over
	;call Button 
	
	call sleep2
	call sleep2
	call sleep2
	
	call clear_screen
	
	call sleep2
	call sleep2
	call sleep2
	call sleep2
	jmp repeat
	
	
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
	
    ret

print_gamewon:


	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
	
	mov al,14
	xor di,di
	mov dx,0

	
gamewon_loop:

	
	mov bx,310	
	sub bx,dx
	
gw_l2:
	mov cx,20
gw_l1:
	mov byte [es:di],al
	add di,320
	loop gw_l1
	
	call sleep
	sub di,6399
	dec bx
	jnz gw_l2
	
	
	
	;sub di,10
	
	
	mov bx,200
	sub bx,dx
	
gw_l3:
	mov cx,20
	rep stosb
	
	call sleep
	add di,300
	dec bx
	jnz gw_l3
	
	
	sub di,6400
	
	
	mov bx,310
	sub bx,dx
	
gw_l4:
	mov cx,20
gw_l5:
	mov byte [es:di],al
	add di,320
	loop gw_l5
	
	call sleep
	sub di,6401
	dec bx
	jnz gw_l4
	
	
	; mov di,60800
	add di,6400
	
	
	mov bx,200
	sub bx,dx
	
gw_l6:
	mov cx,20
	rep stosb
	
	call sleep
	sub di,340
	dec bx
	jnz gw_l6
	
	add di,6420
	add dx,40
	cmp dx,200
	jne gamewon_loop
	
	
	repeat_:
	call game_won
	;call Button 
	
	call sleep2
	call sleep2
	call sleep2
	
	call clear_screen
	
	call sleep2
	call sleep2
	call sleep2
	call sleep2
	jmp repeat_
	
	
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
	
    ret


display_notes:

	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	push si
	
	mov si,notes_array
	mov dl,81
	mov bx,0
	
	
display_notes_loop1:

	mov cx,18
	;mov dh,0

display_notes_loop2:
	
	mov ax,[si]
	
	cmp ax,1
	jne next_1
	push word[locations+bx]
	call printnote1
	
next_1:

	cmp ax,2
	jne next_2
	push word[locations+bx]
	call printnote2
	
next_2:
			
	cmp ax,3
	jne next_3
	push word[locations+bx]
	call printnote3
		
next_3:

	cmp ax,4
	jne next_4
	push word[locations+bx]
	call printnote4
	
next_4:
			
	cmp ax,5
	jne next_5
	push word[locations+bx]
	call printnote5
	
next_5:

	cmp ax,6
	jne next_6
	push word[locations+bx]
	call printnote6
	
next_6:

	cmp ax,7
	jne next_7
	push word[locations+bx]
	call printnote7	
	
next_7:
			
	cmp ax,8
	jne next_8
	push word[locations+bx]
	call printnote8
	
next_8:

	cmp ax,9
	jne next_9
	push word[locations+bx]
	call printnote9

next_9:
	
	; inc dh
	; cmp dh,10
	; jge increase_si
cont_3:	
	add si,1 ;
	loop display_notes_loop2
	
	add bx,2
	sub dl,1
	jnz display_notes_loop1
	
	pop si
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 

increase_si:
	inc si
	;mov dh,0
	jmp cont_3
	
horizontal:
    push bp
    mov bp, sp
    push es
    push ax
    push di
    push cx

    mov cx, [bp + 6]
    mov di, [bp + 4] 
    mov al, 0
    rep stosb

    pop cx
    pop di
    pop ax
    pop es
    pop bp
    ret

vertical:
    push bp
    mov bp, sp
    push es
    push ax
    push di
    push cx

    mov cx, [bp + 6]            ; Height of the line
    mov di, [bp + 4]            ; Starting position
    mov al, 0

vert_loop:
    mov byte[es:di], 0          ; Draw pixel
    add di, 320                 ; Move to the same position on the next row
    loop vert_loop

    pop cx
    pop di
    pop ax
    pop es
    pop bp
    ret

grid:
    push bp
    mov bp, sp
    push cx
    push dx
    push ax
    push di
    push es
    push bx

    mov cx, 185                 ; size of line
    push cx                     ; pushing size of each line

    mov dx, 0xA000
    mov es, dx
    mov al, 0

    mov cx, 10

    mov di, 10*320 + 15
    mov bx, 3
draw:
    push di                     ; pushing location for each horizontal line
    call horizontal
    pop di                      ; poping the location and incrementing it 15 pixels below
    cmp bx, 3
    jnz double
    mov bx, 0
    add di, 1*320
    push di                     ; pushing location for each horizontal line
    call horizontal
    pop di
double:
    add bx, 1
    add di, 20*320
    loop draw

    mov di, 10*320 + 15
    mov cx, 10
    mov bx, 3

draw2:
    push di 
    call vertical
    pop di  
    cmp bx, 3
    jnz double2
    mov bx, 0
    add di, 1
    push di
    call vertical
    pop di
double2:
    add bx, 1
    add di, 20
    loop draw2

    pop bx
    pop cx
    pop es
    pop di
    pop ax
    pop dx
    pop cx
    pop bp
    ret
	
;-----------------------------------subroutines to print NOTES numbers-----------------------------------------------
	;-------------------------------------PRINTING NOTE 0------------------------------------
	
tprintnote0:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 0
    
	
	mov ah,2
	mov dx,0

thn_0:	
	mov di, [bp+4]
	add di,1+320			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
	rep stosb

	
	add dx,320*4
	dec ah
	jnz thn_0
	

;-----------------------vertical line of 0


	mov di, [bp+4]
	add di, 1+320			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 
	
tvn00:	
    mov byte [es:di],al
	add di,320
	loop tvn00
	
	;-----
	
	
	mov di, [bp+4]
	add di ,4+320			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx,5         ; 15 pixels getting printed down the y axis 
	
tvn_00:	
    mov byte [es:di],al
	add di,320
	loop tvn_00



	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

;-------------------------------------PRINTING NOTE 1------------------------------------

tprintnote1:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax

;-----------------------vertical line of 1
	
	mov di, [bp+4]
	add di,2+320			
	mov cx,5               
    mov al, 15
	
tvn1:	
    mov byte [es:di],al
	add di,320
	loop tvn1
;------------------horizontal line of 1
	
	mov di, [bp+4]
	add di,1+320*5			
	mov cx,3					
thn1:	
	mov byte [es:di],al
	add di,1
	loop thn1	
;------------------print diagonal part of 1	
	mov di, [bp+4]				
	add di,1+320*2	
	mov byte [es:di],al
	
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2


	;-----------------------------------------------------------------------note 2----------------------
tprintnote2:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 2
    
	
	
	
	mov di, [bp+4]
	add di,1+320;7+320*1			; 4 pixels right on x axis and 15 pixels down on y axis	
	mov cx,3				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	

	mov di, [bp+4]
	add di,2+320*3;8+320*3
	mov cx,2
	rep stosb
	

	mov di, [bp+4]
	add di,1+320*5;7+320*5			; 4 pixels right on x axis and 15 pixels down on y axis
	mov cx,4	
	rep stosb
	
;-----------------------vertical line of 2


	mov di, [bp+4]
	add di,1+320*4;7+320*4			; 8 pixels right on x axis / 2 pixels down on y axis        ; 15 pixels getting printed down the y axis 
    mov al, 15
    mov byte [es:di],al

		
	mov di, [bp+4]
	add di,3+320*2;10+320*2			; 8 pixels right on x axis / 2 pixels down on y axis            ; 15 pixels getting printed down the y axis 
    mov al, 15
	mov byte [es:di],al
	

	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
;--------------------------------------------------PRINTING NOTE 3
tprintnote3:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 2
    
	
	mov ax,2
	mov dx,0
thn_3:
	mov bx,1				; line is getting printed 2 times (up and down)
	
thn3:	
	mov di, [bp+4]
	add di,1+320;14+320			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
thn33:	
	mov byte [es:di],15
	add di,1
	loop thn33
	
	add dx,320
	sub bx,1
	jnz thn3
	
	add dx,320*3
	dec ax
	jnz thn_3
	
	mov dx,0
	mov bx,1				; line is getting printed 2 times (up and down)
	
thn3_:	
	mov di, [bp+4]
	add di,2+320*3;15+320*3			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,3				; line is 11 pixels long horizontally (on x axis)
	
thn33_:	
	mov byte [es:di],15
	add di,1
	loop thn33_
	
	add dx,320
	sub bx,1
	jnz thn3_	
	

	

;-----------------------vertical line of 3
	mov dx,0
	mov bx,1				; line is getting printed 3 times (side by side)
	
	
tvn3:	
	mov di, [bp+4]
	add di,4+320;17+320		; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 5              ; 15 pixels getting printed down the y axis 
    mov al, 15
	
tvn33:	
    mov byte [es:di],al
	add di,320
	loop tvn33
	
	add dx,1
	sub bx,1
	jnz tvn3

	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

;-----------------------------------------PRINTING NOTE 4

tprintnote4:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 4
	mov di, [bp+4]
	add di,1+320*3;1+320*9			; 4 pixels right on x axis and 15 pixels down on y axis
	mov cx,3				; line is 11 pixels long horizontally (on x axis)
	
thn44:	
	mov byte [es:di],15
	add di,1
	loop thn44

;-----------------------vertical line of 4
	
	mov di, [bp+4]
	add di,3+320;3+320*7			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 
    mov al, 15
	
tvn44:	
    mov byte [es:di],al
	add di,320
	loop tvn44

	
	;----diagonal
	

	mov di, [bp+4]					; 7 pixels right on x axis while 3 pixels down on y
	add di,1+320;1+320*7
	mov cx,2
tdn44:	
	mov byte [es:di],al
	add di,320
	loop tdn44



	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

;----------------------------------------------PRINTING NOTE 5------------------------------------

tprintnote5:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 5
    
	
	mov ah,3
	mov dx,0

thn_5:	
	mov di, [bp+4]
	add di,1+320;7+320*7			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
thn55:	
	mov byte [es:di],al
	add di,1
	loop thn55

	
	add dx,320*2
	dec ah
	jnz thn_5
	

;-----------------------vertical line of 5


	mov di, [bp+4]
	add di, 1+320;7+320*7			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 3             ; 15 pixels getting printed down the y axis 
	
tvn55:	
    mov byte [es:di],al
	add di,320
	loop tvn55
	
	;-----
	
	
	mov di, [bp+4]
	add di ,4+320*3;10+320*9			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx,3         ; 15 pixels getting printed down the y axis 
	
tvn_55:	
    mov byte [es:di],al
	add di,320
	loop tvn_55



	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

;-------------------------------------PRINTING NOTE 6-------------------------------

tprintnote6:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 6
    
	
	mov ah,3
	mov dx,0
thn_6:
	
	mov di, [bp+4]
	add di,1+320;14+320*7			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320*2
	dec ah
	jnz thn_6

	

;-----------------------vertical line of 6

	mov di, [bp+4]
	add di,1+320;14+320*7	; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 	
tvn66:	
    mov byte [es:di],al
	add di,320
	loop tvn66

	;---------------------------------------------------
	mov di, [bp+4]
	add di,4+320*3;17+320*9		; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 2             ; 15 pixels getting printed down the y axis 	
tvn_66:	
    mov byte [es:di],al
	add di,320
	loop tvn_66


	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
;--------------------------------------------PRINTING NOTE 7

tprintnote7:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 7
    

	mov di, [bp+4]
	add di,1+320;1+320*13			; 4 pixels right on x axis and 15 pixels down on y axis
	mov cx,4				; line is 11 pixels long horizontally (on x axis)	
	rep stosb



;------------------print diagonal part of 7

    mov bx,4                  
    mov dx,0                    

tdn7:
    mov di, [bp+4]              
    add di,4+320*2;4 + 320*14         
    add di,dx                   
	mov cx,1
    rep stosb 

    add dx,319                  
    dec bx                     
    jnz tdn7  

	; mov bx,2
    ; mov dx,0                    

; dn_7:
    ; mov di, [bp+4]              
    ; add di,3 + 320*16         
    ; add di,dx                   
	; mov cx,1
    ; rep stosb 

    ; add dx,319                  
    ; dec bx                     
    ; jnz dn_7  	



	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
	;-------------------------------------PRINTING NOTE 8------------------------------------
	
tprintnote8:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 8
    
	
	mov ah,3
	mov dx,0

thn_8:	
	mov di, [bp+4]
	add di,1+320;7+320*13			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
	rep stosb

	
	add dx,320*2
	dec ah
	jnz thn_8
	

;-----------------------vertical line of 8


	mov di, [bp+4]
	add di, 1+320;7+320*13			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 
	
tvn88:	
    mov byte [es:di],al
	add di,320
	loop tvn88
	
	;-----
	
	
	mov di, [bp+4]
	add di ,4+320;10+320*13			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx,5         ; 15 pixels getting printed down the y axis 
	
tvn_88:	
    mov byte [es:di],al
	add di,320
	loop tvn_88



	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
	
	;-----------------------------------PRINTING NOTE 9-------------------------------------
	
tprintnote9:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,15

;------------------horizontal line of 9
    
	
	mov ah,3
	mov dx,0

thn_9:	
	mov di, [bp+4]
	add di,1+320;14+320*13			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
	rep stosb

	
	add dx,320*2
	dec ah
	jnz thn_9
	

;-----------------------vertical line of 9


	mov di, [bp+4]
	add di, 4+320;17+320*13			
	mov cx, 5             
	
tvn99:	
    mov byte [es:di],al
	add di,320
	loop tvn99
	
	;-----
	
	
	mov di, [bp+4]
	add di ,1+320;14+320*13			
	mov cx,3         
	
tvn_99:	
    mov byte [es:di],al
	add di,320
	loop tvn_99



	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2	
	
	
printnote0:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 0
    
	
	mov ah,2
	mov dx,0

hn_0:	
	mov di, [bp+4]
	add di,7+320*13			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
	rep stosb

	
	add dx,320*4
	dec ah
	jnz hn_0
	

;-----------------------vertical line of 8


	mov di, [bp+4]
	add di, 7+320*13			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 
	
vn00:	
    mov byte [es:di],al
	add di,320
	loop vn00
	
	;-----
	
	
	mov di, [bp+4]
	add di ,10+320*13			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx,5         ; 15 pixels getting printed down the y axis 
	
vn_00:	
    mov byte [es:di],al
	add di,320
	loop vn_00



	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

printnote1:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
    mov ax, 0xA000
    mov es, ax

;-----------------------vertical line of 1
					
	mov di, [bp+4]
	add di,2+320			
	mov cx,5               
    mov al, 4
	
vn1:	
    mov byte [es:di],al
	add di,320
	loop vn1
;------------------horizontal line of 1
	
	mov di, [bp+4]
	add di,1+320*5			
	mov cx,3					
hn1:	
	mov byte [es:di],al
	add di,1
	loop hn1	
;------------------print diagonal part of 1	
	mov di, [bp+4]				
	add di,1+320*2	
	mov byte [es:di],al
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
	;-----------------------------------------------------------------------note 2----------------------
printnote2:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 2
    
	
	
	
	mov di, [bp+4]
	add di,7+320*1			; 4 pixels right on x axis and 15 pixels down on y axis	
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	

	mov di, [bp+4]
	add di,8+320*3
	mov cx,2
	rep stosb
	

	mov di, [bp+4]
	add di,7+320*5			; 4 pixels right on x axis and 15 pixels down on y axis
	mov cx,4	
	rep stosb
	
;-----------------------vertical line of 2


	mov di, [bp+4]
	add di,7+320*4			; 8 pixels right on x axis / 2 pixels down on y axis        ; 15 pixels getting printed down the y axis 
    mov al, 4	
    mov byte [es:di],al

		
	mov di, [bp+4]
	add di,10+320*2			; 8 pixels right on x axis / 2 pixels down on y axis            ; 15 pixels getting printed down the y axis 
    mov al, 4
	mov byte [es:di],al
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
;--------------------------------------------------PRINTING NOTE 3
printnote3:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 2
    
	
	mov ax,2
	mov dx,0
hn_3:
	mov bx,1				; line is getting printed 2 times (up and down)
	
hn3:	
	mov di, [bp+4]
	add di,14+320			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
hn33:	
	mov byte [es:di],4
	add di,1
	loop hn33
	
	add dx,320
	sub bx,1
	jnz hn3
	
	add dx,320*3
	dec ax
	jnz hn_3
	
	mov dx,0
	mov bx,1				; line is getting printed 2 times (up and down)
	
hn3_:	
	mov di, [bp+4]
	add di,15+320*3			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,3				; line is 11 pixels long horizontally (on x axis)
	
hn33_:	
	mov byte [es:di],4
	add di,1
	loop hn33_
	
	add dx,320
	sub bx,1
	jnz hn3_	
	

	

;-----------------------vertical line of 3
	mov dx,0
	mov bx,1				; line is getting printed 3 times (side by side)
	
	
vn3:	
	mov di, [bp+4]
	add di,17+320		; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 5              ; 15 pixels getting printed down the y axis 
    mov al, 4
	
vn33:	
    mov byte [es:di],al
	add di,320
	loop vn33
	
	add dx,1
	sub bx,1
	jnz vn3
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

;-----------------------------------------PRINTING NOTE 4

printnote4:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 4
	mov di, [bp+4]
	add di,1+320*9			; 4 pixels right on x axis and 15 pixels down on y axis
	mov cx,3				; line is 11 pixels long horizontally (on x axis)
	
hn44:	
	mov byte [es:di],4
	add di,1
	loop hn44

;-----------------------vertical line of 4
	
	mov di, [bp+4]
	add di,3+320*7			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 
    mov al, 4
	
vn44:	
    mov byte [es:di],al
	add di,320
	loop vn44

	
	;----diagonal
	

	mov di, [bp+4]					; 7 pixels right on x axis while 3 pixels down on y
	add di,1+320*7
	mov cx,2
dn44:	
	mov byte [es:di],al
	add di,320
	loop dn44


	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

;----------------------------------------------PRINTING NOTE 5------------------------------------

printnote5:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 5
    
	
	mov ah,3
	mov dx,0

hn_5:	
	mov di, [bp+4]
	add di,7+320*7			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
hn55:	
	mov byte [es:di],al
	add di,1
	loop hn55
\
	
	add dx,320*2
	dec ah
	jnz hn_5
	

;-----------------------vertical line of 5


	mov di, [bp+4]
	add di, 7+320*7			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 3             ; 15 pixels getting printed down the y axis 
	
vn55:	
    mov byte [es:di],al
	add di,320
	loop vn55
	
	;-----
	
	
	mov di, [bp+4]
	add di ,10+320*9			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx,3         ; 15 pixels getting printed down the y axis 
	
vn_55:	
    mov byte [es:di],al
	add di,320
	loop vn_55


	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

;-------------------------------------PRINTING NOTE 6-------------------------------

printnote6:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 6
    
	
	mov ah,3
	mov dx,0
hn_6:
	
	mov di, [bp+4]
	add di,14+320*7			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320*2
	dec ah
	jnz hn_6

	

;-----------------------vertical line of 6

	mov di, [bp+4]
	add di,14+320*7	; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 	
vn66:	
    mov byte [es:di],al
	add di,320
	loop vn66

	;---------------------------------------------------
	mov di, [bp+4]
	add di,17+320*9		; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 2             ; 15 pixels getting printed down the y axis 	
vn_66:	
    mov byte [es:di],al
	add di,320
	loop vn_66

	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
;--------------------------------------------PRINTING NOTE 7

printnote7:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 7
    

	mov di, [bp+4]
	add di,1+320*13			; 4 pixels right on x axis and 15 pixels down on y axis
	mov cx,4				; line is 11 pixels long horizontally (on x axis)	
	rep stosb



;------------------print diagonal part of 7

    mov bx,4                  
    mov dx,0                    

dn7:
    mov di, [bp+4]              
    add di,4 + 320*14         
    add di,dx                   
	mov cx,1
    rep stosb 

    add dx,319                  
    dec bx                     
    jnz dn7  

	; mov bx,2
    ; mov dx,0                    

; dn_7:
    ; mov di, [bp+4]              
    ; add di,3 + 320*16         
    ; add di,dx                   
	; mov cx,1
    ; rep stosb 

    ; add dx,319                  
    ; dec bx                     
    ; jnz dn_7  	


	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
	;-------------------------------------PRINTING NOTE 8------------------------------------
	
printnote8:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 8
    
	
	mov ah,3
	mov dx,0

hn_8:	
	mov di, [bp+4]
	add di,7+320*13			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
	rep stosb

	
	add dx,320*2
	dec ah
	jnz hn_8
	

;-----------------------vertical line of 8


	mov di, [bp+4]
	add di, 7+320*13			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx, 5             ; 15 pixels getting printed down the y axis 
	
vn88:	
    mov byte [es:di],al
	add di,320
	loop vn88
	
	;-----
	
	
	mov di, [bp+4]
	add di ,10+320*13			; 8 pixels right on x axis / 2 pixels down on y axis
	mov cx,5         ; 15 pixels getting printed down the y axis 
	
vn_88:	
    mov byte [es:di],al
	add di,320
	loop vn_88


	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
	
	;-----------------------------------PRINTING NOTE 9-------------------------------------
	
printnote9:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
    mov ax, 0xA000
    mov es, ax
	mov al,4

;------------------horizontal line of 9
    
	
	mov ah,3
	mov dx,0

hn_9:	
	mov di, [bp+4]
	add di,14+320*13			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,4				; line is 11 pixels long horizontally (on x axis)
	
	rep stosb

	
	add dx,320*2
	dec ah
	jnz hn_9
	

;-----------------------vertical line of 9


	mov di, [bp+4]
	add di, 17+320*13			
	mov cx, 5             
	
vn99:	
    mov byte [es:di],al
	add di,320
	loop vn99
	
	;-----
	
	
	mov di, [bp+4]
	add di ,14+320*13			
	mov cx,3         
	
vn_99:	
    mov byte [es:di],al
	add di,320
	loop vn_99


	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
;-----------------------------------subroutines to print numbers-----------------------------------------------

;--------------------------------------PRINTING 0-------------------------------------
print0:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx

    mov ax, 0xA000
    mov es, ax
    mov al, 4

;------------------top horizontal line of 0

    mov ah, 2
    mov dx, 0
top_0:
    mov bx, 2                ; line is getting printed 2 times (up and down)

top_h0:    
    mov di, [bp+4]
    add di, 4 + 320 * 2      ; 4 pixels right on x axis and 2 pixels down on y axis
    add di, dx
    mov cx, 11               ; line is 11 pixels long horizontally (on x axis)
    rep stosb

    add dx, 320
    sub bx, 1
    jnz top_h0

    ; Add vertical space before bottom horizontal line
    add dx, 320 * 13
    dec ah
    jnz top_0

;------------------bottom horizontal line of 0

    mov ah, 2
    mov dx, 0
bottom_0:
    mov bx, 2                ; line is getting printed 2 times (up and down)

bottom_h0:    
    mov di, [bp+4]
    add di, 4 + 320 * 15     ; 4 pixels right on x axis and 15 pixels down on y axis
    add di, dx
    mov cx, 11               ; line is 11 pixels long horizontally (on x axis)
    rep stosb

    add dx, 320
    sub bx, 1
    jnz bottom_h0

;-----------------------vertical lines of 0

    mov dx, 0
    mov ah, 2

v_l0:    
    mov bx, 3                ; line is getting printed 3 times (side by side)

v0:    
    mov di, [bp+4]
    add di, 3 + 320 * 3      ; 3 pixels right on x axis / 3 pixels down on y axis
    add di, dx
    mov cx, 13               ; 13 pixels getting printed down the y axis 

v_l0_loop:    
    mov byte [es:di], al
    add di, 320
    loop v_l0_loop

    add dx, 1
    sub bx, 1
    jnz v0

    add dx, 7
    dec ah
    jnz v_l0

    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2


	
print1:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
    mov ax, 0xA000
    mov es, ax

;-----------------------vertical line of 1
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v1:	
	mov di, [bp+4]
	add di,8+320*2			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx,15               ; 15 pixels getting printed down the y axis 
    mov al, [bp+6]
	
v:	
    mov byte [es:di],al
	add di,320
	loop v
	
	add dx,1
	sub bx,1
	jnz v1

;------------------horizontal line of 1
    
	mov bx,2				; line is getting printed 2 times (up and down)
	mov dx,0
	
	
h1:	
	mov di, [bp+4]
	add di,4+320*15			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,11				; line is 11 pixels long horizontally (on x axis)
	
h:	
	mov byte [es:di],al
	add di,1
	loop h
	
	add dx,320
	sub bx,1
	jnz h1
	
;------------------print diagonal part of 1

	mov bx,3						; number of downward lines for diagonal
	mov dx,0
	
d1:	
	mov di, [bp+4]					; 7 pixels right on x axis while 3 pixels down on y
	add di,7+320*3
	add di,dx
	mov cx,3
d:	
	mov byte [es:di],al
	add di,320
	loop d
	
	add dx,319						; just starts from previous line and one pixel left on x axis
	sub bx,1
	jnz d1
	
	sub di,641							; printing the end of nose of 1 (does not need to change)
	mov byte [es:di],al
	add di,320
	mov byte [es:di],al
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

print2:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 2
    
	mov bx,2				; line is getting printed 2 times (up and down)
	mov dx,0
	
	
h2:	
	mov di, [bp+4]
	add di,3+320*2			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,13				; line is 11 pixels long horizontally (on x axis)
	
h22:	
	mov byte [es:di],al
	add di,1
	loop h22
	
	add dx,320
	sub bx,1
	jnz h2
	
	mov di, [bp+4]
	add di,3+320*4
	mov cx,3
	rep stosb
	
	
	
	mov bx,2
	mov dx,0
	
	
h2_:	
	mov di, [bp+4]
	add di,3+320*15			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,13				; line is 11 pixels long horizontally (on x axis)
	
h22_:	
	mov byte [es:di],al
	add di,1
	loop h22_
	
	add dx,320
	sub bx,1
	jnz h2_
	

;-----------------------vertical line of 2
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v2:	
	mov di, [bp+4]
	add di,13+320*2			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 6              ; 15 pixels getting printed down the y axis 
    
	
v22:	
    mov byte [es:di],al
	add di,320
	loop v22
	
	add dx,1
	sub bx,1
	jnz v2
;---
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v2_:	
	mov di, [bp+4]
	add di,3+320*13			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx,3              ; 15 pixels getting printed down the y axis 
    
	
v22_:	
    mov byte [es:di],al
	add di,320
	loop v22_
	
	add dx,1
	sub bx,1
	jnz v2_
;------------------print diagonal part of 2

	mov bx,6					; number of downward lines for diagonal
	mov dx,0
	
d2:	
	mov di, [bp+4]					; 7 pixels right on x axis while 3 pixels down on y
	add di,3+320*13
	add di,dx
	mov cx,3
d22:	
	mov byte [es:di],al
	inc di
	mov byte [es:di],al
	sub di,321
	loop d22
	
	sub dx,318					; just starts from previous line and one pixel left on x axis
	sub bx,1
	jnz d2
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

;-----------------------------------------------------------PRITNING 3=----------------------
print3:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 3
    
	
	mov ax,2
	mov dx,0
h_3:
	mov bx,2				; line is getting printed 2 times (up and down)
	
h3:	
	mov di, [bp+4]
	add di,2+320*2			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,13				; line is 11 pixels long horizontally (on x axis)
	
h33:	
	push ax
	mov al,[bp+6]
	mov byte [es:di],al
	pop ax
	add di,1
	loop h33
	
	add dx,320
	sub bx,1
	jnz h3
	
	add dx,320*11
	dec ax
	jnz h_3
	
	mov dx,0
	mov bx,2				; line is getting printed 2 times (up and down)
	
h3_:	
	mov di, [bp+4]
	add di,3+320*8			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,12				; line is 11 pixels long horizontally (on x axis)
	
h33_:	
	mov al,[bp+6]
	mov byte [es:di],al
	add di,1
	loop h33_
	
	add dx,320
	sub bx,1
	jnz h3_	
	

	

;-----------------------vertical line of 3
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v3:	
	mov di, [bp+4]
	add di,13+320*3			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 13             ; 15 pixels getting printed down the y axis 
    
	
v33:	
	mov al,[bp+6]
    mov byte [es:di],al
	add di,320
	loop v33
	
	add dx,1
	sub bx,1
	jnz v3
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

	;---------------------------------------------PRINTING 4-------------------------------------------------
print4:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 4
    
	
	mov dx,0
	mov bx,2				; line is getting printed 2 times (up and down)
	
h4:	
	mov di, [bp+4]
	add di,3+320*9			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,11				; line is 11 pixels long horizontally (on x axis)
	
h44:	
	mov byte [es:di],al
	add di,1
	loop h44
	
	add dx,320
	sub bx,1
	jnz h4
	
	

;-----------------------vertical line of 4
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v4:	
	mov di, [bp+4]
	add di,13+320*2			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 15              ; 15 pixels getting printed down the y axis 
    
	
v44:	
    mov byte [es:di],al
	add di,320
	loop v44
	
	add dx,1
	sub bx,1
	jnz v4
	
	;----diagonal
	
	mov bx,4						; number of downward lines for diagonal
	mov dx,0
	
d4:	
	mov di, [bp+4]					; 7 pixels right on x axis while 3 pixels down on y
	add di,7+320*2
	add di,dx
	mov cx,3
d44:	
	mov byte [es:di],al
	add di,320
	loop d44
	
	sub di,961
	mov cx,3
	
d44_2:	
	mov byte [es:di],al
	add di,320
	loop d44_2
	
	add dx,639						; just starts from previous line and one pixel left on x axis
	sub bx,1
	jnz d4
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

;------------------------------------------pprinting 5---------------------------

print5:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 5
    
	
	mov ah,2
	mov dx,0
h_5:
	mov bx,2				; line is getting printed 2 times (up and down)
	

h5:	
	mov di, [bp+4]
	add di,3+320*7			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,12				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h5
	
	add dx,320*6
	dec ah
	jnz h_5
	
	
	;---
	
	mov dx,0
	mov bx,2				; line is getting printed 2 times (up and down)
	
h5_:	
	mov di, [bp+4]
	add di,4+320*2			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,12				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h5_	
	

	

;-----------------------vertical line of 5
	mov dx,0
	mov ah,2
	
v_l5:	
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v5:	
	mov di, [bp+4]
	add di,3+320*3			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 6             ; 15 pixels getting printed down the y axis 
	
v55:	
    mov byte [es:di],al
	add di,320
	loop v55
	
	add dx,1
	sub bx,1
	jnz v5
	
	add dx,7+320*5
	dec ah
	jnz v_l5
	
	mov di, [bp+4]
	add di,13+320*14
	mov al,[bp+6]
	mov cx,3
	rep stosb
	add di,317
	mov cx,3
	rep stosb
	sub di,333
	mov cx,3
	rep stosb	

	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

;---------------------------------------------------------PrINTING 6-------------------------------------

print6:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 6
    
	
	mov ah,2
	mov dx,0
h_6:
	mov bx,2				; line is getting printed 2 times (up and down)
	

h6:	
	mov di, [bp+4]
	add di,3+320*7			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,12				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h6
	
	add dx,320*6
	dec ah
	jnz h_6

	;---
	
	mov dx,0
	mov bx,2				; line is getting printed 2 times (up and down)
	
h6_:	
	mov di, [bp+4]
	add di,3+320*2			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,12				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h6_	
	

	

;-----------------------vertical line of 6
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
		
v6:	
	mov di, [bp+4]
	add di,13+320*9		; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 7             ; 15 pixels getting printed down the y axis 
	
v66:	
    mov byte [es:di],al
	add di,320
	loop v66
	
	add dx,1
	sub bx,1
	jnz v6
	
	;---------------------------------------------------
	
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
		
v_6:	
	mov di, [bp+4]
	add di,2+320*3		; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 13             ; 15 pixels getting printed down the y axis 
	
v_66:	
    mov byte [es:di],al
	add di,320
	loop v_66
	
	add dx,1
	sub bx,1
	jnz v_6

	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4
	
;----------------------------------------------------PRINTING 7

print7:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 7
    
	mov bx,2				; line is getting printed 2 times (up and down)
	mov dx,0
	
	
h7:	
	mov di, [bp+4]
	add di,2+320*2			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,14				; line is 11 pixels long horizontally (on x axis)	
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h7
	
	mov di, [bp+4]
	add di,2+320*4
	mov cx,3
	rep stosb
	
;-----------------------vertical line of 7
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v7:	
	mov di, [bp+4]
	add di,13+320*2			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 3            ; 15 pixels getting printed down the y axis 
    
	
v77:	
    mov byte [es:di],al
	add di,320
	loop v77
	
	add dx,1
	dec bx
	jnz v7


;------------------print diagonal part of 7

    mov bx,11                  
    mov dx,0                    

d7:
    mov di, [bp+4]              
    add di,13 + 320*5         
    add di,dx                   
	mov cx,3
    rep stosb 
	add di,317
	mov cx,3
	rep stosb
	
    add dx,319                  
    dec bx                     
    jnz d7                      
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

;--------------------------------------PRINTING 8-------------------------------------
print8:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 8
    
	
	mov ah,2
	mov dx,0
h_8:
	mov bx,2				; line is getting printed 2 times (up and down)
	

h8:	
	mov di, [bp+4]
	add di,4+320*2			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,11				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h8
	
	add dx,320*4
	dec ah
	jnz h_8
	
	;----------------------------
	
	mov bx,2				; line is getting printed 2 times (up and down)
	mov dx,0

h_88:	
	mov di, [bp+4]
	add di,4+320*15			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,11				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h_88

;-----------------------vertical line of 5
	mov dx,0
	mov ah,2
	
v_l8:	
	mov bx,3				; line is getting printed 3 times (side by side)
	
	
v8:	
	mov di, [bp+4]
	add di,3+320*3			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 13             ; 15 pixels getting printed down the y axis 
	
v88:	
    mov byte [es:di],al
	add di,320
	loop v88
	
	add dx,1
	sub bx,1
	jnz v8
	
	add dx,7
	dec ah
	jnz v_l8
	
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

;-----------------------------------------Printing 9-------------------------------------

print9:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
    mov ax, 0xA000
    mov es, ax
	mov al,[bp+6]

;------------------horizontal line of 8
    
	
	mov ah,2
	mov dx,0
h_9:
	mov bx,2				; line is getting printed 2 times (up and down)
	

h9:	
	mov di, [bp+4]
	add di,3+320*2			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,12				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h9
	
	add dx,320*6
	dec ah
	jnz h_9
	
	;----------------------------
	
	mov bx,2				; line is getting printed 2 times (up and down)
	mov dx,0

h_99:	
	mov di, [bp+4]
	add di,3+320*15			; 4 pixels right on x axis and 15 pixels down on y axis
	add di,dx
	mov cx,11				; line is 11 pixels long horizontally (on x axis)
	rep stosb
	
	add dx,320
	sub bx,1
	jnz h_99

;-----------------------vertical line of 9
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)	
	
v9:	
	mov di, [bp+4]
	add di,13+320*3			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 13             ; 15 pixels getting printed down the y axis 
	
v99:	
    mov byte [es:di],al
	add di,320
	loop v99
	
	add dx,1
	sub bx,1
	jnz v9
	
	;------------------------
	
	mov dx,0
	mov bx,3				; line is getting printed 3 times (side by side)	
	
v_9:	
	mov di, [bp+4]
	add di,2+320*3			; 8 pixels right on x axis / 2 pixels down on y axis
	add di,dx
	mov cx, 8             ; 15 pixels getting printed down the y axis 
	
v_99:	
    mov byte [es:di],al
	add di,320
	loop v_99
	
	add dx,1
	sub bx,1
	jnz v_9

	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4

selection_box:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    
    mov ax, 0xA000
    mov es, ax
    mov al, 0
    
    mov di, [bp+4]
    mov bx, 10
    
selection_loop:
    mov cx, 60
    rep stosb 
    
    add di, 260
    sub bx, 1
    jnz selection_loop
    
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2

up_press:
    cmp di, 30520
	mov byte[level_choice], 1
    je start_loop_4
    sub di, 320*15
	mov byte[level_choice], 2
	cmp di, 35320
	jne up_press_end
	mov byte[level_choice], 3
	up_press_end:
    jmp start_loop_4

down_press:
    cmp di, 40120
	mov byte[level_choice], 3
    je start_loop_4
    add di, 320*15
	mov byte[level_choice], 2
	cmp di, 35320
	jne down_press_end
	mov byte[level_choice], 3
	down_press_end:
    jmp start_loop_4

start_screen:    
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    
  mov ax, 0xA000
    mov es, ax
	mov di,25*320
	add di,30
	mov bx,145
	mov al,14
	
start_loop_2:

	mov cx,260
	rep stosb 
	
	add di,60
	sub bx,1
	jnz start_loop_2
	
	
	
;---------------------------------------	

	mov al,0	
	mov di,35*320
	add di,40
	mov bx,125
	
start_loop:

	mov cx,240
	rep stosb 
	
	add di,80
	sub bx,1
	jnz start_loop
	

		
;------------------BOX---------------------
mov di,50*320
	add di,83
	mov bx,20
	mov al,4
	
start_loop_5:

	mov cx,155
	rep stosb 
	
	add di,165
	sub bx,1
	jnz start_loop_5
;------
mov di,53*320
	add di,86
	mov bx,14
	mov al,0
	
start_loop_6:

	mov cx,149
	rep stosb 
	
	add di,171
	sub bx,1
	jnz start_loop_6

	
    
mov di,95*320
	add di,120
	
start_loop_4:   
	
	call Message
    call Easy
    call Medium
    call Hard
	
	call sleep2
	call sleep2
	call sleep2
	
	push di
	call selection_box
	call sleep2
	call sleep2
    call sleep2
	call sleep2
	
    mov ah, 0x01       
    int 0x16  				
    jz start_loop_4    
   
    mov ah, 0           
    int 0x16    
    cmp ah, 0x48         
    je up_press           
    cmp ah, 0x50         
    je down_press     
    cmp al, 'w'         
    je up_press           
    cmp al, 's'         
    je down_press   
    cmp al, 0x0D         ; Check for Enter key press
    je end_start         ; Enter was pressed twice

    jmp start_loop_4

end_start:    
	cmp di, 30520
	mov byte[level_choice], 1
	cmp di, 35320
	jne nextLevelChoice
	mov byte[level_choice], 2
	nextLevelChoice:
    cmp di, 40120
	jne nextLevelChoice2
	mov byte[level_choice], 3
	nextLevelChoice2:


   
    ;call music
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret

	
Display_Array:
	push ax
	push bx
	push dx
	push cx
	push si
	
	
	
	xor ax, ax
	xor bx, bx
	
	mov cx, 0
	mov si, locations
	
	
displayArrayLoop:
	
	mov bx, third_array
	add bx, [i]
	mov al, [bx]
	mov bx, color
	add bx,[i]
	push word [bx]
	pop bx
	cmp al, 1
	jne next1
	mov dx, [si]		;	top left pixel of first box
	push bx
	push dx
	call print1
	jmp exitDisplayArray
	
	next1:
	
	cmp al, 2
	jne next2
	mov dx, [si]
	push bx
	push dx
	call print2
	jmp exitDisplayArray
	
	next2:
	
	cmp al, 3
	jne next3
	mov dx, [si]
	push bx
	push dx
	call print3
	jmp exitDisplayArray
	
	next3:
	
	cmp al, 4
	jne next4
	mov dx, [si]	
	push bx
	push dx
	call print4
	jmp exitDisplayArray
	
	next4:
	
	cmp al, 5
	jne next5
	mov dx, [si]	
	push bx
	push dx
	call print5
	jmp exitDisplayArray
	
	next5:
	
	cmp al, 6
	jne next6
	mov dx, [si]	
	push bx
	push dx
	call print6
	jmp exitDisplayArray
	
	next6:
	
	cmp al, 7
	jne next7
	mov dx, [si]		
	push bx
	push dx
	call print7
	jmp exitDisplayArray
	
	next7:
	
	cmp al, 8
	jne next8
	mov dx, [si]	
	push bx
	push dx
	call print8
	jmp exitDisplayArray
	
	next8:
	
	cmp al, 9
	jne exitDisplayArray
	mov dx, [si]	
	push bx
	push dx
	call print9
	
	
exitDisplayArray:
	
	add si, 2
	add byte[i], 1
	
	add cx, 1
	cmp cx, 81
	je byebye
	jmp displayArrayLoop
	
	byebye:
	mov byte[i], 0	
	
	
	pop si
	pop cx
	pop dx
	pop bx
	pop ax
	ret


; EASY LEVEL
easyLevel:
	
	push si
	push dx
	push ax
	push bx
	push cx
	push di
	
	
	;call clear_screen
	
	mov byte[array], 1
	mov byte[array+1], 8
	mov byte[array+2], 5
	mov byte[array+3], 9
	mov byte[array+4], 4
	mov byte[array+5], 3
	mov byte[array+6], 6
	mov byte[array+7], 7
	mov byte[array+8], 2
	mov byte[array+10], 2
	mov byte[array+11], 6
	mov byte[array+12], 7
	mov byte[array+24], 9
	mov byte[array+25], 5
	mov byte[array+26], 1
	mov byte[array+27], 4
	mov byte[array+29], 8
	mov byte[array+30], 5
	mov byte[array+31], 9
	mov byte[array+32], 1
	mov byte[array+33], 3
	mov byte[array+34], 2
	mov byte[array+38], 1
	mov byte[array+39], 4
	mov byte[array+40], 3
	mov byte[array+41], 7
	mov byte[array+42], 8
	mov byte[array+45], 7
	mov byte[array+46], 3
	mov byte[array+49], 6
	mov byte[array+50], 8
	mov byte[array+52], 4
	mov byte[array+53], 5
	mov byte[array+56], 2
	mov byte[array+58], 8
	mov byte[array+59], 4
	mov byte[array+60], 7
	mov byte[array+61], 9
	mov byte[array+62], 6
	mov byte[array+63], 8
	mov byte[array+64], 9
	mov byte[array+66], 6
	mov byte[array+68], 2
	mov byte[array+70], 1
	mov byte[array+72], 6
	mov byte[array+73], 7
	mov byte[array+74], 3
	mov byte[array+77], 9
	mov byte[array+78], 2
	mov byte[array+80], 4
	
	mov byte[color], 0
	mov byte[color+1], 0
	mov byte[color+2], 0
	mov byte[color+3], 0
	mov byte[color+4], 0
	mov byte[color+5], 0
	mov byte[color+6], 0
	mov byte[color+7], 0
	mov byte[color+8], 0
	mov byte[color+10], 0
	mov byte[color+11], 0
	mov byte[color+12], 0
	mov byte[color+24], 0
	mov byte[color+25], 0
	mov byte[color+26], 0
	mov byte[color+27], 0
	mov byte[color+29], 0
	mov byte[color+30], 0
	mov byte[color+31], 0
	mov byte[color+32], 0
	mov byte[color+33], 0
	mov byte[color+34], 0
	mov byte[color+38], 0
	mov byte[color+39], 0
	mov byte[color+40], 0
	mov byte[color+41], 0
	mov byte[color+42], 0
	mov byte[color+45], 0
	mov byte[color+46], 0
	mov byte[color+49], 0
	mov byte[color+50], 0
	mov byte[color+52], 0
	mov byte[color+53], 0
	mov byte[color+56], 0
	mov byte[color+58], 0
	mov byte[color+59], 0
	mov byte[color+60], 0
	mov byte[color+61], 0
	mov byte[color+62], 0
	mov byte[color+63], 0
	mov byte[color+64], 0
	mov byte[color+66], 0
	mov byte[color+68], 0
	mov byte[color+70], 0
	mov byte[color+72], 0
	mov byte[color+73], 0
	mov byte[color+74], 0
	mov byte[color+77], 0
	mov byte[color+78], 0
	mov byte[color+79], 0
	mov byte[color+80], 0
	
	call Display_Array

	mov si, easysolvedarray      
	mov di, solvedarray       
	mov cx, 81                

fill_loop:
    mov al, [si]          
    mov [di], al          
    inc si               
    inc di               
    loop fill_loop    
    
	
    call fill_

	cmp byte [first_],1
	jne skip_first
	add byte [points],50
	mov byte[first_],0
	
skip_first:

	pop di
	pop cx
	pop bx
	pop ax
	pop dx
	pop si
    ret
	
mediumLevel:
	
	push si
	push dx
	push ax
	push bx
	push cx
	push di
	;call clear_screen
	
	mov byte[array+1], 5
	mov byte[array+4], 7
	mov byte[array+7], 8
	mov byte[array+9], 8
	mov byte[array+11], 9
	mov byte[array+12], 5
	mov byte[array+17], 7
	mov byte[array+18], 7
	mov byte[array+19], 3
	mov byte[array+23], 4
	mov byte[array+27], 1
	mov byte[array+28], 7
	mov byte[array+31], 2
	mov byte[array+32], 5
	mov byte[array+33], 6
	mov byte[array+34], 4
	mov byte[array+35], 9
	mov byte[array+40], 9
	mov byte[array+41], 8
	mov byte[array+42], 7
	mov byte[array+43], 3
	mov byte[array+44], 5
	mov byte[array+46], 9
	mov byte[array+47], 3
	mov byte[array+51], 8
	mov byte[array+52], 1
	mov byte[array+57], 4
	mov byte[array+58], 5
	mov byte[array+61], 2
	mov byte[array+62], 8
	mov byte[array+64], 1
	mov byte[array+65], 2
	mov byte[array+66], 8
	mov byte[array+67], 6
	mov byte[array+70], 7
	mov byte[array+72], 3
	mov byte[array+73], 8
	mov byte[array+74], 5
	mov byte[array+75], 7
	mov byte[array+76], 1
	mov byte[array+79], 9
	mov byte[array+80], 6
	
	mov byte[color+1], 0
	mov byte[color+4], 0
	mov byte[color+7], 0
	mov byte[color+9], 0
	mov byte[color+11], 0
	mov byte[color+12], 0
	mov byte[color+17], 0
	mov byte[color+18], 0
	mov byte[color+19], 0
	mov byte[color+23], 0
	mov byte[color+27], 0
	mov byte[color+28], 0
	mov byte[color+31], 0
	mov byte[color+32], 0
	mov byte[color+33], 0
	mov byte[color+34], 0
	mov byte[color+35], 0
	mov byte[color+40], 0
	mov byte[color+41], 0
	mov byte[color+42], 0
	mov byte[color+43], 0
	mov byte[color+44], 0
	mov byte[color+46], 0
	mov byte[color+47], 0
	mov byte[color+51], 0
	mov byte[color+52], 0
	mov byte[color+57], 0
	mov byte[color+58], 0
	mov byte[color+61], 0
	mov byte[color+62], 0
	mov byte[color+64], 0
	mov byte[color+65], 0
	mov byte[color+66], 0
	mov byte[color+67], 0
	mov byte[color+70], 0
	mov byte[color+72], 0
	mov byte[color+73], 0
	mov byte[color+74], 0
	mov byte[color+75], 0
	mov byte[color+76], 0
	mov byte[color+79], 0
	mov byte[color+80], 0
	
	
	call Display_Array

    mov si, mediumsolvedarray      
	mov di, solvedarray       
	mov cx, 81                

fill_loop_2:
    mov al, [si]          
    mov [di], al          
    inc si               
    inc di               
    loop fill_loop_2    
    
    call fill_

	cmp byte [first_],1
	jne skip_first_
	add byte [points],42
	mov byte[first_],0
	
skip_first_:


	pop di
	pop cx
	pop bx
	pop ax
	pop dx
	pop si
    ret

extremeLevel:
	
	push si
	push dx
	push ax
	push bx
	push cx
	push di
	;call clear_screen
	
	mov byte[array], 4
	mov byte[array+6], 6
	mov byte[array+12], 8
	mov byte[array+13], 7
	mov byte[array+20], 9
	mov byte[array+27], 5
	mov byte[array+30], 6
	mov byte[array+31], 2
	mov byte[array+37], 8
	mov byte[array+44], 9
	mov byte[array+51], 3
	mov byte[array+55], 7
	mov byte[array+56], 3
	mov byte[array+59], 9
	mov byte[array+69], 4
	mov byte[array+70], 5
	mov byte[array+79], 6
	
	; mov byte[array+44], 9
	; mov byte[array+51], 3
	; mov byte[array+55], 7
	; mov byte[array+56], 3
	; mov byte[array+59], 9
	; mov byte[array+69], 4
	; mov byte[array+70], 5
	; mov byte[array+79], 6
	
	
	mov byte[color], 0
	mov byte[color+6], 0
	mov byte[color+12], 0
	mov byte[color+13], 0
	mov byte[color+20], 0
	mov byte[color+27], 0
	mov byte[color+30], 0
	mov byte[color+31], 0
	mov byte[color+37], 0
	mov byte[color+44], 0
	mov byte[color+51], 0
	mov byte[color+55], 0
	mov byte[color+56], 0
	mov byte[color+59], 0
	mov byte[color+69], 0
	mov byte[color+70], 0
	mov byte[color+79], 0
	
	call Display_Array

    mov si, extremesolvedarray      
	mov di, solvedarray       
	mov cx, 81                

fill_loop_3:
    mov al, [si]          
    mov [di], al          
    inc si               
    inc di               
    loop fill_loop_3    
    
	call fill_
    
	cmp byte [first_],1
	jne skip_first_1
	add byte [points],17
	mov byte[first_],0
	
skip_first_1:

	pop di
	pop cx
	pop bx
	pop ax
	pop dx
	pop si
    ret


printAscii:
    push bp
    mov bp, sp
    push ax
    push bx
    push dx
    push cx

    mov ch, [bp+4]
    mov cl, [bp+6]
	mov dh, [bp+8]

    mov ah, 0x02         ; BIOS function: Set cursor position
    mov bh, 0            ; Page number
    mov dh, dh           ; Row
    mov dl, ch           ; Column
    int 0x10             ; Call BIOS interrupt to set cursor

    mov al, cl           ; Load the character from the string into AL
    mov ah, 0x0E         ; BIOS function: Teletype output (print character)
    mov bl, 0x0F         ; Set text color
    int 0x10

    pop cx
    pop dx
    pop bx
    pop ax
    pop bp 
    ret 6

timer:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [t] 
    mov bx, 26           ; Column 
    mov cx, 6           ; Length of the string
	mov dx, 2
	;push dx
printMessage:
    mov al, [si]
    cmp al, 0 
    je donePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop printMessage    

donePrinting:
	
	

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret

scoreCount:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [s] 
    mov bx, 26           ; Column 
    mov cx, 6           ; Length of the string
	mov dx, 4
	;push dx
sprintMessage:
    mov al, [si]
    cmp al, 0 
    je sdonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop sprintMessage    

sdonePrinting:
	mov di, 7296+10+320*10
	
	
		mov ax,[score_count]
		mov bx,10
		mov cx,0
nd:
		mov dx,0
		div bx
		;add dl,0x30
		push dx
		inc cx
		cmp ax,0
		jnz nd
		
		;mov di,0
		
np:
		pop dx
		mov dh, 0x40
		
		cmp dl, 0
		jne n1
		push di
		call tprintnote0
		
		n1:
		cmp dl, 1
		jne n2
		push di
		call tprintnote1
		
		n2:
		cmp dl, 2
		jne n3
		push di
		call tprintnote2
		
		n3:
		cmp dl, 3
		jne n4
		push di
		call tprintnote3
		
		n4:
		cmp dl, 4
		jne n5
		push di
		call tprintnote4
		
		n5:
		cmp dl, 5
		jne n6
		push di
		call tprintnote5
		
		n6:
		cmp dl, 6
		jne n7
		push di
		call tprintnote6
		
		n7:
		cmp dl, 7
		jne n8
		push di
		call tprintnote7
		
		n8:
		cmp dl, 8
		jne n9
		push di
		call tprintnote8
		
		n9:
		cmp dl, 9
		jne n10
		push di
		call tprintnote9
		
		n10:
		
		;mov [es:di],dx
		add di,6
		loop np

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret 
printmistake:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax
	
	mov di,[bp+4]
	mov ax,[mistake_count]
	
	
cmp ax, 0
jne s_
push di
call tprintnote0

s_:
cmp ax, 1
jne s_1
push di
call tprintnote1

s_1:
cmp ax, 2
jne s_2
push di
call tprintnote2

s_2:
cmp ax, 3
jne s_3
push di
call tprintnote3

s_3:
cmp ax, 4
jne s_4
push di
call tprintnote4

s_4:
cmp ax, 5
jne s_5
push di
call tprintnote5

s_5:
cmp ax, 6
jne s_6
push di
call tprintnote6

s_6:
cmp ax, 7
jne s_7
push di
call tprintnote7

s_7:
cmp ax, 8
jne s_8
push di
call tprintnote8

s_8:
cmp ax, 9
jne s_9
push di
call tprintnote9

s_9:


	
	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret 2
mistakes:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [m] 
    mov bx, 26           ; Column 
    mov cx, 9           ; Length of the string
	mov dx, 6
	;push dx
mprintMessage:
    mov al, [si]
    cmp al, 0 
    je mdonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop mprintMessage    

mdonePrinting:
	mov ax, 12443+320*11
	push ax
	call printmistake

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret

faceCards:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax
	mov bx,0

	mov ax, 24530      ;first row of face cards
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print1
	add ax, 35
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print2
	add ax, 35
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print3


	mov ax, 37330
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print4
	add ax, 35
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print5
	add ax, 35
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print6




	mov ax, 50130
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print7
	add ax, 35
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print8
	add ax, 35
	push ax 
	call clear_box_yellow
	push bx
	push ax
	call print9


	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret 

undo:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [u] 
    mov bx, 29           ; Column 
    mov cx, 6          ; Length of the string
	mov dx, 23
	;push dx
uprintMessage:
    mov al, [si]
    cmp al, 0 
    je udonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop uprintMessage    

udonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret
	
	
	
game_over:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [over] 
    mov bx, 15           ; Column 
    mov cx, 9           ; Length of the string
	mov dx, 11
gprintMessage:
    mov al, [si]
    cmp al, 0 
    je gdonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop gprintMessage    

gdonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret


Message:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [mess] 
    mov bx, 11           ; column 
    mov cx, 18           ; length of the string
	mov dx, 7			;row	
msgprintMessage:
    mov al, [si]
    cmp al, 0 
    je msgdonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop msgprintMessage    

msgdonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret

Easy:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [easy] 
    mov bx, 17           ; Column 
    mov cx, 4            ; Length of the string
	mov dx,12
	;push dx
eprintMessage:
    mov al, [si]
    cmp al, 0 
    je edonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop eprintMessage    

edonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret

Medium:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [med] 
    mov bx, 16           ; Column 
    mov cx, 6            ; Length of the string
	mov dx, 14
medprintMessage:
    mov al, [si]
    cmp al, 0 
    je meddonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop medprintMessage    

meddonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret
	
	

game_won:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [win] 
    mov bx, 12           ; Column 
    mov cx, 18            ; Length of the string
	mov dx, 11
winprintMessage:
    mov al, [si]
    cmp al, 0 
    je windonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop winprintMessage    

windonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret	
	

Hard:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [hard] 
    mov bx, 17           ; Column 
    mov cx, 4            ; Length of the string
	mov dx, 16
	;push dx
hprintMessage:
    mov al, [si]
    cmp al, 0 
    je hdonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop hprintMessage    

hdonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret

Button:
	push bp
	mov bp, sp
	push si
	push bx
	push cx
	push dx
	push ax

	lea si, [new] 
    mov bx, 15           ; Column 
    mov cx, 10           ; Length of the string
	mov dx,11
	;push dx
bprintMessage:
    mov al, [si]
    cmp al, 0 
    je bdonePrinting 

	push dx
    push ax         
    push bx          
    call printAscii      

    inc si             
    inc bx          
    loop bprintMessage    

bdonePrinting:

	pop ax
	pop dx
	pop cx
	pop bx
	pop si
	pop bp
	ret


clear_screen:

mov ax, 0xA000
    mov es, ax
    mov di, 0 
    mov cx, 320*200
    mov al, 9
	rep stosb
	ret
	
inc_21_vert:

	add byte[pos],9
	add byte[row],9
	add word[position],9
	
	 add di,21*320
	 mov ax,di
	 mov [loc],ax
	 jmp game
	 
	 
inc_21_hor:

	add byte[pos],1
	add byte[col],1
	add word[position],1
	
	add di,21
	mov ax,di
	 mov [loc],ax
	jmp game
dec_21_vert:

	sub byte[pos],9
	sub byte[row],9
	sub word[position],9
	
	sub di,21*320
	mov ax,di
	 mov [loc],ax
	jmp game
dec_21_hor:

	sub byte[pos],1
	sub byte[col],1
	sub word[position],1
	
	sub di,21
	mov ax,di
	 mov [loc],ax
	jmp game

clear_box_blue:

	push bp
    mov bp, sp
    push es    
    push cx
    push ax
	push dx
	push di
	
    mov ax, 0xA000
    mov es, ax
	mov al,9
	
	mov di,[bp+4]
	mov bx,19
	
clear_loop_2:

	mov cx,19
	rep stosb 
	
	add di,301
	sub bx,1
	jnz clear_loop_2
	
	pop di
	pop dx
	pop ax
    pop cx 
    pop es
    pop bp
    ret 2
	
	
clear_box_yellow:

	push bp
    mov bp, sp
    push es    
    push cx
    push ax
	push dx
	push di
	
    mov ax, 0xA000
    mov es, ax
	mov al,14
	
	mov di,[bp+4]
	mov bx,19
	
clear_loop:

	mov cx,19
	rep stosb 
	
	add di,301
	sub bx,1
	jnz clear_loop
	
	; mov di,[bp+4]
	; add di,15*320
	; add di,4
	; mov al,14	
	; mov bx,2
	
; cursor_loop:

	; mov cx,11
	; rep stosb 
	
	; add di,309
	; sub bx,1
	; jnz cursor_loop
	
	pop di
	pop dx
	pop ax
    pop cx 
    pop es
    pop bp
    ret 2
	
	
up_key:

    add di, 0
    mov si, up1
    mov cx, 9

up_loop:
    mov ax, [si]
    cmp di, ax
    je game

    add si, 2
    loop up_loop

    mov si, up2
    mov cx, 18

up_loop_2:
    mov ax, [si]
    cmp di, ax
    je dec_21_vert

    add si, 2
    loop up_loop_2

	sub byte[pos],9
	sub byte[row],9
	sub word[position],9
	
    sub di, 320 * 20
    mov ax, di
    mov [loc], ax
    jmp game


	
down_key:

	push ax
	push si
	push cx
	
	add di,0
	
	mov si,  down1   
    mov cx, 9          
    
down_loop:
    mov ax, [si]       
    cmp di, ax         
    je game    
    
    add si, 2          
    loop down_loop   
		
;---------------------------------
	mov si,  down2  
    mov cx, 18          
    
down_loop_2:
    mov ax, [si]       
    cmp di, ax         
    je inc_21_vert   
    
    add si, 2          
    loop down_loop_2 
	
	pop cx
	pop si
	pop ax
	
	add byte[pos],9
	add byte[row],9
	add word[position],9
	
	
	add di,320*20
	mov ax,di
	mov [loc],ax
	jmp game
	
left_key:

    add di, 0

    mov si, left1
    mov cx, 9

left_loop:
    mov ax, [si]
    cmp di, ax
    je game

    add si, 2
    loop left_loop

    mov si, left2
    mov cx, 18

left_loop_2:
    mov ax, [si]
    cmp di, ax
    je dec_21_hor

    add si, 2
    loop left_loop_2

	sub byte[pos],1
	sub byte[col],1
	sub word[position],1
	
    sub di, 20
    mov ax, di
    mov [loc], ax
    jmp game

right_key:

    add di, 0

    mov si, right1
    mov cx, 9

right_loop:
    mov ax, [si]
    cmp di, ax
    je game

    add si, 2
    loop right_loop

    mov si, right2
    mov cx, 18

right_loop_2:
    mov ax, [si]
    cmp di, ax
    je inc_21_hor

    add si, 2
    loop right_loop_2

	add byte[pos],1
	add byte[col],1
	add word [position],1 
    add di, 20
    mov ax, di
    mov [loc], ax
    jmp game



check_mistake:

	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    push bx
	push si
	
	mov bx,[pos]
	sub bx,2
	
	
	mov ax,[solvedarray+bx]
	mov [array+bx],ax
	add bx,1	
	mov dx,[array+bx]
	;add bx,1
	mov ax,[solvedarray+bx]
	cmp ax,dx
	je correct
	dec bx
	mov word [array+bx],0
    add bx,2
	mov byte [color+bx],4
	inc byte [mistake_count]
	
	
	
	
	pop si
	pop bx
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
	add sp,2
	jmp cont
	
correct:
	dec bx
	mov word [array+bx],0
	add word[score_count], 10
	pop si
	pop bx
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 




p1:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn1
	add word [moves],8
    mov word [array+bx], 1
	mov word [third_array+bx],1
	call check_mistake
	call fill2
    mov byte [color+bx], 1
	inc byte [points]
	mov word [check_array+bx],1
	
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl1:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl1

    pop si
    pop cx
    pop di
    pop bx
    jmp cont

pn1:
	pop bx
    imul bx, 18
    add bx, 0
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 1
    mov byte [flag], 0
    pop bx
    jmp cont

p2:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn2
	add word [moves],8
    mov word [array+bx], 2
	mov word [third_array+bx],2
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],2
	call fill2
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl2:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl2

    pop si
    pop cx
    pop di
    pop bx
    jmp cont

pn2:
	pop bx
    imul bx, 18
    add bx, 2
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 2
    mov byte [flag], 0
    pop bx
    jmp cont

p3:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn3
	add word [moves],8
    mov word [array+bx], 3
	mov word [third_array+bx],3
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],3
	call fill2
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl3:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl3

    pop si
    pop cx
    pop di
    pop bx
    jmp cont

pn3:
	pop bx
    imul bx, 18
    add bx, 4
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 3
    mov byte [flag], 0
    pop bx
    jmp cont

p4:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn4
	add word [moves],8
    mov word [array+bx], 4
	mov word [third_array+bx],4
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],4
	call fill2
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl4:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl4

    pop si
    pop cx
    pop di
    pop bx
    jmp cont

pn4:
	pop bx
    imul bx, 18
    add bx, 6
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 4
    mov byte [flag], 0
    pop bx
    jmp cont

p5:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn5
	add word [moves],8
    mov word [array+bx], 5
	mov word [third_array+bx],5
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],5
	call fill2
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl5:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl5

    pop si
    pop cx
    pop di
    pop bx
    jmp cont

pn5:
	pop bx
    imul bx, 18
    add bx, 8
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 5
    mov byte [flag], 0
    pop bx
    jmp cont

p6:

    push bx
	push di
	push cx
	push si
    mov bx, [pos]

	push bx
	
    cmp byte [flag], 0
    jne pn6
	add word [moves],8
    mov word [array+bx], 6
	mov word [third_array+bx],6
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],6
	call fill2
    call Check_row
    call Check_col
    call Check_box
	;--------removing notes
	pop bx
	mov cx,18
	imul bx,18
	mov di,0
	mov si,notes_array
	add si,bx
pl6:
	mov word[si],0
	add si,di
	add di,1 
	loop pl6
	
	
	pop si
	pop cx
	pop di
    pop bx
    jmp cont

pn6:
	pop bx
	imul bx,18
	add bx,10
	cmp byte [notes_array+bx],0
	jne cont
    mov word [notes_array+bx], 6
    mov byte [flag], 0
    pop bx
    jmp cont

p7:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn7
	add word [moves],8
    mov word [array+bx], 7
	mov word [third_array+bx],7
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],7
	call fill2
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl7:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl7

    pop si
    pop cx
    pop di
    pop bx
    jmp cont
	
pn7:
	pop bx
	mov bx,[pos]
	
    imul bx, 18
    add bx, 12
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 7
    mov byte [flag], 0
    pop bx
    jmp cont
p8:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn8
	add word [moves],8
    mov word [array+bx], 8
	mov word [third_array+bx],8
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],8
	call fill2
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl8:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl8

    pop si
    pop cx
    pop di
    pop bx
    jmp cont

pn8:
	pop bx
    imul bx, 18
    add bx, 14
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 8
    mov byte [flag], 0
    pop bx
    jmp cont

p9:
    push bx
    push di
    push cx
    push si
    mov bx, [pos]
    push bx

    cmp byte [flag], 0
    jne pn9
	add word [moves],8
    mov word [array+bx], 9
	mov word [third_array+bx],9
	call check_mistake
	inc byte [points]
    mov byte [color+bx], 1
	mov word [check_array+bx],9
	call fill2
    call Check_row
    call Check_col
    call Check_box

    ; Remove notes
    pop bx
    mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl9:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl9

    pop si
    pop cx
    pop di
    pop bx
    jmp cont

pn9:
	pop bx
    imul bx, 18
    add bx, 16
    cmp byte [notes_array+bx], 0
    jne cont
    mov word [notes_array+bx], 9
    mov byte [flag], 0
    pop bx
    jmp cont

	

p0:
	push bx
    push di
    push cx
    push si
	
	;call speakerOn
	mov bx,[pos]
	mov byte [array+bx], 0
	mov word [check_array+bx],0
	call fill2
	mov word [third_array+bx],0
	dec byte [points]
	mov cx, 18
    imul bx, 18
    mov di, 0
    mov si, notes_array
    add si, bx
pl0:
    mov word [si], 0
    add si, di
    add di, 1
    loop pl0
	
	pop si
    pop cx
    pop di
    pop bx
	jmp cont
	
row_completion:

	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
	mov di,[bp+4]
	push di
	
	;call music
	;-----------first yellow
	call speakerOn
	mov ax,3
	
row_loop_1:
	mov cx,2
	
row_loop_2:
	
	call Display_Array			
	push di
	call clear_box_yellow
	add di,20
	call blink
	loop row_loop_2
	
	push di
	call clear_box_yellow
	add di,21
	sub ax,1
	jnz row_loop_1
	
	call Display_Array
	call blink
	call blink
;----------------then blue
	pop di
	
	
	mov ax,3
	
row_loop_3:
	mov cx,2
	
row_loop_4:
	
	call Display_Array		
	push di
	call clear_box_blue
	add di,20
	call blink
	loop row_loop_4
	
	push di
	call clear_box_blue
	add di,21
	sub ax,1
	jnz row_loop_3	
	
	call speakerOff
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
	
col_completion:

	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
	mov di,[bp+4]
	push di
	;-----------first yellow
	call speakerOn
	mov ax,3
	
col_loop_1:
	mov cx,2
	
col_loop_2:
	
	call Display_Array				
	push di
	call clear_box_yellow
	add di,20*320
	call blink
	loop col_loop_2
	
	push di
	call clear_box_yellow
	add di,21*320
	sub ax,1
	jnz col_loop_1
	
	call Display_Array
	call blink
	call blink
;----------------then blue
	pop di
	
	
	mov ax,3
	
col_loop_3:
	mov cx,2
	
col_loop_4:
	
	call Display_Array
	push di
	call clear_box_blue
	add di,20*320
	call blink
	loop col_loop_4
	
	push di
	call clear_box_blue
	add di,21*320
	sub ax,1
	jnz col_loop_3	
	
	call speakerOff
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2	
	;-------------
box_completion:

	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
	mov di,[bp+4]
	push di
	;-----------first yellow
	call speakerOn
	mov ax,3
	
box_loop_1:
	mov cx,2
	
box_loop_2:
	
	call Display_Array
	push di
	call clear_box_yellow
	add di,20
	call blink
	loop box_loop_2
	
	push di
	call clear_box_yellow
	add di,6360
	sub ax,1
	jnz box_loop_1
	
	call Display_Array
	call blink
	call blink
;----------------then blue
	pop di
	
	
	mov ax,3
	
box_loop_3:
	mov cx,2
	
box_loop_4:
	
	call Display_Array
	push di
	call clear_box_blue
	add di,20
	call blink
	loop box_loop_4
	
	push di
	call clear_box_blue
	add di,6360
	sub ax,1
	jnz box_loop_3	
	
	call speakerOff
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 2
	
Check_row:
	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
	
	mov si,third_array
	
	mov bx,[pos]
	sub bx,[col]
	add si,bx
	
	mov cx,9

check_row_loop:

	cmp byte [si],0			;chk first row
	je not_comp_row

	inc si
	loop check_row_loop
	
	shl bx,1
	mov dx,[locations+bx]
	push dx
	call row_completion
	
not_comp_row:
		
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 
	
Check_col:
	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
	push dx
	push bx
	
	
	mov si,third_array
	
	mov bx,[pos]
	sub bx,[row]
	add si,bx
	
	mov cx,9

check_col_loop:

	cmp byte [si],0			;chk first row
	je not_comp_col

	add si,9
	loop check_col_loop
	
	shl bx,1
	mov dx,[locations+bx]
	push dx
	call col_completion
	
not_comp_col:
		
	
	pop bx
	pop dx
	pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 

Check_box:
    push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    push bx
    
    mov bx, [pos]

    ; Box 1
    cmp bx, 0
    je first
    cmp bx, 1
    je first
    cmp bx, 2
    je first
    cmp bx, 9
    je first
    cmp bx, 10
    je first
    cmp bx, 11
    je first
    cmp bx, 18
    je first
    cmp bx, 19
    je first
    cmp bx, 20
    je first

    ; Box 2
    cmp bx, 3
    je second
    cmp bx, 4
    je second
    cmp bx, 5
    je second
    cmp bx, 12
    je second
    cmp bx, 13
    je second
    cmp bx, 14
    je second
    cmp bx, 21
    je second
    cmp bx, 22
    je second
    cmp bx, 23
    je second

    ; Box 3
    cmp bx, 6
    je third
    cmp bx, 7
    je third
    cmp bx, 8
    je third
    cmp bx, 15
    je third
    cmp bx, 16
    je third
    cmp bx, 17
    je third
    cmp bx, 24
    je third
    cmp bx, 25
    je third
    cmp bx, 26
    je third

    ; Box 4
    cmp bx, 27
    je fourth
    cmp bx, 28
    je fourth
    cmp bx, 29
    je fourth
    cmp bx, 36
    je fourth
    cmp bx, 37
    je fourth
    cmp bx, 38
    je fourth
    cmp bx, 45
    je fourth
    cmp bx, 46
    je fourth
    cmp bx, 47
    je fourth

    ; Box 5
    cmp bx, 30
    je fifth
    cmp bx, 31
    je fifth
    cmp bx, 32
    je fifth
    cmp bx, 39
    je fifth
    cmp bx, 40
    je fifth
    cmp bx, 41
    je fifth
    cmp bx, 48
    je fifth
    cmp bx, 49
    je fifth
    cmp bx, 50
    je fifth

    ; Box 6
    cmp bx, 33
    je sixth
    cmp bx, 34
    je sixth
    cmp bx, 35
    je sixth
    cmp bx, 42
    je sixth
    cmp bx, 43
    je sixth
    cmp bx, 44
    je sixth
    cmp bx, 51
    je sixth
    cmp bx, 52
    je sixth
    cmp bx, 53
    je sixth

    ; Box 7
    cmp bx, 54
    je seventh
    cmp bx, 55
    je seventh
    cmp bx, 56
    je seventh
    cmp bx, 63
    je seventh
    cmp bx, 64
    je seventh
    cmp bx, 65
    je seventh
    cmp bx, 72
    je seventh
    cmp bx, 73
    je seventh
    cmp bx, 74
    je seventh

    ; Box 8
    cmp bx, 57
    je eighth
    cmp bx, 58
    je eighth
    cmp bx, 59
    je eighth
    cmp bx, 66
    je eighth
    cmp bx, 67
    je eighth
    cmp bx, 68
    je eighth
    cmp bx, 75
    je eighth
    cmp bx, 76
    je eighth
    cmp bx, 77
    je eighth

    ; Box 9
    cmp bx, 60
    je ninth
    cmp bx, 61
    je ninth
    cmp bx, 62
    je ninth
    cmp bx, 69
    je ninth
    cmp bx, 70
    je ninth
    cmp bx, 71
    je ninth
    cmp bx, 78
    je ninth
    cmp bx, 79
    je ninth
    cmp bx, 80
    je ninth


first:
    mov bx, 0
    jmp cont_2

second:
    mov bx, 3
    jmp cont_2

third:
    mov bx, 6
    jmp cont_2

fourth:
    mov bx, 27
    jmp cont_2

fifth:
    mov bx, 30
    jmp cont_2

sixth:
    mov bx, 33
    jmp cont_2

seventh:
    mov bx, 54
    jmp cont_2

eighth:
    mov bx, 57
    jmp cont_2

ninth:
    mov bx, 60
    jmp cont_2


cont_2:
    

    mov si, third_array
	
    add si, bx
    mov dx, 3
    
check_box_loop_2:
    mov cx, 3

check_box_loop:
	;mov byte [si],1
    cmp byte [si], 0      ;chk first row
    je not_comp_box

    inc si
    loop check_box_loop
    
    add si, 6
    dec dx
    jnz check_box_loop_2
    
    

    shl bx, 1
    mov dx, [locations + bx]
    push dx
    call box_completion
    
not_comp_box:
    pop bx
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret

undo_:
	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    push bx
	push si
	
	
	mov si,stack
	mov bx,[moves]
	
	add si,bx
	
	mov ax,[si]
	add si,2
	mov bx,[si]
	
	
	mov word [check_array+bx],ax
	call fill2
	mov word [array+bx],ax
	
	add si,2
	
	mov ax,[si]
	
	mov word [mistake_count],ax

	add si,2
	
	mov ax,[si]
	
	mov word [score],ax
	
	cmp word[moves],0
	je return
	sub word [moves],8
return:
	pop si
	pop bx
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 4
	
enable_notes:

	mov byte[flag],1
	jmp cont

Pencil_:
	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    push bx
	
	
	cmp byte[flag],1
	jne exit
	
	mov al,14
	mov di,230+182*320
	mov bx,12
pencil_loop:	
	
	mov cx,54
	rep stosb
	
	add di,266
	dec bx
	jnz pencil_loop
	call undo
	jmp exit_2
exit:	
	mov al,9
	mov di,230+182*320
	mov bx,13
pencil_loop_2:	
	
	mov cx,54
	rep stosb
	
	add di,266
	dec bx
	jnz pencil_loop_2
	
exit_2:
	pop bx
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 
	
fill_:
	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    push bx
	push si
	
	mov si, array      
	mov di, check_array       
	mov cx, 81                

fill_loop_1:
    mov al, [si]   
	cmp al,0
	je skip
    mov [di], al          
skip:
    inc si               
    inc di               
    loop fill_loop_1
	
	pop si
	pop bx
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 
	
fill2:
	push bp
    mov bp, sp
    push es
    push di
    push cx
    push ax
    push dx
    push bx
	push si
	
	mov si, check_array      
	mov di, third_array       
	mov cx, 81                

fill_loop_4:
    mov al, [si]   
	cmp al,0
	je skip_3
    mov [di], al          
skip_3:
    inc si               
    inc di               
    loop fill_loop_4
	
	pop si
	pop bx
    pop dx
    pop ax
    pop cx
    pop di
    pop es
    pop bp
    ret 	
	
update_stack:

	push si
	push dx
	push bx
	
	
	mov si,stack
	mov bx,[moves]
	add si,bx
	
	mov bx,[pos]
	mov dx,[array+bx]
	mov [si],dx
	add si,2
	mov dx,[pos]
	mov [si],dx
	add si,2
	mov dx,[mistake_count]
	mov [si],dx
	add si,2
	mov dx,[score]
	mov [si],dx
	
	
	pop bx
	pop dx
	pop si
	ret
	;-------------------------------MAIN--------------------------
start:
   
    mov ax, 0x13;vid mode
    int 0x10
   
    call clear_screen
	call start_screen
   

    mov ah, 0
    int 0x16


	
    call clear_screen
    call grid

	cmp byte[level_choice], 1
	jne level1
	call easyLevel
	
	level1:
	cmp byte[level_choice], 2
	jne level2
	call mediumLevel
	
	level2:
    cmp byte[level_choice], 3
	jne level3
    call extremeLevel
	level3:
	call timer
    call scoreCount
	call block
	call clock
    call fill2
	call faceCards
    call mistakes
    call Pencil_



game:   
	 
	cmp byte[level_choice], 1
	jne level11
	call easyLevel
	
	level11:
	cmp byte[level_choice], 2
	jne level12
	call mediumLevel
	
	level12:
	cmp byte[level_choice], 3
	jne level13
    call extremeLevel
	level13:
	
	call fill2
	call block_2
	call block_3
	call clock
	call display_notes
    call timer
	call faceCards
    call scoreCount
    call mistakes
    call Pencil_
	cmp word [mistake_count],5
	je print_gameover
	cmp byte [points],85
	je print_gamewon
    
    mov ax, [loc]
    mov di, ax
	call sleep2
	call sleep2
	call sleep2
	
	push di             
    call clear_box_yellow 
	;call music
	call sleep2
	call sleep2
    call sleep2
	call sleep2
	
    mov ah, 0x01       
    int 0x16  				
    jz game   
	
	push di
	call clear_box_blue
	
	
	
	cmp al,'z'
	jne skip_undo
	call undo_
	call clear_screen
    call grid
	call block
	;jmp game
skip_undo:
	
    mov ah, 0           
    int 0x16            
    cmp al, 'w'         
    je up_key           
    cmp al, 's'         
    je down_key         
    cmp al, 'a'         
    je left_key         
    cmp al, 'd'         
    je right_key  
	
	cmp al, 'n'         
    je enable_notes
	
	
	cmp al,'i'
	je print_gamewon
	cmp al,'1'
	je p1
	cmp al,'2'
	je p2	
	cmp al,'3'
	je p3	
	cmp al,'4'
	je p4	
	cmp al,'5'
	je p5	
	cmp al,'6'
	je p6	
	cmp al,'7'
	je p7	
	cmp al,'8'
	je p8	
	cmp al,'9'
	je p9
	cmp al,'0'
	je p0
	
    cmp al, 27          
    je print_gameover      
	
	 
    ; pop di             
    jmp game          


cont:
    
	call update_stack
    push di
    call clear_box_yellow
    cmp ah, 01h
    je print_gameover
	
	
	
	

	
    jmp game

end_game:
    
    mov ah, 0x00
    int 0x16            
    mov ax, 0x03       
    int 0x10
    mov ax, 0x4C00      
    int 0x21
	
