/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
@ Define the globals so that the C code can access them
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Edward Guerra Ramirez"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/

  /* Copys the input values from registers to memory */
    LDR r2, =dividend
    STR r0, [r2]
    LDR r3, =divisor
    STR r1, [r3]

    /* Initializes the quotient and mods to 0 */
    LDR r4, =quotient
    MOV r5, #0
    STR r5, [r4]
    LDR r6, =mod
    STR r5, [r6]

    /* Checks for error conditions if either dividend or divisor is 0 */
    CMP r0, #0
    BEQ error
    CMP r1, #0
    BEQ error

    /* Performs division using standard unsigned division */
    UDIV r7, r0, r1  /* r7 = dividend / divisor */
    MLS r8, r7, r1, r0 /* r8 = dividend - (quotient * divisor), remainder */

    /* Stores the results */
    STR r7, [r4]  /* Store quotient */
    STR r8, [r6]  /* Store modulus */

    /* Sets "we_have_a_problem" to 0 */
    LDR r9, =we_have_a_problem
    STR r5, [r9]

    /* Returns the address of quotient */
    LDR r0, =quotient
    B done

error:
    LDR r9, =we_have_a_problem
    MOV r10, #1
    STR r10, [r9]   /* Sets "we_have_a_problem" to 1 */

    /* Returns the address of quotient */
    LDR r0, =quotient
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




