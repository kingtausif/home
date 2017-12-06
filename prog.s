/*** txz5041_p5 ***/

.global main
.func main

main:
        bl write_func
        bl prnt_func
        bl search
        b _exit

_scanf:
        push {lr}
        sub sp, sp, #4
        ldr r0, =format_str
        mov r1, sp
        bl scanf
        ldr r0, [sp]
        add sp, sp, #4
        pop {pc}

write_func:
        push {lr}
        mov r5, #0

write_loop:
        cmp r5, #10
        beq write_done

        ldr r0, =input_prompt
        mov r1, r5
        bl printf
        bl _scanf

        ldr r1, =a
        lsl r2, r5, #2
        add r2, r1, r2

        str r0, [r2]
        add r5, r5, #1
        b write_loop

write_done:
        mov r11, #0
        bl nwln
        pop {pc}

prnt_func:
        mov r4, lr
        mov r0, #0

read_loop:
        cmp r0, #10
        beq read_done
        ldr r1, =a
        lsl r2, r0, #2
        add r2, r1, r2
        ldr r1, [r2]
        push {r0}
        push {r1}
        push {r2}
        mov r2, r1
        mov r1, r0
        ldr r0, =print_element

        cmp r11, #0
        moveq r5, r2
        bl cond_prnt

        pop {r2}
        pop {r1}
        pop {r0}
        add r0, r0, #1
        b read_loop

read_done:
        mov r0, #0
        mov pc, r4

cond_prnt:
        push {lr}
        cmp r5, r2
        popne {pc}
        add r10, r10, #1
        bl printf
        pop {pc}

search:
        push {lr}
        bl nwln
        mov r7, #4
        mov r0, #1
        mov r2, #22
        ldr r1, =search_prompt
        swi 0
        bl _scanf
        mov r5, r0
        mov r10, #0
        mov r11, #1
        bl prnt_func
        cmp r10, #0
        beq notin_arr
        pop {pc}

notin_arr:
        mov r7, #4
        mov r0, #1
        mov r2, #40
        ldr r1, =no_arr
        swi 0
        pop {pc}

nwln:
        push {lr}
        mov r7, #4
        mov r0, #1
        mov r2, #1
        ldr r1, =newline
        swi 0
        pop {pc}

_exit:
        mov r7, #1
        swi 0

.data
.balign 4

a:      .skip   40
format_str:     .asciz "%d"
newline:        .ascii "\n"
input_prompt:   .asciz "<VALUE_%d> "
print_element:  .asciz  "array_a[%d] = %d\n"
search_prompt:  .ascii "ENTER A SEARCH VALUE: "
no_arr:       .ascii "That value does not exist in the array!\n"
