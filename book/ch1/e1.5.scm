;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.5\n")

(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))
;(test 0 (p))

; Applicative-order evaluation (evaluate the arguments and then apply):
; (test 0 (p))
; `->(test 0 (p))
; `->(test 0 (p))
; `->...
; Since the interpreter tries to apply (p), which becomes (p), which becomes (p), which..., it will recurse forever and the program will hang.

; Normal-order evaluation ("fully-expand and then reduce"):
; (test 0 (p))
; `->(if (= 0 0)
;        0
;        (p))
; `->0
; Since p is never applied, the interpreter can successfully apply the combination.
