%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .bss
	expr: resb MAX_INPUT_SIZE

section .text
global CMAIN
CMAIN:
        mov ebp, esp; for correct debugging
        	push ebp
        	mov ebp, esp
        	GET_STRING expr, MAX_INPUT_SIZE
        ;Se seteaza variabilele pe 0
        xor eax, eax
        	xor ebx, ebx
        xor ecx, ecx
        xor edx, edx	
        start:
        ;Se incepe citirea din stringul dat ca input 
        mov al,[expr + ecx]          
        ;Se scade 48 pentru a obtine echivalentul in ascii
        sub al,48
        cmp al,-48 ; tenminator
        je end
        cmp al,0 ; numar
        jg number
        je number
        cmp al,-5 ; adunare
        je adunare
        cmp al,-3
        je scadere ; scadere
        cmp al,-6
        je inmultire ; inmultire
        cmp al,-1
        je impartire ; impartire
        cmp al,-16
        jmp space ; spatiu
        add ecx,1        
       
space: 
       ; Daca ebx este 0 => Nu avem un numar in urma
        cmp ebx, 0
        je notNUMBER
       ; Verific daca numarul este pozitiv sau negativ
        cmp edx ,1
        je negativ
        jne pozitiv
negativ:
        not ebx       
        inc ebx
        xor edx, edx
pozitiv: 
        push ebx
        xor ebx, ebx
        jmp start 
notNUMBER:
       ; Daca nu este numar => trecem mai departe 
        add ecx,1
        jmp start 
impartire:
        xor edx,edx
        xor ebx,ebx
        pop ebx
        pop eax
        cdq
        idiv ebx
        push eax  
        xor ebx,ebx
        xor eax,eax 
        xor edx,edx 
        add ecx, 1  
        jmp start
inmultire:
        
        xor ebx,ebx  
        xor eax,eax
        pop ebx
        pop eax
        cdq
        imul eax,ebx
        push eax  
        xor eax,eax
        xor ebx,ebx  
        add ecx, 1  
        jmp start
                
scadere:
        xor edx,edx
        xor ebx,ebx
        cmp byte[expr + ecx + 1] , 32 ; verificare daca minusul este de la scadere sau de la  numar negativ 
        jg negativeNumber
        pop ebx
        pop edx
        sub edx, ebx
        push edx  
        xor edx,edx
        xor ebx,ebx  
        add ecx, 1  
        jmp start   
negativeNumber:
        mov edx, 1
        inc ecx
        jmp start
        
adunare:
        xor eax,eax
        xor ebx,ebx
        pop ebx
        pop eax
        add eax, ebx
        push eax
        xor eax,eax
        xor ebx,ebx
        add ecx ,1
        jmp start
        ;Impartirea, inmultirea, adunarea, scaderea au aceeasi forma : se seteaza val pe 0 , se extrag din stiva , 
        ;se efectueaza operatia si se baga inapoi in stiva
number:
        ; Se creeaza numarul, fie ca este de o cifra sau de mai multe 
        imul ebx, 10
        add ebx, eax
        ; Daca numarul este 0 in stiva se baga in stiva 
        cmp ebx ,0 
        jne null_skip
        push ebx
null_skip:
        add ecx, 1
        jmp start 
end:    
        pop eax 
        PRINT_DEC 4, eax     
	xor eax, eax
	xor ebx, ebx
        xor ecx, ecx
        xor edx, edx	
        pop ebp
	ret
