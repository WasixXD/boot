; funções para printar uma string
[bits 16]



; se espera que o a pointer da string para ser escrita esteja no register si

print_string:
  ; guarda os valores inicias dos registers
  pusha
  call print_string_loop


; se pressupõe que o valor de print já esteja no al
print_char:
  ;diz a bios que vamos printar algo
  mov ah, 0x0e
  int 0x10
  ret



print_string_loop:
  ; coloca valor da memoria de si no al
  mov al, [si]
  ; (al == 0) => fim da string
  cmp al, 0
  ; if
  je exit
  ; else
  call print_char
  inc si
  jmp print_string_loop
  

exit:
  popa
  ret
