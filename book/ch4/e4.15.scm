;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 4.15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 4.15\n")

; Given:
(define (run-forever) (run-forever))
(define (try p)
  (if (halts? p p)
      (run-forever)
      'halted))

; Let's evaluate `(try try)`:
; (try try)
; `-> (if (halts? try try)
;         (run-forever)
;         'halted)

; If `halts?` says applying `try` to itself will halt, then `run-forever` is
; called, and the program runs forever; however, this is paradoxical:
; `halts?` said our program would halt, but we can see that it's now running
; forever! Similarly, if `halts?` says our program will not halt, then
; 'halted is returned (i.e. the program halts); again, this is paradoxical!
