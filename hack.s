/* hw4.s */

.global main
.func main

main:
  BL inp_rtv
  BL _divide
  BL prnt_prcd
  B main

_scanf:
  PUSH {LR}
  SUB SP, SP, #4
  LDR R0, =format_str
  MOV R1, SP
  BL scanf
  LDR R0, [SP]
  ADD SP, SP, #4
  POP {PC}

inp_rtv:
  PUSH {LR}
  MOV R7, #4
  MOV R0, #1
  MOV R2, #3
  LDR R1, =n_prmt
  SWI 0
  BL _scanf
  PUSH {R0}

  MOV R7, #4
  MOV R0, #1
  MOV R2, #3
  LDR R1, =d_prmt
  SWI 0
  BL _scanf
  POP {R9}
  MOV R10, R0
  POP {PC}

_divide:
  MOV R4, LR
  VMOV S0, R9
  VMOV S1, R10
  VCVT.F32.S32 S0, S0
  VCVT.F32.S32 S1, S1

  VDIV.F32 S2, S0, S1

  VCVT.F64.F32 D4, S2
  VMOV R1, R2, D4
  PUSH {R1}
  PUSH {R2}
  PUSH {R9}
  PUSH {R10}
  MOV PC, R4

prnt_prcd:
  MOV R4, LR
  POP {R2}
  POP {R1}
  LDR R0, =prnt_stm1
  BL printf

  POP {R2}
  POP {R1}
  BL prnt_float
  MOV PC, R4

prnt_float:
  PUSH {LR}
  LDR R0, =prnt_stm2
  BL printf
  POP {PC}

.data
n_prmt:        .ascii "n: "
d_prmt:        .ascii "d: "
format_str:    .asciz "%d"
prnt_stm1:     .asciz "%d / %d ="
prnt_stm2:     .asciz "%f\n\n"
