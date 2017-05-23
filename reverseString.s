*----------------------------------------------------------------------
*
reverse: EQU    $6000
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*

start:  initIO                  * Initialize (required for I/O)
        setEVT                  * Error handling routines
*       initF                   * For floating point macros only

        lineout         title
        lineout         prompt1
        linein          buffin          *String length in D0

        move.w          D0,-(SP)        *push params on stack
        pea             buffout
        pea             buffin
        jsr             reverse
        adda.l          #10,SP

        lea             buffout,A3      *add 0 on end to null terminate
        adda.l          D0,A3
        move.b          #0,(A3)


        lineout         skipln          *print out answer
        lineout         answer
        lineout         buffout



        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations

prompt1: dc.b   'Enter a string: ',0
buffin: ds.b    82
answer: dc.b    'Here is the string backwards: ',0
buffout: ds.b   82
        end
