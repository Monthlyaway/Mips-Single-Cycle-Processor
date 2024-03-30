main:
    addi    $2, $0,     7
    addi    $5, $0,     12
    bne     $2, $5,     end
    sw      $5, 84($0)
end:
    sw      $2, 84($0)