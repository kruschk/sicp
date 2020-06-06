;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.1\n")

(define (make-accumulator acc)
  (lambda (x)
    (set! acc (+ acc x))
    acc))

(define A (make-accumulator 0))
(display (A 10)) (newline)
(display (A 10)) (newline)
