;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 4.25
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 4.25\n")

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

;(display (factorial 5)) (newline) ; Here be dragons.

; Since Scheme uses applicative order, evaluating `(factorial 5)` will never
; halt because the interpreter will try to evaluate all of the arguments to
; `unless` when the procedure is applied. This will result in an infinite
; recursion because the interpreter will repeatedly try to evaluate
; `(* n (factorial (- n 1)))` even when it should stop. In normal-order
; evaluation, however, the recursive step will only be performed when
; needed, thus the procedure may halt.
