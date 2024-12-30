[org 0x0100]
jmp main
input db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 20-byte buffer
clr:
 mov ax,0xb800
 mov es,ax
 mov di,0
mov ax,0x0720
 mov cx,2000
cld
rep stosw
ret
;;;;
convert_to_upper:
 mov bx,0
convert:
 mov al,byte[input+bx]
 cmp al,'a'
 jb movingout
 cmp al,'A'
 jb movingout
 sub al,0x20
mov [input+bx],al
movingout:
 add bx,1
 cmp al,0
 jne convert
ret
 
;;;;;;;;;;;;;;;;
print:
 mov ax,0xb800
 mov es,ax
 mov di,1508
 mov si,input
loo1:
 lodsb
 cmp al,0
 je end1
 mov ah,0x1
 stosw
jmp loo1
 end1:
 ret

;;;;;;;;;;;
main:
 call clr
 mov bx,0
loop2:
 mov ah,0
 int 0x16
cmp al,0x0D
je go
 mov [input + bx], al ; Store character in input buffer
inc bx
cmp bx,20
je go
jmp loop2
go:
 mov byte[input+bx],0
call convert_to_upper
 call print
mov ax,0x4c00
int 0x21

 















