;Aqui está as configurações da gdt (Global Descriptor Table)

[bits 16]

gdt_start:
gdt_null:
  dd 0x00
  dd 0x00

gdt_code_descriptor:
  dw 0xffff
  dw 0x00
  db 0x00
  db 10011010b
  db 11001111b
  db 0x00

gdt_data_descriptor:
  dw 0xffff
  dw 0x00
  db 0x00
  db 10010010b
  db 11001111b
  db 0x00
gdt_end:
gdt_descriptor:
  dw gdt_end - gdt_start - 1 ;tamanho
  dd gdt_start ;inicio


CODE_SEG equ gdt_code_descriptor - gdt_start
DATA_SEG equ gdt_data_descriptor - gdt_start
