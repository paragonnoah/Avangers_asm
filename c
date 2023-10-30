     1                                  section .data
     2                                      AvengersHashSize equ 5
     3                                      BadGuysHashSize equ 6
     4                                  
     5                                  section .bss
     6 00000000 <res 28h>                   Avengers resb AvengersHashSize * 8 ; Each element has 8 bytes (key and value)
     7 00000028 <res 30h>                   BadGuys resb BadGuysHashSize * 8 ; Each element has 8 bytes (key and value)
     8                                  
     9                                  section .text
    10                                      global _start
    11                                  
    12                                  _start:
    13                                      ; 1. Create a hash table called "Avengers" with hash size 5
    14 00000000 E858010000                  call createTable
    15 00000005 B8[00000000]                mov eax, Avengers
    16 0000000A BB05000000                  mov ebx, AvengersHashSize
    17 0000000F E860010000                  call initializeTable
    18                                  
    19                                      ; 2. Insert an element into Avengers with Key = "Thor", Value = "Hemsworth"
    20 00000014 B8[00000000]                mov eax, Avengers
    21 00000019 B9[14000000]                mov ecx, key_1 ; Key
    22 0000001E BA[1D000000]                mov edx, value_1 ; Value
    23 00000023 E866010000                  call insertElement
    24                                  
    25                                      ; 3. Insert an element into Avengers with Key = "Ironman", Value = "Downey"
    26 00000028 B9[28000000]                mov ecx, key_2 ; Key
    27 0000002D BA[38000000]                mov edx, value_2 ; Value
    28 00000032 E857010000                  call insertElement
    29                                  
    30                                      ; 4. Insert an element into Avengers with Key = "Hulk", Value = "Ruffalo"
    31 00000037 B9[3E000000]                mov ecx, key_3 ; Key
    32 0000003C BA[43000000]                mov edx, value_3 ; Value
    33 00000041 E848010000                  call insertElement
    34                                  
    35                                      ; 5. Print the Avengers
    36 00000046 B8[00000000]                mov eax, Avengers
    37 0000004B E86B010000                  call printTable
    38                                  
    39                                      ; 6. Search the Avengers for key = "Ironman" and print the value returned
    40 00000050 B8[00000000]                mov eax, Avengers
    41 00000055 B9[28000000]                mov ecx, key_2 ; Key
    42 0000005A E88D010000                  call searchElement
    43                                  
    44                                      ; 7. Search the Avengers for key = "Thor" and print the value returned
    45 0000005F B9[14000000]                mov ecx, key_1 ; Key
    46 00000064 E883010000                  call searchElement
    47                                  
    48                                      ; 8. Remove an element from the Avengers with key = "Thor"
    49 00000069 B8[00000000]                mov eax, Avengers
    50 0000006E B9[14000000]                mov ecx, key_1 ; Key
    51 00000073 E894010000                  call removeElement
    52                                  
    53                                      ; 9. Remove an element from the Avengers with key = "Odin"
    54 00000078 B9[4D000000]                mov ecx, key_4 ; Key
    55 0000007D E88A010000                  call removeElement
    56                                  
    57                                      ; 10. Search the Avengers for key = "Ironman" and print the value returned
    58 00000082 B9[28000000]                mov ecx, key_2 ; Key
    59 00000087 E860010000                  call searchElement
    60                                  
    61                                      ; 11. Search the Avengers for key = "Thor" and print the value returned
    62 0000008C B9[14000000]                mov ecx, key_1 ; Key
    63 00000091 E856010000                  call searchElement
    64                                  
    65                                      ; 12. Insert an element into Avengers with Key = "Thor", Value = "Hemsworth"
    66 00000096 B9[14000000]                mov ecx, key_1 ; Key
    67 0000009B BA[1D000000]                mov edx, value_1 ; Value
    68 000000A0 E8E9000000                  call insertElement
    69                                  
    70                                      ; 13. Insert an element into Avengers with Key = "Jarvis", Value = "Bettany"
    71 000000A5 B9[5A000000]                mov ecx, key_5 ; Key
    72 000000AA BA[66000000]                mov edx, value_5 ; Value
    73 000000AF E8DA000000                  call insertElement
    74                                  
    75                                      ; 14. Insert an element into Avengers with Key = "Fury", Value = "Jackson"
    76 000000B4 B9[70000000]                mov ecx, key_6 ; Key
    77 000000B9 BA[78000000]                mov edx, value_6 ; Value
    78 000000BE E8CB000000                  call insertElement
    79                                  
    80                                      ; 15. Print the Avengers
    81 000000C3 B8[00000000]                mov eax, Avengers
    82 000000C8 E8EE000000                  call printTable
    83                                  
    84                                      ; 16. Create a hash table called "Bad Guys" with hash size 6
    85 000000CD E88B000000                  call createTable
    86 000000D2 B8[28000000]                mov eax, BadGuys
    87 000000D7 BB06000000                  mov ebx, BadGuysHashSize
    88 000000DC E893000000                  call initializeTable
    89                                  
    90                                      ; 17. Insert an element into Bad Guys with Key = "Loki", Value = "H.
    91                                          ; 17. Insert an element into Bad Guys with Key = "Loki", Value = "Hiddleston"
    92 000000E1 B8[28000000]                mov eax, BadGuys
    93 000000E6 B9[7F000000]                mov ecx, key_7 ; Key
    94 000000EB BA[84000000]                mov edx, value_7 ; Value
    95 000000F0 E899000000                  call insertElement
    96                                  
    97                                      ; 18. Insert an element into Bad Guys with Key = "Thanos", Value = "Brolin"
    98 000000F5 B9[8F000000]                mov ecx, key_8 ; Key
    99 000000FA BA[96000000]                mov edx, value_8 ; Value
   100 000000FF E88A000000                  call insertElement
   101                                  
   102                                      ; 19. Print the Bad Guys
   103 00000104 B8[28000000]                mov eax, BadGuys
   104 00000109 E8AD000000                  call printTable
   105                                  
   106                                      ; 20. Search the Bad Guys for key = "Loki" and print the value returned
   107 0000010E B8[28000000]                mov eax, BadGuys
   108 00000113 B9[7F000000]                mov ecx, key_7 ; Key
   109 00000118 E8CF000000                  call searchElement
   110                                  
   111                                      ; 21. Search the Bad Guys for key = "Thanos" and print the value returned
   112 0000011D B9[8F000000]                mov ecx, key_8 ; Key
   113 00000122 E8C5000000                  call searchElement
   114                                  
   115                                      ; 22. Remove an element from the Bad Guys with key = "Loki"
   116 00000127 B8[28000000]                mov eax, BadGuys
   117 0000012C B9[7F000000]                mov ecx, key_7 ; Key
   118 00000131 E8D6000000                  call removeElement
   119                                  
   120                                      ; 23. Remove an element from the Bad Guys with key = "Ultron"
   121 00000136 B9[9D000000]                mov ecx, key_9 ; Key
   122 0000013B E8CC000000                  call removeElement
   123                                  
   124                                      ; 24. Search the Bad Guys for key = "Loki" and print the value returned
   125 00000140 B9[7F000000]                mov ecx, key_7 ; Key
   126 00000145 E8A2000000                  call searchElement
   127                                  
   128                                      ; 25. Search the Bad Guys for key = "Thanos" and print the value returned
   129 0000014A B9[8F000000]                mov ecx, key_8 ; Key
   130 0000014F E898000000                  call searchElement
   131                                  
   132                                      ; Exit the program
   133 00000154 B801000000                  mov eax, 1
   134 00000159 31DB                        xor ebx, ebx
   135 0000015B CD80                        int 0x80
   136                                  
   137                                  ; Function to create a hash table
   138                                  createTable:
   139                                      ; Allocate memory for the hash table
   140 0000015D 53                          push ebx ; Save hash size
   141 0000015E BB08000000                  mov ebx, 8 ; Each element has 8 bytes (key and value)
   142 00000163 F7E3                        mul ebx ; Multiply hash size by element size
   143 00000165 89C3                        mov ebx, eax ; Save allocated memory address in ebx
   144 00000167 B809000000                  mov eax, 9 ; Allocate memory system call
   145 0000016C 31C9                        xor ecx, ecx ; Flags (0)
   146 0000016E 31D2                        xor edx, edx ; File descriptor (0, standard input)
   147 00000170 CD80                        int 0x80 ; Invoke the system call
   148 00000172 5B                          pop ebx ; Restore hash size
   149 00000173 C3                          ret
   150                                  
   151                                  ; Function to initialize a hash table
   152                                  initializeTable:
   153 00000174 53                          push ebx ; Save hash size
   154 00000175 50                          push eax ; Save hash table address
   155 00000176 31C9                        xor ecx, ecx ; Counter (i)
   156 00000178 31D2                        xor edx, edx ; Initialize all elements to 0
   157                                  loop_initialize:
   158 0000017A 8914C8                      mov [eax+ecx*8], edx ; Initialize key
   159 0000017D 83C204                      add edx, 4 ; Increment value by 4
   160 00000180 8954C804                    mov [eax+ecx*8+4], edx ; Initialize value
   161 00000184 83C101                      add ecx, 1 ; Increment counter
   162 00000187 39D9                        cmp ecx, ebx ; Compare counter with hash size
   163 00000189 72EF                        jb loop_initialize ; Jump if counter < hash size
   164 0000018B 58                          pop eax ; Restore hash table address
   165 0000018C 5B                          pop ebx ; Restore hash size
   166 0000018D C3                          ret
   167                                  
   168                                  ; Function to insert an element into a hash table
   169                                  insertElement:
   170 0000018E 52                          push edx ; Save value
   171 0000018F 51                          push ecx ; Save key
   172 00000190 53                          push ebx ; Save hash table address
   173 00000191 31D2                        xor edx, edx ; Counter (i)
   174                                  loop_insert:
   175 00000193 8B34D3                      mov esi, [ebx+edx*8] ; Check key
   176 00000196 39CE                        cmp esi, ecx ; Compare key with current key
   177 00000198 7417                        je already_exists ; Jump if key already exists
   178 0000019A 83C201                      add edx, 1 ; Increment counter
   179 0000019D 39C2                        cmp edx, eax ; Compare counter with hash size
   180 0000019F 72F2                        jb loop_insert ; Jump if counter < hash size
   181                                  
   182                                      ; Key not found, insert the element
   183 000001A1 5B                          pop ebx ; Restore hash table address
   184 000001A2 890CC3                      mov [ebx+eax*8], ecx ; Insert key
   185 000001A5 83C001                      add eax, 1 ; Increment hash size
   186 000001A8 8914C3                      mov [ebx+eax*8], edx ; Insert value
   187 000001AB 83C001                      add eax, 1 ; Increment hash size
   188 000001AE 59                          pop ecx ; Restore key
   189 000001AF 5A                          pop edx ; Restore value
   190 000001B0 C3                          ret
   191                                  
   192                                  already_exists:
   193                                      ; Key already exists, update the value
   194 000001B1 83C201                      add edx, 1 ; Move to value
   195 000001B4 890CD3                      mov [ebx+edx*8], ecx ; Update value
   196 000001B7 5B                          pop ebx ; Restore hash table address
   197 000001B8 59                          pop ecx ; Restore key
   198 000001B9 5A                          pop edx ; Restore value
   199 000001BA C3                          ret
   200                                  
   201                                  ; Function to print a hash table
   202                                  printTable:
   203 000001BB 53                          push ebx ; Save hash table address
   204 000001BC 50                          push eax ; Save hash size
   205 000001BD 31C9                        xor ecx, ecx ; Counter (i)
   206                                  loop_print:
   207 000001BF 8B34CB                      mov esi, [ebx+ecx*8] ; Print key
   208 000001C2 56                          push esi ; Save key
   209 000001C3 68[00000000]                push message_key ; Message template
   210                                      call printf ; Print key
   210          ******************       error: symbol `printf' not defined
   211 000001C8 83C408                      add esp, 8 ; Clean up stack
   212 000001CB 8B74CB04                    mov esi, [ebx+ecx*8+4] ; Print value
   213 000001CF 56                          push esi ; Save value
   214 000001D0 68[05000000]                push message_value ; Message template
   215                                      call printf ; Print value
   215          ******************       error: symbol `printf' not defined
   216 000001D5 83C408                      add esp, 8 ; Clean up stack
   217 000001D8 83C102                      add ecx, 2 ; Increment counter by 2
   218 000001DB 39C1                        cmp ecx, eax ; Compare counter with hash size
   219 000001DD 72E0                        jb loop_print ; Jump if counter < hash size
   220 000001DF 58                          pop eax ; Restore hash size
   221 000001E0 5B                          pop ebx ; Restore hash table address
   222 000001E1 C3                          ret
   223                                  
   224                                  ; Function to search an element in a hash table
   225                                  searchElement:
   226 000001E2 53                          push ebx ; Save hash table address
   227 000001E3 31D2                        xor edx, edx ; Counter (i)
   228                                  loop_search:
   229 000001E5 8B34D3                      mov esi, [ebx+edx*8] ; Check key
   230 000001E8 39CE                        cmp esi, ecx ; Compare key with current key
   231 000001EA 7418                        je key_found ; Jump if key found
   232 000001EC 83C201                      add edx, 1 ; Increment counter
   233 000001EF 39C2                        cmp edx, eax ; Compare counter with hash size
   234 000001F1 72F2                        jb loop_search ; Jump if counter < hash size
   235                                  
   236                                      ; Key not found
   237 000001F3 B8[0A000000]                mov eax, not_found ; Return not found message
   238 000001F8 5B                          pop ebx ; Restore hash table address
   239 000001F9 C3                          ret
   240                                  
   241                                  key_found:
   242                                      ; Key found, return the value
   243 000001FA 83C201                      add edx, 1 ; Move to value
   244 000001FD 8B04D3                      mov eax, [ebx+edx*8] ; Return value
   245 00000200 5B                          pop ebx ; Restore hash table address
   246 00000201 C3                          ret
   247                                  
   248                                  ; Function to remove an element from a hash table
   249                                  removeElement:
   250 00000202 53                          push ebx ; Save hash table address
   251 00000203 52                          push edx ; Save key
   252 00000204 31C9                        xor ecx, ecx ; Counter (i)
   253                                  loop_remove:
   254 00000206 8B34CB                      mov esi, [ebx+ecx*8] ; Check key
   255 00000209 39D6                        cmp esi, edx ; Compare key with current key
   256 0000020B 7414                        je key_matched ; Jump if key matched
   257 0000020D 83C101                      add ecx, 1 ; Increment counter
   258 00000210 39C1                        cmp ecx, eax ; Compare counter with hash size
   259 00000212 72F2                        jb loop_remove ; Jump if counter < hash size
   260                                  
   261                                      ; Key not found
   262 00000214 5A                          pop edx ; Restore key
   263 00000215 5B                          pop ebx ; Restore hash table address
   264 00000216 C3                          ret
   265                                  
   266                                  key_matched:
   267                                      ; Key matched, remove the element
   268 00000217 89CE                        mov esi, ecx ; Save matched key index
   269 00000219 31FF                        xor edi, edi ; Counter (j)
   270 0000021B 83C102                      add ecx, 2 ; Move to value
   271                                  loop_shift:
   272 0000021E 8B04CB                      mov eax, [ebx+ecx*8] ; Move next key
   273 00000221 8904F3                      mov [ebx+esi*8], eax ; Shift key
   274 00000224 83C101                      add ecx, 1 ; Increment counter
   275 00000227 83C601                      add esi, 1 ; Increment matched key index
   276 0000022A 83C701                      add edi, 1 ; Increment counter
   277 0000022D 39C7                        cmp edi, eax ; Compare counter with hash size
   278 0000022F 72ED                        jb loop_shift ; Jump if counter < hash size
   279                                  
   280                                      ; Clear the last element
   281 00000231 BF00000000                  mov edi, 0 ; Clear key
   282 00000236 893CF3                      mov [ebx+esi*8], edi
   283 00000239 83C601                      add esi, 1 ; Increment matched key index
   284 0000023C 893CF3                      mov [ebx+esi*8], edi ; Clear value
   285                                  
   286 0000023F 83E802                      sub eax, 2 ; Decrement hash size
   287 00000242 5A                          pop edx ; Restore key
   288 00000243 5B                          pop ebx ; Restore hash table address
   289 00000244 C3                          ret
   290                                  
   291                                  section .data
   292 00000000 25733A2000              message_key db "%s: ", 0 ; Format string for printing key
   293 00000005 25735C6E00              message_value db "%s\n", 0 ; Format string for printing value
   294 0000000A 4E6F7420466F756E64-     not_found db "Not Found", 0 ; Not found message
   294 00000013 00                 
   295                                  
   296                                  section .bss
   297 00000058 ????????                hash_size resb 4 ; Hash size variable
   298                                  
   299                                  section .data
   300 00000014 49726F6E204D616E00      key_1 db "Iron Man", 0 ; Key 1
   301 0000001D 446F776E6579204A72-     value_1 db "Downey Jr.", 0 ; Value 1
   301 00000026 2E00               
   302 00000028 4361707461696E2041-     key_2 db "Captain America", 0 ; Key 2
   302 00000031 6D657269636100     
   303 00000038 4576616E7300            value_2 db "Evans", 0 ; Value 2
   304 0000003E 54686F7200              key_3 db "Thor", 0 ; Key 3
   305 00000043 48656D73776F727468-     value_3 db "Hemsworth", 0 ; Value 3
   305 0000004C 00                 
   306 0000004D 48756C6B00              key_4 db "Hulk", 0 ; Key 4
   307 00000052 52756666616C6F00        value_4 db "Ruffalo", 0 ; Value 4
   308 0000005A 426C61636B20576964-     key_5 db "Black Widow", 0 ; Key 5
   308 00000063 6F7700             
   309 00000066 4A6F68616E73736F6E-     value_5 db "Johansson", 0 ; Value 5
   309 0000006F 00                 
   310 00000070 4861776B65796500        key_6 db "Hawkeye", 0 ; Key 6
   311 00000078 52656E6E657200          value_6 db "Renner", 0 ; Value 6
   312 0000007F 4C6F6B6900              key_7 db "Loki", 0 ; Key 7
   313 00000084 486964646C6573746F-     value_7 db "Hiddleston", 0 ; Value 7
   313 0000008D 6E00               
   314 0000008F 5468616E6F7300          key_8 db "Thanos", 0 ; Key 8
   315 00000096 42726F6C696E00          value_8 db "Brolin", 0 ; Value 8
   316 0000009D 556C74726F6E00          key_9 db "Ultron", 0 ; Key 9
   317 000000A4 53706164657200          value_9 db "Spader", 0 ; Value 9
   318                                  
     