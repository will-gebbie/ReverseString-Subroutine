ORG     $6000

reverse:    link        A6,#0
            movem.l     D1/A0-A1,-(SP)

            movea.l     8(A6),A0        *in address stored in A0
            movea.l     12(A6),A1       *out address stored in A1
            move.w      16(A6),D1       *count stored in D1

            *initialization complete
            *start algorithm

            tst.w       D1              *is count 0?
            beq         done

            *UPDATE PARAMS
            adda.l      #1,A0
            subq        #1,D1

            *Push new params on stack
            move.w      D1,-(SP)
            pea         (A1)
            pea         (A0)
            jsr         reverse
            adda.l      #10,SP

            add.l       D1,A1   *out+count

            suba.l      #1,A0   *reset A0 address to normal
            *end algorithm


done:       move.b      (A0),(A1)       *copy it reverse and go back to prog4
            movem.l     (SP)+,D1/A0-A1
            unlk        A6
            rts
            end
