;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.42
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.42\n")
(define (compose f g)
  (lambda (x) (f (g x))))

(define (inc x) (+ x 1))

(display ((compose square inc) 6)) (newline)
(display ((lambda (x) (square (inc x))) 6)) (newline)
