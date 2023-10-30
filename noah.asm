section .data
    message db "hello, world",0
    AvengersHashSize equ 5
    BadGuysHashSize equ 6

section .bss
    Avengers resb AvengersHashSize * 8 ; Each element has 8 bytes (key and value)
    BadGuys resb BadGuysHashSize * 8 ; Each element has 8 bytes (key and value)

section .text
    extern printf
    global main

main:
    push message
    call printf
    add esp, 4
    ret

_start:
    ; 1. Create a hash table called "Avengers" with hash size 5
    call createTable
    mov eax, Avengers
    mov ebx, AvengersHashSize
    call initializeTable

    ; 2. Insert an element into Avengers with Key = "Thor", Value = "Hemsworth"
    mov eax, Avengers
    mov ecx, key_1 ; Key
    mov edx, value_1 ; Value
    call insertElement

    ; 3. Insert an element into Avengers with Key = "Ironman", Value = "Downey"
    mov ecx, key_2 ; Key
    mov edx, value_2 ; Value
    call insertElement

    ; 4. Insert an element into Avengers with Key = "Hulk", Value = "Ruffalo"
    mov ecx, key_3 ; Key
    mov edx, value_3 ; Value
    call insertElement

    ; 5. Print the Avengers
    mov eax, Avengers
    call printTable

    ; 6. Search the Avengers for key = "Ironman" and print the value returned
    mov eax, Avengers
    mov ecx, key_2 ; Key
    call searchElement

    ; 7. Search the Avengers for key = "Thor" and print the value returned
    mov ecx, key_1 ; Key
    call searchElement

    ; 8. Remove an element from the Avengers with key = "Thor"
    mov eax, Avengers
    mov ecx, key_1 ; Key
    call removeElement

    ; 9. Remove an element from the Avengers with key = "Odin"
    mov ecx, key_4 ; Key
    call removeElement

    ; 10. Search the Avengers for key = "Ironman" and print the value returned
    mov ecx, key_2 ; Key
    call searchElement

    ; 11. Search the Avengers for key = "Thor" and print the value returned
    mov ecx, key_1 ; Key
    call searchElement

    ; 12. Insert an element into Avengers with Key = "Thor", Value = "Hemsworth"
    mov ecx, key_1 ; Key
    mov edx, value_1 ; Value
    call insertElement

    ; 13. Insert an element into Avengers with Key = "Jarvis", Value = "Bettany"
    mov ecx, key_5 ; Key
    mov edx, value_5 ; Value
    call insertElement

    ; 14. Insert an element into Avengers with Key = "Fury", Value = "Jackson"
    mov ecx, key_6 ; Key
    mov edx, value_6 ; Value
    call insertElement

    ; 15. Print the Avengers
    mov eax, Avengers
    call printTable

    ; 16. Create a hash table called "Bad Guys" with hash size 6
    call createTable
    mov eax, BadGuys
    mov ebx, BadGuysHashSize
    call initializeTable

    ; 17. Insert an element into Bad Guys with Key = "Loki", Value = "H.
        ; 17. Insert an element into Bad Guys with Key = "Loki", Value = "Hiddleston"
    mov eax, BadGuys
    mov ecx, key_7 ; Key
    mov edx, value_7 ; Value
    call insertElement

    ; 18. Insert an element into Bad Guys with Key = "Thanos", Value = "Brolin"
    mov ecx, key_8 ; Key
    mov edx, value_8 ; Value
    call insertElement

    ; 19. Print the Bad Guys
    mov eax, BadGuys
    call printTable

    ; 20. Search the Bad Guys for key = "Loki" and print the value returned
    mov eax, BadGuys
    mov ecx, key_7 ; Key
    call searchElement

    ; 21. Search the Bad Guys for key = "Thanos" and print the value returned
    mov ecx, key_8 ; Key
    call searchElement

    ; 22. Remove an element from the Bad Guys with key = "Loki"
    mov eax, BadGuys
    mov ecx, key_7 ; Key
    call removeElement

    ; 23. Remove an element from the Bad Guys with key = "Ultron"
    mov ecx, key_9 ; Key
    call removeElement

    ; 24. Search the Bad Guys for key = "Loki" and print the value returned
    mov ecx, key_7 ; Key
    call searchElement

    ; 25. Search the Bad Guys for key = "Thanos" and print the value returned
    mov ecx, key_8 ; Key
    call searchElement

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Function to create a hash table
createTable:
    ; Allocate memory for the hash table
    push ebx ; Save hash size
    mov ebx, 8 ; Each element has 8 bytes (key and value)
    mul ebx ; Multiply hash size by element size
    mov ebx, eax ; Save allocated memory address in ebx
    mov eax, 9 ; Allocate memory system call
    xor ecx, ecx ; Flags (0)
    xor edx, edx ; File descriptor (0, standard input)
    int 0x80 ; Invoke the system call
    pop ebx ; Restore hash size
    ret

; Function to initialize a hash table
initializeTable:
    push ebx ; Save hash size
    push eax ; Save hash table address
    xor ecx, ecx ; Counter (i)
    xor edx, edx ; Initialize all elements to 0
loop_initialize:
    mov [eax+ecx*8], edx ; Initialize key
    add edx, 4 ; Increment value by 4
    mov [eax+ecx*8+4], edx ; Initialize value
    add ecx, 1 ; Increment counter
    cmp ecx, ebx ; Compare counter with hash size
    jb loop_initialize ; Jump if counter < hash size
    pop eax ; Restore hash table address
    pop ebx ; Restore hash size
    ret

; Function to insert an element into a hash table
insertElement:
    push edx ; Save value
    push ecx ; Save key
    push ebx ; Save hash table address
    xor edx, edx ; Counter (i)
loop_insert:
    mov esi, [ebx+edx*8] ; Check key
    cmp esi, ecx ; Compare key with current key
    je already_exists ; Jump if key already exists
    add edx, 1 ; Increment counter
    cmp edx, eax ; Compare counter with hash size
    jb loop_insert ; Jump if counter < hash size

    ; Key not found, insert the element
    pop ebx ; Restore hash table address
    mov [ebx+eax*8], ecx ; Insert key
    add eax, 1 ; Increment hash size
    mov [ebx+eax*8], edx ; Insert value
    add eax, 1 ; Increment hash size
    pop ecx ; Restore key
    pop edx ; Restore value
    ret

already_exists:
    ; Key already exists, update the value
    add edx, 1 ; Move to value
    mov [ebx+edx*8], ecx ; Update value
    pop ebx ; Restore hash table address
    pop ecx ; Restore key
    pop edx ; Restore value
    ret

; Function to print a hash table
printTable:
    push ebx ; Save hash table address
    push eax ; Save hash size
    xor ecx, ecx ; Counter (i)
loop_print:
    mov esi, [ebx+ecx*8] ; Print key
    push esi ; Save key
    push message_key ; Message template
    call printf ; Print key
    add esp, 8 ; Clean up stack
    mov esi, [ebx+ecx*8+4] ; Print value
    push esi ; Save value
    push message_value ; Message template
    call printf ; Print value
    add esp, 8 ; Clean up stack
    add ecx, 2 ; Increment counter by 2
    cmp ecx, eax ; Compare counter with hash size
    jb loop_print ; Jump if counter < hash size
    pop eax ; Restore hash size
    pop ebx ; Restore hash table address
    ret

; Function to search an element in a hash table
searchElement:
    push ebx ; Save hash table address
    xor edx, edx ; Counter (i)
loop_search:
    mov esi, [ebx+edx*8] ; Check key
    cmp esi, ecx ; Compare key with current key
    je key_found ; Jump if key found
    add edx, 1 ; Increment counter
    cmp edx, eax ; Compare counter with hash size
    jb loop_search ; Jump if counter < hash size

    ; Key not found
    mov eax, not_found ; Return not found message
    pop ebx ; Restore hash table address
    ret

key_found:
    ; Key found, return the value
    add edx, 1 ; Move to value
    mov eax, [ebx+edx*8] ; Return value
    pop ebx ; Restore hash table address
    ret

; Function to remove an element from a hash table
removeElement:
    push ebx ; Save hash table address
    push edx ; Save key
    xor ecx, ecx ; Counter (i)
loop_remove:
    mov esi, [ebx+ecx*8] ; Check key
    cmp esi, edx ; Compare key with current key
    je key_matched ; Jump if key matched
    add ecx, 1 ; Increment counter
    cmp ecx, eax ; Compare counter with hash size
    jb loop_remove ; Jump if counter < hash size

    ; Key not found
    pop edx ; Restore key
    pop ebx ; Restore hash table address
    ret

key_matched:
    ; Key matched, remove the element
    mov esi, ecx ; Save matched key index
    xor edi, edi ; Counter (j)
    add ecx, 2 ; Move to value
loop_shift:
    mov eax, [ebx+ecx*8] ; Move next key
    mov [ebx+esi*8], eax ; Shift key
    add ecx, 1 ; Increment counter
    add esi, 1 ; Increment matched key index
    add edi, 1 ; Increment counter
    cmp edi, eax ; Compare counter with hash size
    jb loop_shift ; Jump if counter < hash size

    ; Clear the last element
    mov edi, 0 ; Clear key
    mov [ebx+esi*8], edi
    add esi, 1 ; Increment matched key index
    mov [ebx+esi*8], edi ; Clear value

    sub eax, 2 ; Decrement hash size
    pop edx ; Restore key
    pop ebx ; Restore hash table address
    ret

section .data
message_key db "%s: ", 0 ; Format string for printing key
message_value db "%s\n", 0 ; Format string for printing value
not_found db "Not Found", 0 ; Not found message

section .bss
hash_size resb 4 ; Hash size variable

section .data
key_1 db "Iron Man", 0 ; Key 1
value_1 db "Downey Jr.", 0 ; Value 1
key_2 db "Captain America", 0 ; Key 2
value_2 db "Evans", 0 ; Value 2
key_3 db "Thor", 0 ; Key 3
value_3 db "Hemsworth", 0 ; Value 3
key_4 db "Hulk", 0 ; Key 4
value_4 db "Ruffalo", 0 ; Value 4
key_5 db "Black Widow", 0 ; Key 5
value_5 db "Johansson", 0 ; Value 5
key_6 db "Hawkeye", 0 ; Key 6
value_6 db "Renner", 0 ; Value 6
key_7 db "Loki", 0 ; Key 7
value_7 db "Hiddleston", 0 ; Value 7
key_8 db "Thanos", 0 ; Key 8
value_8 db "Brolin", 0 ; Value 8
key_9 db "Ultron", 0 ; Key 9
value_9 db "Spader", 0 ; Value 9

