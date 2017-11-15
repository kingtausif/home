
/* divideby14 */
 

 
/* This function has been generated using "magic.py 14 code_for_signed" */

 
.globl main
 
main:
    /* Call printf */
    push {r4, lr}
    ldr r0, addr_of_message1       /* r0 ← &message */
    bl printf
 
    /* Call scanf */
    ldr r0, addr_of_scan_format   /* r0 ← &scan_format */
    ldr r1, addr_of_read_number   /* r1 ← &read_number */
    bl scanf
 
    ldr r0, addr_of_read_number   /* r1 ← &read_number */
    ldr r0, [r0]                  /* r1 ← *r1 */
 
    bl s_divide_by_14
    mov r2, r0
 
    ldr r1, addr_of_read_number   /* r1 ← &read_number */
    ldr r1, [r1]                  /* r1 ← *r1 */
 
    ldr r0, addr_of_message2      /* r0 ← &message2 */
    bl printf                     /* Call printf, r1 and r2 already
                                     contain the desired values */
    pop {r4, lr}
    mov r0, #0
    bx lr
    
   vfpv2_division:
   /* r0 contains N */
   /* r1 contains D */
   vmov s0, r0             /* s0 ← r0 (bit copy) */
   vmov s1, r1             /* s1 ← r1 (bit copy) */
   vcvt.f32.s32 s0, s0     /* s0 ← (float)s0 */
   vcvt.f32.s32 s1, s1     /* s1 ← (float)s1 */
   vdiv.f32 s0, s0, s1     /* s0 ← s0 / s1 */
   vcvt.s32.f32 s0, s0     /* s0 ← (int)s0 */
   vmov r0, s0             /* r0 ← s0 (bit copy). Now r0 is Q */
   bx lr
    
    
    s_divide_by_14:
   /* r0 contains the argument to be divided by 14 */
   ldr r1, .Ls_magic_number_14   /* r1 ← magic_number */
   smull r1, r2, r1, r0          /* r1 ← Lower32Bits(r1*r0). r2 ← Upper32Bits(r1*r0) */
   add r2, r2, r0                /* r2 ← r2 + r0 */
   mov r2, r2, ASR #3            /* r2 ← r2 >> 3 */
   mov r1, r0, LSR #31           /* r1 ← r0 >> 31 */
   add r0, r2, r1                /* r0 ← r2 + r1 */
   bx lr                         /* leave function */
   .align 4
   .Ls_magic_number_14: .word 0x92492493
    
    
.data
 
.align 4
read_number: .word 0
 
.align 4
message1 : .asciz "Enter an integer to divide it by 14: "
 
.align 4
message2 : .asciz "Number %d (signed-)divided by 14 is %d\n"
 
.align 4
scan_format : .asciz "%d"
 
.text
 
addr_of_message1: .word message1
addr_of_scan_format: .word scan_format
addr_of_message2: .word message2
addr_of_read_number: .word read_number
