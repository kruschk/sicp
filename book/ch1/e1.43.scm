;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.43
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.43\n")

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (< n 2)
      (lambda (x) (f x))
      (compose f (repeated f (- n 1)))))
(display ((repeated square 2) 5)) (newline) ; Prints 625 (correct)
