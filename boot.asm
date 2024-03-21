[bits 16]
[org 0x7c00]




KERNEL_OFFSET equ 0x1000


;salva o número de boot
mov [BOOT_DRIVE], dl


; seta a stack
mov bp, 0x9000
mov sp, bp


call clear_screen


; seta o kernel em uma memoria especifica
call load_kernel_into_memory


call switch_to_pm



jmp $




load_kernel_into_memory:
  pusha

  mov bx, KERNEL_OFFSET
  mov dh, 2
  mov dl, [BOOT_DRIVE]
  call disk_read


  popa
  ret


clear_screen:
  pusha

  mov ah, 0
  mov al, 3
  int 0x10

  popa
  ret


[bits 32]

begin_pm:
  mov al, 'A'
  mov ah, 0x0f
  mov [0xb8000], ax


enter_kernel:
  call KERNEL_OFFSET
  jmp $

%include "./disk_read/read.asm"
%include "./utils/print.asm"
%include "./pm/pm_mode.asm"
%include "./pm/gdt.asm"


; variables
HelloWorld db 'Hello World', 0
BOOT_DRIVE: db 0
ProtectedMode db 'Entrando no modo 32 bits', 0
Confirm db 'Passei aqui', 0

times 510 - ($ - $$) db 0
dw 0xaa55
