; 16bits => 32bits

[bits 16]

switch_to_pm:
  ; para os interrupts
  cli

  ;carrega a gdt
  lgdt [gdt_descriptor]


  mov eax, cr0

  ;bruxaria bitwise
  or eax, 0x1

  mov cr0, eax

  mov si, asdf 
  call print_string


  ;pula para as instruções em 32 bits
  jmp CODE_SEG:init_pm
  


asdf db "asdf", 0
  

[bits 32]

init_pm:

  ;atualiza todos os registers
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax



  ;atualiza a stack
  mov ebp, 0x90000
  mov esp, ebp

  ;liga o a20
  in al, 0x92
  or al, 0x02
  out 0x92, al


  call begin_pm
