; Ler informações do disco CHS
; https://stanislavs.org/helppc/int_13.html

[bits 16]


; se espera que o valor de setores para ler venha no dh
disk_read:
  pusha
  push dx

  ; ler do disco
  mov ah, 0x02

  ;al = numero de setores
  mov al, dh

  ;ch = numero do cilindro
  ;mesmo cilindro que bootamos
  mov ch, 0x00

  ;dh = numero da cabeça
  ;mesma cabeça que bootamos
  mov dh, 0x00

  ;cl = numero do setor
  ;começamos no 1, queremos ler o proximo
  mov cl, 0x02
  

  ;interrupt para ler o disco
  int 0x13
  jc disk_read_error



  ;if(last_command != 0) error
  pop dx
  cmp dh, al
  jne disk_read_error



  popa
  ret

disk_read_error:
  cmp al, 0x00
  je error_status
  mov si, error_mensage
  call print_string
  jmp $


error_status:
  mov si, zero
  call print_string
  ret
  

disk_read_succ:
  mov si, sucess_mensage
  call print_string
  jmp $


sucess_mensage db "Tudo certo ao ler o disco", 0
error_mensage db "Erro ao ler o disco", 0
zero db "no error", 0
