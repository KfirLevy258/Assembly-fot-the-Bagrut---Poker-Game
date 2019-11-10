IDEAL
MODEL small
STACK 100h
DATASEG
; The cards in the array are built of two digits. 
; The left digit represents the symbol of the card.
; 1= HEART, 2=DIAMOND 3=CLUB 4=SPADE.
; The right digit represnts the number between 1-13.
allcards db 1 dup(11h, 12h, 13h, 14h, 1dh, 16h, 17h, 18h, 19h, 1ah, 1bh, 1ch, 15h,21h, 22h, 23h, 24h, 25h, 26h, 27h, 28h, 29h, 2ah, 2bh, 2ch, 2dh, 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 3ah, 3bh, 3ch, 3dh, 41h, 42h, 43h, 44h, 45h, 46h, 47h, 48h, 49h, 4ah, 4bh, 4ch, 4dh)
; An array that is not mixed with all the cards
SwapCount db 100
; Mixing package 100 times
FirstCard db ?
SecondCard db ?
TempCard db ?
FirstCardIndex db ?
SecondCardIndex db ?
; Temporary storage for the package mixing
CardToDisplay	db ?
; A temporary storage for a card to be displayed 
player1 db 1 dup (?, ?)
player2 db 1 dup (?, ?)
player3 db 1 dup (?, ?)
player4 db 1 dup (?, ?)
; The players' hands
Delete db 3 dup (?)
Deck db 5 dup(?)
; The board and the burned cards
Temp db ?
Temp2 db 29
Temp4 db ?
Temp5 db ?
Temp6 dw ?
; Temporary cards for casual uses
openCard1 db ?
openCard2 db ?
openCard3 db ?
; Places to offset during the division of cards
player1v db ?
player2v db ?
player3v db ?
player4v db ?
; The hand score of each player
msg db "Welcome to Kfir and Or poker game$"
Qmsg db "Q = quit$"
Smsg db "S = start game$"
msg1 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                                  ",0dh, 0ah
	 db "               				   ", 0dh, 0ah
	 db "                				  $"
msgd	db "                                  $"
msg2	db "player1$"
msg3	db "player2$"
msg4	db "player3$"
msg5	db "player4$"
msg6	db "To continue, press Enter$"
msg7	db "It can take some time...$"
msgV1	db "Player number 1 won!$"
msgV2	db "Player number 2 won!$"
msgV3	db "Player number 3 won!$"
msgV4	db "Player number 4 won!$"
msgV5	db "draw!$"

CODESEG
start:
	mov ax, @data
	mov ds, ax
	mov bx,0
	
	mov dx, offset msg1
	mov ah, 9
	int 21h
	mov ah, 02h
	mov bh, 0
	mov dh, 10
	mov dl, 22
	int 10h
;Position of the Cursor
	mov dx, offset msg
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 11
	mov dl, 34
	int 10h
;Position of the Cursor
	mov dx, offset Qmsg
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 31
	int 10h
;Position of the Cursor
	mov dx, offset Smsg
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
startdisplay:
	mov ax, 0
	int 16h
	cmp al, "Q"
; If the letter Q is pressed, the program closes
	jne continue
exit:
	mov ax, 4c00h
	int 21h
continue:
	cmp al, "S"
	jne startdisplay
; If the letter S is pressed, the program starts
	mov dx, offset msg1
	mov ah, 9
	int 21h
; All opening messages will be deleted
startdisplaymsg:
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 28
	int 10h
;Position of the Cursor
	mov dx, offset msg7
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 24
	mov dl, 37
	int 10h
;Position of the Cursor
	mov dx, offset msg2
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 71
	int 10h
;Position of the Cursor
	mov dx, offset msg3
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 1
	mov dl, 37
	int 10h
;Position of the Cursor
	mov dx, offset msg4
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 1
	int 10h
;Position of the Cursor
	mov dx, offset msg5
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
cardMixing:
	call delay
; There is a problem. When using INT 1AH, the clock is updated every 55 ms and we need to update the time every micro-second
	mov ax, 0
	int 1ah
; Takes time from the system
	mov dh, 52
	mov al, dl
	div dh	
; Name a random number between 1 and 52 in AH
	mov [FirstCardIndex], ah
	mov bx, offset allcards
	add bl, ah
; Takes a random number and goes to the position of the number
	mov al , [bx]
	mov [TempCard], al
; Takes the first random number and goes to this number in the array
	call delay
; Same problem
	mov ax, 0
	int 1ah
; Takes time from the system
	mov dh, 52
	mov al, dl
	div dh
; Name a random number between 1 and 52 in AH
	mov [SecondCardIndex], ah
	mov bx, offset allcards
	add bl, ah
; Takes a random number and goes to the position of the number
	mov al, [bx]
	mov bx, offset allcards
	add bl, [FirstCardIndex]
	mov [bx], al
	mov al, [TempCard]
	mov bx, offset allcards
	add bl, [SecondCardIndex]
	mov [bx], al
; Performs the exchange of thr cards
	dec [SwapCount]
	cmp [SwapCount], 0
	jne cardMixing
; Checks if we've mixed 100 times	
Management:
	mov ax, 0
	mov bx, 0
	mov cx, 8
	mov dh, offset player1
	mov dl, offset allcards
CardDealing:
	mov al, [bx]
	inc dl
; After the package is mixed up, it begins to divide the cards to the players
	mov bl, dh
	mov [bx], al
; Takes the first card in the package for the player
	inc dh
	inc bl
	mov bl, dl
	dec cx
	cmp cl, 0
	jne CardDealing
; Makes the division to all players (8 times)
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 25
	int 10h
; Position of the Cursor
	mov dx, offset msgd
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 29
	int 10h
;Position of the Cursor
	mov dx, offset msg6
	mov ah, 9
	int 21h
; Displays text in the location of the cursor
	call waitForEnter
	call displayAllCard
	call waitForEnter
; Calls the display and standby functions

openCard:
	mov [openCard1], offset allcards
; A temporary place
	mov [openCard2], offset Deck
; A temporary place
	mov [openCard3], offset Delete
; A temporary place
	add [openCard1], 8
; Takes the offset of all the cards and adds 8 (because of the division of cards to the players)
	mov [Temp4], 3
; counter
	mov [Temp5], 3
; counter
deleteCardX:
	mov bx, 0
	mov bl, [openCard1]
	inc [openCard1]
	mov al, [bx]
; Takes the first card in the big package and puts it in AL
	mov bl, [openCard3]
	inc [openCard3]
	mov [bx], al
; Put that card in the Deleted cards
openCardx:
	dec [Temp4]
; counter
	mov bx, 0
	mov bl, [openCard1]
	inc [openCard1]
	mov al, [bx]
; Takes the first card in the big package and puts it in AL
	mov bl, [openCard2]
	inc [openCard2]
	mov [bx], al
; Put that card in the Deck
	cmp [Temp4], 0
	jne openCardx
; Compares the counter to 0
	call displayAllCard
	call waitForEnter
; Displays the cards and waits for ENTER
ret1:
	inc [Temp4]
	dec [Temp5]
	cmp [Temp5], 0
; Compares the counter to 0
	jne deleteCardX
; Until the counter is not equal to 0, the program will not continue
; Now it's going to calculate the cards' sum of each player
summing:
	mov bx, offset player1
	mov cx, 4
	mov dx, offset player1v
sum1:
	mov al, [bx]
; The first card in the player's hand
	and al,0fh
; Extracts the number
	mov ah, al
	mov al, [bx+1]
	and al, 0fh
; Extracts the second number
	add al, ah
; Stores their sum in AL
	mov [Temp6], bx
; Retains their memory place in temporary memory,
; in order to use BX and remember its previous value
	mov bx, dx
	mov [bx], al
	mov bx, [Temp6] 
; Saves their amount in memory
	add bx, 2
	add dx, 1
	loop sum1
; Continue until the counter is reset

; Now it's going to calculate which player has the greatest sum,
; and by that determine the winner
victory1:
	mov bx, offset player1v
	mov ah, [bx]
; Stores player1's sum in AH
	mov cx,3
; reseting the counter to 3
cheking:
	inc bx
	mov al,[bx]
	cmp al, ah
; Checking which of the two sums is larger 
	ja grater
	loop cheking
	cmp cx,0
	je victory2
grater:
	mov ah, al
; transfers the largest of them in AH
	loop cheking
;Now it's going to determine the winner,
;after it has calculated the biggest sum
victory2:
	mov bx, offset player1v
	mov cx,4
cheking2:
; Checks how has the biggest sum
	cmp [bx], ah
	je biggest
	mov dl, 0
	mov [bx], dl
	inc bx
	loop cheking2
	cmp cx, 0
	jne biggest
	jmp syso
; Reset all the losing hands and turn the winning hand to 1
biggest:
	mov dl, 1
	mov [bx], dl
	inc bx
	loop cheking2
syso:
	mov bx, offset player1v
	mov cx, 4
	mov dl, 1
;  Reset all the losing hands and turn the winning hand to 1
syso1:
; If the number is equal to 1, it checks which player it belongs to
	cmp [bx], dl
	je x54
	inc bx
	loop syso1
	jmp exit
x54:
	cmp bx, 54h
	ja x55
	mov ah, 02h
	mov bh, 0
	mov dh, 14
	mov dl, 32
	int 10h
	mov dx, offset msgV1
	mov ah, 9
	int 21h
	call waitForEnter
	jmp start
x55:
	cmp bx, 55h
	ja x56
	mov ah, 02h
	mov bh, 0
	mov dh, 14
	mov dl, 32
	int 10h
	mov dx, offset msgV2
	mov ah, 9
	int 21h
	call waitForEnter
	jmp start
x56:
	cmp bx, 56h
	ja x57
	mov ah, 02h
	mov bh, 0
	mov dh, 14
	mov dl, 32
	int 10h
	mov dx, offset msgV3
	mov ah, 9
	int 21h
	call waitForEnter
	jmp start

x57:
	mov ah, 02h
	mov bh, 0
	mov dh, 14
	mov dl, 32
	int 10h
	mov dx, offset msgV4
	mov ah, 9
	int 21h
	call waitForEnter
	jmp start

; ********************************************
; displayAllCard fun
; ********************************************
displayAllCard:
	mov bx, 0
player1display:
	mov bl, offset player1
	mov dl,38
	mov dh,23
	mov al, [bx]
; Position for player number 1
	call displayCard
; Activate the display function
	mov dl, 42
	mov bl, offset player1
	inc bl 
	mov al, [bx]
; Position for player number 1
	call displayCard
; Activate the display function
player2display:
	mov bl, offset player2
	mov dl,72
	mov dh,11
	mov al, [bx]
; Position for player number 2
	call displayCard
; Activate the display function
	mov dl, 76
	mov bl, offset player2
	inc bl 
	mov al, [bx]
; Position for player number 2
	call displayCard
; Activate the display function
player3display:
	mov bl, offset player3
	mov dl,38
	mov dh,0
	mov al, [bx]
; Position for player number 3
	call displayCard
; Activate the display function
	mov dl, 42
	mov bl, offset player3
	inc bl 
	mov al, [bx]
; Position for player number 3
	call displayCard
; Activate the display function
player4display:
	mov bl, offset player4
	mov dl, 1
	mov dh, 11
	mov al, [bx]
; Position for player number 4
	call displayCard
; Activate the display function
	mov dl, 5
	mov bl, offset player4
	inc bl 
	mov al, [bx]
; Position for player number 1
	call displayCard
; Activate the display function
	mov [Temp], 0
	mov [Temp2], 29
Deckdisplay:
	add [Temp2], 4
	mov bl, offset Deck
	add bl, [Temp]
	inc [Temp]
	mov dl, [Temp2]
	mov dh, 11
	mov al, [bx]
; Displays the cards on the Deck
	call displayCard
; Activate the display function
	cmp [Temp], 5
	jne Deckdisplay
; Repeat 5 times with different values
	ret
; ********************************************
; displayCard fun
; ********************************************
displayCard:
	mov ah, 02h
	mov bh, 0h
	int 10h
;Position of the Cursor
	mov [CardToDisplay], al
	shr al,4
; Extracting the shape of a card
	cmp al, 2
	jbe RedColor
; Checking whether it is a heart and a diamond or a Spade and a Club
WhiteColor:
; Spade and a Club
	mov al, 32 
	mov ah, 09
	mov bx, 0015	
	mov cx, 03
	int 10h
; Position of the Cursor
	jmp CardNumber
RedColor:
; heart and a diamond
	mov al, 32 
	mov ah, 09
	mov bx, 0004	
	mov cx, 03
	int 10h
; Position of the Cursor
CardNumber:	
	mov al,[CardToDisplay]
	and al, 0fh
; Isolating the number
	cmp al, 01
	je Ace
; If the number is an A, this is a unique case and we are going to deal with it
	cmp al, 09
	ja Faces
; If the number is greater than 9 this is a unique case and go to treat it
	add al, 48
; Because of the ascii value
	mov ah, 0eh
	int 10h
;Position of the Cursor
	jmp Shape
; Jumps to the shape view section
Ace:
	mov al, 65
; The ascii value of A
	mov ah, 0eh
	int 10h
;Position of the Cursor
	jmp Shape
; Jumps to the shape view section
Faces:
	cmp al, 10
	jne g10
; If the number is greater than 10, jump to handle it
	mov al, 49
; The ascii value of 1
	mov ah, 0eh
	int 10h
;Position of the Cursor
	mov al, 48
; The ascii value of 0
	int 10h
;Position of the Cursor
	jmp Shape
; Jumps to the shape view section
g10:
	cmp al, 11
	jne g11
; If the number is greater than 11, jump to handle it
	mov al, 74
; The ascii value of J
	mov ah, 0eh
	int 10h
;Position of the Cursor
	jmp Shape
; Jumps to the shape section
g11:
	cmp al, 12
	jne king
; If the number is greater than 12, jump to handle it
	mov al, 81
; The ascii value of Q
	mov ah, 0eh
	int 10h
;Position of the Cursor
	jmp Shape
; Jumps to the shape section
king:
	mov al, 75
; The ascii value of K
	mov ah, 0eh
	int 10h
;Position of the Cursor	
Shape:
	mov al,[CardToDisplay]
; The card
	and al, 0f0h
; Extracting his shape
	shr al, 4 
; Move it 4 bits sideways to make it a convenient number to use
	add al, 2
; Ascii value of the shapes
	mov ah, 0ah
	mov cx, 01h
	int 10h
;Position of the Cursor
	ret
; Return to where the function came from

; ********************************************
; delay fun
; ********************************************

delay:
	mov bl,4
; counter
loop2:
	mov ax, 0ffffh
; An astronomical number to delay the system
loop1:
	dec ax
	cmp ax, 0
	jne loop1
; Continues if AX equals zero
	dec bl
	cmp bl,0
	jne loop2	
; Repeat the action in relation to the numerator
	ret
; Return to where the function came from

; ********************************************
; waitForEnter fun
; ********************************************
waitForEnter:
	mov ax, 0
	int 16h
; A command waiting for input from the system
	cmp al,0dh
; The ascii value of ENTER
	jne waitForEnter
; Repeats if ENTER is not pressed
	ret
; Return to where the function came from


END start