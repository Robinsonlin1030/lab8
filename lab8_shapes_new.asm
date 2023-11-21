######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       4
# - Unit height in pixels:      4
# - Display width in pixels:    256
# - Display height in pixels:   256
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################


.data 0x10010000
THE_COLOUR:
    .word	0x885A89    # an initial colour


.text
main:
    # load a colour to draw
    lui $t0, 0x88
    ori $t0, $0, 0x5A89
    # paint the first unit with the colour
    sw $t0, 0($gp)

    #   Add calls to your functions below to try them out
    li $a0, 1           # x coordinate
    li $a1, 1           # y coordinate
    li $a2, 20          # width in units
    li $a3, 10          # height in units

    jal draw_rectangle
exit:
	addi $v0, $0, 10
	syscall


# fill_unit(x, y, colour) -> void
#   Draw a unit with the given colour at location (x, y).
fill_unit:
    # PROLOGUE
    #   TODO

    # BODY
    add $t1, $0, $gp
    sll $a0, $a0, 2
    sll $a1, $a1, 8
    add $t1, $t1, $a0
    add $t1, $t1, $a1
    
    sw $a2, 0($t1)  
    
    

    # EPILOGUE
    #   TODO
    jr $ra


# draw_horizontal_line(x, y, size) -> void
#   Draw a straight line that starts at (x, y) and ends at (x + width, y)
#   using the colour found at THE_COLOUR.
draw_horizontal_line:
    # PROLOGUE
    #   TODO

    # BODY
    #   TODO
    add $t3, $a0, $a2
    add $t7, $ra, 0
    addi $t5, $a1, 0
    addi $t4, $a0, 0
    addi $t3, $t3, 1
loop:
    slt $t2, $t4, $t3
    beq $t2, 0, done
    
    addi $a0, $t4, 0
    addi $a1, $t5, 0
    addi $a2, $t0, 0
    jal fill_unit
    addi $t4, $t4, 1
    j loop
done:
    add $ra, $0, $t7

    # EPILOGUE
    #   TODO
    jr $ra


# draw_vertical_line(x, y, size) -> void
#   Draw a straight line that starts at (x, y) and ends at (x, y + size)
#   using the colour found at THE_COLOUR.
draw_vertical_line:
    # PROLOGUE
    #   TODO
    add $t3, $a1, $a2
    add $t7, $ra, 0
    addi $t5, $a1, 0
    addi $t4, $a0, 0
    addi $t3, $t3, 1

    # BODY
    #   TODO
while:
    slt $t2, $t5, $t3
    beq $t2, 0, end
    addi $a0, $t4, 0
    addi $a1, $t5, 0
    addi $a2, $t0, 0
    jal fill_unit
    addi $t5, $t5, 1
    j while
    
end:
    add $ra, $0, $t7   

    # EPILOGUE
    #   TODO
    jr $ra


# draw_rectangle(x, y, width, height) -> void
#   Draw the outline of a rectangle whose top-left corner is at (x, y)
#   and bottom-right corner is at (x + width, y + height) using the
#   colour found at THE_COLOUR.
draw_rectangle:
    # PROLOGUE
    #   TODO
    addi $sp, $sp, -16
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    sw $a3, 12($sp)

    # BODY
    #   TODO
    jal draw_horizontal_line
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 12($sp) 
    jal draw_vertical_line
    
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 12($sp)
    lw $a3, 8($sp)
    add $a0, $a0, $a3
    jal draw_vertical_line

    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $a3, 12($sp) 
    add $a1, $a1, $a3
    jal draw_horizontal_line
    

    # EPILOGUE
    addi $sp, $sp, 16
    #   TODO
    jr $ra
