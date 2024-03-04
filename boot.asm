[bits 16]
[org 0x7c00]



mov si, HelloWorld 
call print_string
jmp $


%include "./utils/print.asm"


HelloWorld db 'Hello World', 0



times 510 - ($ - $$) db 0
dw 0xaa55
