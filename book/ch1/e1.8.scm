; Exercise 1.8
(display "Exercise 1.8\n")
(define (cbrt-iter last-guess guess x)
  (if (good-enough? last-guess guess)
      guess
      (cbrt-iter guess
                 (improve-guess guess x)
                 x)))
(define (good-enough? last-guess guess)
  (< (abs (/ (- guess last-guess) last-guess)) 0.001))
(define (improve-guess guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))
(define (square x) (* x x))
(define (cbrt x)
  (cbrt-iter 0.0 1.0 x))

(display "(cbrt 17): ") (display (cbrt 17)) (newline)
