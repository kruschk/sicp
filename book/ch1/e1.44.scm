;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.44
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.44\n")

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (< n 2)
      (lambda (x) (f x))
      (compose f (repeated f (- n 1)))))

(define (smooth f dx)
  (define (average3 x y z)
    (/ (+ x y z) 3))
  (lambda (x) (average3 (f (- x dx))
                        (f x)
                        (f (+ x dx)))))

(define (n-fold-smoothed f dx n) (repeated (smooth f dx) n))

(display (square 5.0)) (newline)
(display ((smooth square 10) 5.0)) (newline)
(display ((n-fold-smoothed square 1 2) 5.0)) (newline)
