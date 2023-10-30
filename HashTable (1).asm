INCLUDE Irvine32.inc
.data

.code:


main PROC
; Define the structure for a hash table entry
struc HashEntry
    .key resd 1   ; Pointer to the key string
    .val resd 1   ; Pointer to the value string
    .next resd 1  ; Pointer to the next entry in the bucket chain
endstruc

; Define the hash table structure
struc HashTable
    .size resd 1      ; Current size of the hash table
    .count resd 1     ; Number of entries in the hash table
    .buckets resd 1   ; Pointer to the array of bucket pointers
endstruc

section .data
; Define constants for the hash function
hash_factor equ 31
hash_modulo equ 256

section .text
; Create an empty hash table
; Inputs:
;   EAX = size of the hash table
; Returns:
;   EAX = pointer to the hash table structure
HTCreate:
    push ebp
    mov ebp, esp
    ; Allocate memory for the hash table structure
    push eax            ; Save the size argument
    mov eax, 12         ; Size of the HashTable structure
    mul dword [ebp+8]   ; Multiply by the size argument
    add eax, 4          ; Add 4 bytes for the size of the bucket array
    push eax            ; Save the total size needed
    call malloc         ; Allocate memory
    add esp, 4          ; Discard the argument
    ; Initialize the hash table structure
    mov dword [eax], [ebp+8]         ; Set the size
    mov dword [eax+4], 0            ; Set the count to 0
    mov dword [eax+8], 0            ; Set the bucket array pointer to NULL
    cmp eax, 0                      ; Check for allocation failure
    je HTCreate_exit
    ; Allocate memory for the bucket array
    mov ecx, dword [ebp+8]          ; Get the size argument
    shl ecx, 2                      ; Multiply by 4 to get the byte size
    push ecx                        ; Save the byte size
    call malloc                     ; Allocate memory
    add esp, 4                      ; Discard the argument
    mov dword [eax+8], eax          ; Set the bucket array pointer
    cmp eax, 0                      ; Check for allocation failure
    je HTCreate_exit
    ; Initialize the bucket pointers to NULL
    xor edx, edx                    ; Clear the loop counter
    mov ecx, dword [ebp+8]          ; Get the size argument
    mov ebx, dword [eax+8]          ; Get the bucket array pointer
    mov dword [ebx+edx*4], 0        ; Set the first bucket pointer to NULL
    inc edx                         ; Increment the loop counter
    cmp edx, ecx                    ; Check if we've initialized all the buckets
    jl HTCreate_loop
HTCreate_exit:
    pop ebp
    ret
HTCreate_loop:
    mov dword [ebx+edx*4], 0        ; Set the next bucket pointer to NULL
    inc edx                         ; Increment the loop counter
    cmp edx, ecx                    ; Check if we've initialized all the buckets
    jl HTCreate_loop

; Insert a key-value pair into the hash table
; Inputs:
;   EAX = pointer to the hash table structure
;   EBX = pointer to the key string
;   ECX = pointer to the value string

global HTRemove
HTRemove:
    ; Compute the hash value for the key
    push ebp
    mov ebp, esp
    mov ecx, [ebp+12] ; Get the key argument
    call djb2
    xor edx, edx
    mov edx, ecx
    mov ecx, table_size
    xor eax, eax
    div ecx ; eax = hash_value % table_size

    ; Search for the key in the hash bucket
    mov edi, [hash_table+eax*4]
    mov ebx, edi
    cmp ebx, 0
    je key_not_found
    mov esi, [ebx+KeyValue.key]
    cmp byte [esi], 0
    je key_not_found
    cmp esi, ecx
    jne loop_key_value_pairs
    ; Key found in the first key-value pair of the bucket
    mov [hash_table+eax*4], [ebx+KeyValue.next]
    call free_key_value_pair
    dec [load_factor]
    leave
    ret

loop_key_value_pairs:
    mov edi, ebx
    mov ebx, [ebx+KeyValue.next]
    cmp ebx, 0
    je key_not_found
    mov esi, [ebx+KeyValue.key]
    cmp byte [esi], 0
    je key_not_found
    cmp esi, ecx
    jne loop_key_value_pairs
    ; Key found in a subsequent key-value pair
    mov [edi+KeyValue.next], [ebx+KeyValue.next]
    call free_key_value_pair
    dec [load_factor]
    leave
    ret

key_not_found:
    leave
    ret

free_key_value_pair:
    ; Free the memory used by the key-value pair
    mov edx, [ebx+KeyValue.key]
    push edx
    call free
    add esp, 4
    mov edx, ebx
    push edx
    call free
    add esp, 4
    ret
global HTSearch
HTSearch:
    ; Compute the hash value for the key
    push ebp
    mov ebp, esp
    mov ecx, [ebp+12] ; Get the key argument
    call djb2
    xor edx, edx
    mov edx, ecx
    mov ecx, table_size
    xor eax, eax
    div ecx ; eax = hash_value % table_size

    ; Search for the key in the hash bucket
    mov edi, [hash_table+eax*4]
    mov ebx, edi
    cmp ebx, 0
    je key_not_found
    mov esi, [ebx+KeyValue.key]
    cmp byte [esi], 0
    je key_not_found
    cmp esi, ecx
    jne loop_key_value_pairs
    ; Key found in the first key-value pair of the bucket
    mov eax, [ebx+KeyValue.value]
    leave
    ret

loop_key_value_pairs:
    mov ebx, [ebx+KeyValue.next]
    cmp ebx, 0
    je key_not_found
    mov esi, [ebx+KeyValue.key]
    cmp byte [esi], 0
    je key_not_found
    cmp esi, ecx
    jne loop_key_value_pairs
    ; Key found in a subsequent key-value pair
    mov eax, [ebx+KeyValue.value]
    leave
    ret

key_not_found:
    xor eax, eax ; Return 0 if key not found
    leave
    ret

main ENDP
END main