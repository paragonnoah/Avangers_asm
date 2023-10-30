section .data
    AvengersHashSize equ 5
    BadGuysHashSize equ 6

section .bss
    Avengers resb AvengersHashSize * 8 ; Each element has 8 bytes (key and value)
    BadGuys resb BadGuysHashSize * 8 ; Each element has 8 bytes (key and value)

section .text
    global _start

_start:
    ; 1. Create a hash table called "Avengers" with hash size 5
    call createTable
    mov eax, Avengers
    mov ebx, AvengersHashSize
    call initializeTable

    ; 2. Insert an element into Avengers with Key = "Thor", Value = "Hemsworth"
    mov eax, Avengers
    mov ecx, "Thor" ; Key
    mov edx, "Hemsworth",0 ; Value
    call insertElement

    ; 3. Insert an element into Avengers with Key = "Ironman", Value = "Downey"
    mov ecx, "Ironman" ; Key
    mov edx, "Downey" ; Value
    call insertElement

    ; 4. Insert an element into Avengers with Key = "Hulk", Value = "Ruffalo"
    mov ecx, "Hulk" ; Key
    mov edx, "Ruffalo" ; Value
    call insertElement

    ; 5. Print the Avengers
    mov eax, Avengers
    call printTable

    ; 6. Search the Avengers for key = "Ironman" and print the value returned
    mov eax, Avengers
    mov ecx, "Ironman" ; Key
    call searchElement

    ; 7. Search the Avengers for key = "Thor" and print the value returned
    mov ecx, "Thor" ; Key
    call searchElement

    ; 8. Remove an element from the Avengers with key = "Thor"
    mov eax, Avengers
    mov ecx, "Thor" ; Key
    call removeElement

    ; 9. Remove an element from the Avengers with key = "Odin"
    mov ecx, "Odin" ; Key
    call removeElement

    ; 10. Search the Avengers for key = "Ironman" and print the value returned
    mov ecx, "Ironman" ; Key
    call searchElement

    ; 11. Search the Avengers for key = "Thor" and print the value returned
    mov ecx, "Thor" ; Key
    call searchElement

    ; 12. Insert an element into Avengers with Key = "Thor", Value = "Hemsworth"
    mov ecx, "Thor" ; Key
    mov edx, "Hemsworth" ; Value
    call insertElement

    ; 13. Insert an element into Avengers with Key = "Jarvis", Value = "Bettany"
    mov ecx, "Jarvis" ; Key
    mov edx, "Bettany" ; Value
    call insertElement

    ; 14. Insert an element into Avengers with Key = "Fury", Value = "Jackson"
    mov ecx, "Fury" ; Key
    mov edx, "Jackson" ; Value
    call insertElement

    ; 15. Print the Avengers
    mov eax, Avengers
    call printTable

    ; 16. Create a hash table called "Bad Guys" with hash size 6
    call createTable
    mov eax, BadGuys
    mov ebx, BadGuysHashSize
    call initializeTable

    ; 17. Insert an element into Bad Guys with Key = "Loki", Value = "Hiddleston"
    mov eax, BadGuys
    mov ecx, "Loki" ; Key
    mov edx, "Hiddleston" ; Value
    call insertElement

    ; 18. Insert an element into Bad Guys with Key = "Ultron", Value = "Spader"
    mov ecx, "Ultron" ; Key
    mov edx, "Spader" ; Value
    call insertElement

    ; 19. Print the Bad Guys
    mov eax, BadGuys
    call printTable

    ; 20. Print the Avengers
    mov eax, Avengers
    call printTable

    ; 21. Destroy the Avengers
    mov eax, Avengers
    call destroyTable

    ; 22. Print the Avengers
    mov eax, Avengers
    call printTable

    ; 23. Destroy the Bad Guys
    mov eax, BadGuys
    call destroyTable

    ; 24. Print the Bad Guys
    mov eax, BadGuys
    call printTable

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Procedure to create a hash table
; Input: None
; Output: eax - Pointer to the newly created hash table
createTable:
    ; Allocate memory for the hash table
    mov eax, AvengersHashSize
    mov edx, 8 ; Each element has 8 bytes (key and value)
    mul edx
    mov ebx, 8 ; Size of a pointer
    mul ebx
    push eax ; Save the size on the stack for deallocation later
    mov eax, 9 ; Allocate memory system call
    mov ebx, 0 ; Allocate memory using the default allocation policy
    int 0x80
    pop ebx ; Restore the size from the stack
    ret

; Procedure to initialize a hash table
; Input: eax - Pointer to the hash table
;        ebx - Hash size
; Output: None
initializeTable:
    xor ecx, ecx ; Initialize the index counter to 0
    mov edi, eax ; edi = Pointer to the hash table
    mov esi, ebx ; esi = Hash size
initializeLoop:
    cmp ecx, esi ; Check if the index counter exceeds the hash size
    jge initializeEnd
    mov dword [edi], 0 ; Initialize each element with 0
    add edi, 8 ; Move to the next element (8 bytes each)
    inc ecx ; Increment the index counter
    jmp initializeLoop
initializeEnd:
    ret

; Procedure to insert an element into a hash table
; Input: eax - Pointer to the hash table
;        ecx - Key
;        edx - Value
; Output: None
insertElement:
    push ebx ; Save ebx
    push esi ; Save esi
    push edi ; Save edi

    mov esi, eax ; esi = Pointer to the hash table
    mov edi, ecx ; edi = Key
    xor ebx, ebx ; ebx = Hash index

    ; Calculate the hash index
    xor ecx, ecx ; Clear ecx
    mov cl, byte [edi] ; Get the first character of the key
    xor ebx, ebx ; Clear ebx
    mov bl, cl ; ebx = Hash index = ASCII value of the first character of the key
    xor ecx, ecx ; Clear ecx

    ; Insert the element into the hash table
    mov edx, esi ; edx = Pointer to the hash table
    add edx, ebx ; edx = Address of the desired element in the hash table
    mov eax, ecx ; eax = 0 (initialize the counter)
insertLoop:
    cmp dword [edx], 0 ; Check if the element is empty
    je insertElementFound ; If the element is empty, insert the value here
    add edx, 8 ; Move to the next element (8 bytes each)
    inc eax ; Increment the counter
    cmp eax, AvengersHashSize ; Check if the counter exceeds the hash size
    jb insertLoop ; If not, continue searching
    ; If the counter exceeds the hash size, there is no available slot
    ; Handle the collision by linear probing
    xor eax, eax ; Clear eax
    mov eax, ecx ; eax = 0 (initialize the counter)
collisionLoop:
    add edx, 8 ; Move to the next element (8 bytes each)
    cmp dword [edx], 0 ; Check if the element is empty
    je insertElementFound ; If the element is empty, insert the value here
    inc eax ; Increment the counter
    cmp eax, AvengersHashSize ; Check if the counter exceeds the hash size
    jb collisionLoop ; If not, continue linear probing

insertElementFound:
    mov dword [edx], edi ; Insert the key
    add edx, 4 ; Move to the value
    mov dword [edx], edx ; Insert the value (pointer to the key)
    add edx, 4 ; Move to the next element (8 bytes each)

    pop edi ; Restore edi
    pop esi ; Restore esi
    pop ebx ; Restore ebx
    ret

; Procedure to search for an element in a hash table
; Input: eax - Pointer to the hash table
;        ecx - Key
; Output: None
searchElement:
    push ebx ; Save ebx
    push esi ; Save esi
    push edi ; Save edi

    mov esi, eax ; esi = Pointer to the hash table
    mov edi, ecx ; edi = Key
    xor ebx, ebx ; ebx = Hash index

    ; Calculate the hash index
    xor ecx, ecx ; Clear ecx
    mov cl, byte [edi] ; Get the first character of the key
    xor ebx, ebx ; Clear ebx
    mov bl, cl ; ebx = Hash index = ASCII value of the first character of the key
    xor ecx, ecx ; Clear ecx

    ; Search for the element in the hash table
    mov edx, esi ; edx = Pointer to the hash table
    add edx, ebx ; edx = Address of the desired element in the hash table
    mov eax, ecx ; eax = 0 (initialize the counter)
searchLoop:
    cmp dword [edx], edi ; Compare the key with the current element
    je searchElementFound ; If they match, element found
    add edx, 8 ; Move to the next element (8 bytes each)
    inc eax ; Increment the counter
    cmp eax, AvengersHashSize ; Check if the counter exceeds the hash size
    jb searchLoop ; If not, continue searching
    ; If the counter exceeds the hash size, the element is not found

searchElementFound:
    cmp dword [edx], 0 ; Check if the element is empty
    je searchElementNotFound ; If the element is empty, it means the key was not found

    ; Print the value
    add edx, 4 ; Move to the value
    mov ebx, dword [edx] ; ebx = Value (pointer to the key)
    push eax ; Save eax
    push edx ; Save edx
    push ecx ; Save ecx
    mov eax, 4 ; Print system call
    mov ebx, 1 ; Standard output
    mov ecx, ebx ; ecx = Value (pointer to the key)
    mov edx, 8 ; Length of the value (assuming fixed length)
    int 0x80
    pop ecx ; Restore ecx
    pop edx ; Restore edx
    pop eax ; Restore eax

searchElementNotFound:
    pop edi ; Restore edi
    pop esi ; Restore esi
    pop ebx ; Restore ebx
    ret

; Procedure to remove an element from a hash table
; Input: eax - Pointer to the hash table
;        ecx - Key
; Output: None
removeElement:
    push ebx ; Save ebx
    push esi ; Save esi
    push edi ; Save edi

    mov esi, eax ; esi = Pointer to the hash table
    mov edi, ecx ; edi = Key
    xor ebx, ebx ; ebx = Hash index

    ; Calculate the hash index
    xor ecx, ecx ; Clear ecx
    mov cl, byte [edi] ; Get the first character of the key
    xor ebx, ebx ; Clear ebx
    mov bl, cl ; ebx = Hash index = ASCII value of the first character of the key
    xor ecx, ecx ; Clear ecx

    ; Search for the element in the hash table
    mov edx, esi ; edx = Pointer to the hash table
    add edx, ebx ; edx = Address of the desired element in the hash table
    mov eax, ecx ; eax = 0 (initialize the counter)
removeLoop:
    cmp dword [edx], edi ; Compare the key with the current element
    je removeElementFound ; If they match, element found
    add edx, 8 ; Move to the next element (8 bytes each)
    inc eax ; Increment the counter
    cmp eax, AvengersHashSize ; Check if the counter exceeds the hash size
    jb removeLoop ; If not, continue searching
    ; If the counter exceeds the hash size, the element is not found

removeElementFound:
    cmp dword [edx], 0 ; Check if the element is empty
    je removeElementNotFound ; If the element is empty, it means the key was not found

    ; Remove the element from the hash table
    xor ecx, ecx ; Clear ecx
    mov dword [edx], ecx ; Clear the key
    add edx, 4 ; Move to the value
    mov dword [edx], ecx ; Clear the value
    add edx, 4 ; Move to the next element (8 bytes each)

removeElementNotFound:
    pop edi ; Restore edi
    pop esi ; Restore esi
    pop ebx ; Restore ebx
    ret

; Procedure to print a hash table
; Input: eax - Pointer to the hash table
; Output: None
printTable:
    push ebx ; Save ebx
    push esi ; Save esi
    push edi ; Save edi

    mov esi, eax ; esi = Pointer to the hash table
    mov edi, AvengersHashSize ; edi = Hash size

    ; Print the hash table
    mov eax, 1 ; Write system call
    mov ebx, 1 ; Standard output
printLoop:
    mov ecx, 8 ; Length of each element (assuming fixed length)
    mov edx, esi ; edx = Pointer to the hash table
    add edx, 4 ; Move to the value
    mov esi, dword [edx] ; esi = Value (pointer to the key)
    int 0x80

    add esi, 8 ; Move to the next element (8 bytes each)
    dec edi ; Decrement the counter
    jnz printLoop ; If not zero, continue printing

    pop edi ; Restore edi
    pop esi ; Restore esi
    pop ebx ; Restore ebx
    ret

; Procedure to destroy a hash table and deallocate memory
; Input: eax - Pointer to the hash table
; Output: None
destroyTable:
    push ebx ; Save ebx
    push esi ; Save esi
    push edi ; Save edi

    mov esi, eax ; esi = Pointer to the hash table
    mov edi, 8 ; Size of each element (key and value)
    mul edi ; Multiply by the element size
    push eax ; Save the pointer to the hash table on the stack for deallocation
    mov eax, 11 ; Deallocate memory system call
    mov ebx, 0 ; Deallocate memory using the default deallocation policy
    int 0x80
    pop eax ; Restore the pointer to the hash table from the stack

    pop edi ; Restore edi
    pop esi ; Restore esi
    pop ebx ; Restore ebx
    ret
