[ORG 0x7c00]
   xor ax, ax  ;make it zero
   mov ds, ax
   cld

   mov si, msg
   call bios_print

   xor ax, ax  ;make it zero
   mov ds, ax
   cld

   mov si, um
   call bios_print

keypress:
   mov ah, 00
   int 16h

   cmp al, 27
   je esc
   jne something
   jmp keypress

esc:
    xor ax, ax  ;make it zero
    mov ds, ax
    cld
    mov si, msg3
    call bios_print
    jmp keypress

something:
    cmp al, 13
    je illegal
    mov ah, 0x0e
    int 10h
    jmp keypress

illegal:
    call newline

    xor ax, ax  ;make it zero
    mov ds, ax
    cld
    mov si, bad
    call bios_print
    jmp something

newline:
    xor ax, ax  ;make it zero
    mov ds, ax
    cld
    mov si, nl
    call bios_print

   xor ax, ax  ;make it zero
   mov ds, ax
   cld

   mov si, um
   call bios_print

    ret

msg   db 'Welcome to MODOS V1.25', 13, 10, 0
msg2   db '> ', 0
msg3   db 'BRO TRYNA EXIT LMFAOOO TF2 (TEAM FORTRESS 2) IS AWESOME BTW', 13, 10, 0
bad   db 'Illegal command.', 13, 10, 0
nl   db '', 13, 10, 0
um  db '>', 0

bios_print:
   lodsb
   or al, al  ;zero=end of str
   jz done    ;get out
   mov ah, 0x0E
   mov bh, 0
   int 0x10
   jmp bios_print
done:
   ret

   times 510-($-$$) db 0
   db 0x55
   db 0xAA
