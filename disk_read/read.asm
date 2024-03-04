; Ler informações do disco CHS
; https://stanislavs.org/helppc/int_13.html

[bits 16]


; se espera que o valor de setores para ler venha no dh
disk_read:
  pusha

  # TODO: Está dando erro ao ler do disco
  ; ler do disco
  mov ah, 2

  ;al = numero de setores
  mov al, dh

  ;ch = numero do cilindro
  ;mesmo cilindro que bootamos
  mov ch, 0

  ;dh = numero da cabeça
  ;mesma cabeça que bootamos
  mov dh, 0

  ;cl = numero do setor
  ;começamos no 1, queremos ler o proximo
  mov cl, 2
  
  ;interrupt para ler o disco
  int 0x13

  ;if(last_command == 1) error
  jc disk_read_error

  
  cmp dh, al
  jne disk_read_error

  mov si, sucess_mensage
  call print_string
  jmp $
  


  popa
  ret



disk_read_error:
  mov si, error_mensage
  call print_string
  jmp $


sucess_mensage db "Tudo certo ao ler o disco", 0
error_mensage db "Erro ao ler o disco", 0
