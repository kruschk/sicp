;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.34
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.34\n")

(define (f g)
  (g 2))

(display (f square)) (newline)
; `->(square 2)
; `->4

(display (f (lambda (z) (* z (+ z 1))))) (newline)
; `-> ((lamda (z) (* z (+ z 1))) 2)
; `-> (* 2 (+ 2 1))
; `-> (* 2 3)
; `-> 6

;(f f)
; `-> (f 2)
; `-> (2 2)
; `-> ERROR
; We get an error stating "The object 2 is not applicable", which makes sense.
; `2` is not a procedure, so it cannot be applied.
