; Exercise 1.11
(display "Exercise 1.11\n")

(define (f-rec n)
  (if (< n 3)
      n
      (+ (     f-rec (- n 1))
         (* 2 (f-rec (- n 2)))
         (* 3 (f-rec (- n 3))))))

(display "\nRecursive:\n")
(display (f-rec 0)) (newline)
(display (f-rec 1)) (newline)
(display (f-rec 2)) (newline)
(display (f-rec 3)) (newline)
(display (f-rec 4)) (newline)
(display (f-rec 5)) (newline)
(display (f-rec 6)) (newline)
(display (f-rec 7)) (newline)
(display (f-rec 8)) (newline)
(display (f-rec 9)) (newline)

(define (f-iter n)
  (define (helper a b c counter)
      (if (< n (+ counter 2))
          a
          (helper (+ a (* 2 b) (* 3 c))
                  a
                  b
                  (+ counter 1))))
  (if (< n 3)
      n
      (helper 2 1 0 1)))

(display "\nIterative:\n")
(display (f-iter 0)) (newline)
(display (f-iter 1)) (newline)
(display (f-iter 2)) (newline)
(display (f-iter 3)) (newline)
(display (f-iter 4)) (newline)
(display (f-iter 5)) (newline)
(display (f-iter 6)) (newline)
(display (f-iter 7)) (newline)
(display (f-iter 8)) (newline)
(display (f-iter 9)) (newline)
