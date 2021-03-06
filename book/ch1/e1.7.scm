;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.7\n")

; When finding square roots of very small numbers, the `good-enough?` test will
; not be very effective because `0.001` is very large relative to the values
; we're interested in.
; When finding square roots of very large numbers, the `good-enough?` test will
; not be very effective because `0.001` is very small relative to the values
; we're interested in. The test may therefore never be satisfied due to the
; limited precision of the floating point representation.

; Define `sqrt`
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (improve guess x)
  (average guess (/ x guess)))
(define (sqrt x)
  (sqrt-iter 1.0 x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
(define (square x) (* x x))

; Define `sqrt-relative`
(define (sqrt-iter-relative last-guess guess x)
  (if (good-enough-relative? last-guess guess)
      guess
      (sqrt-iter-relative guess
                          (improve guess x)
                          x)))
(define (good-enough-relative? last-guess guess)
  (< (abs (/ (- guess last-guess) last-guess)) 0.001))
(define (sqrt-relative x)
  (sqrt-iter-relative 0.0 x x))

; Print some tests.
(display "\nTesting `sqrt`:\n")
(display "(sqrt 9): ") (display (sqrt 9)) (newline)
(display "(sqrt (+ 100 37)): ") (display (sqrt (+ 100 37))) (newline)
(display "(sqrt (+ (sqrt 2) (sqrt 3))): ") (display (sqrt (+ (sqrt 2) (sqrt 3)))) (newline)
(display "(square (sqrt 1000)): ") (display (square (sqrt 1000))) (newline)

; Testing some numbers:
(display "\nThe weakness of this implementation for small numbers is apparent from the first few values:\n")
(display "(sqrt            0.0000001): ") (display (sqrt            0.0000001)) (newline)
(display "(sqrt            0.000001 ): ") (display (sqrt            0.000001 )) (newline)
(display "(sqrt            0.00001  ): ") (display (sqrt            0.00001  )) (newline)
(display "(sqrt            0.0001   ): ") (display (sqrt            0.0001   )) (newline)
(display "(sqrt            0.001    ): ") (display (sqrt            0.001    )) (newline)
(display "(sqrt            0.01     ): ") (display (sqrt            0.01     )) (newline)
(display "(sqrt            0.1      ): ") (display (sqrt            0.1      )) (newline)
(display "(sqrt            1.0      ): ") (display (sqrt            1.0      )) (newline)
(display "(sqrt           10.0      ): ") (display (sqrt           10.0      )) (newline)
(display "(sqrt          100.0      ): ") (display (sqrt          100.0      )) (newline)
(display "(sqrt         1000.0      ): ") (display (sqrt         1000.0      )) (newline)
(display "(sqrt        10000.0      ): ") (display (sqrt        10000.0      )) (newline)
(display "(sqrt       100000.0      ): ") (display (sqrt       100000.0      )) (newline)
(display "(sqrt      1000000.0      ): ") (display (sqrt      1000000.0      )) (newline)
(display "(sqrt     10000000.0      ): ") (display (sqrt     10000000.0      )) (newline)
(display "(sqrt    100000000.0      ): ") (display (sqrt    100000000.0      )) (newline)
(display "(sqrt   1000000000.0      ): ") (display (sqrt   1000000000.0      )) (newline)
(display "(sqrt  10000000000.0      ): ") (display (sqrt  10000000000.0      )) (newline)
(display "(sqrt 100000000000.0      ): ") (display (sqrt 100000000000.0      )) (newline)
(display "The next factor of 10 larger than the last will hang.\n")

; Print some tests.
(display "\nTesting `sqrt-relative`:\n")
(display "(sqrt-relative 9.0): ")
(display (sqrt-relative 9.0)) (newline)
(display "(sqrt-relative (+ 100.0 37.0)): ")
(display (sqrt-relative (+ 100.0 37.0))) (newline)
(display "(sqrt-relative (+ (sqrt-relative 2.0) (sqrt-relative 3.0))): ")
(display (sqrt-relative (+ (sqrt-relative 2.0) (sqrt-relative 3.0)))) (newline)
(display "(square (sqrt-relative 1000.0)): ")
(display (square (sqrt-relative 1000.0))) (newline)
(display "\nThis works much better!\n")
(display "(sqrt-relative            0.0000001): ")
(display (sqrt-relative            0.0000001)) (newline)
(display "(sqrt-relative            0.000001 ): ")
(display (sqrt-relative            0.000001 )) (newline)
(display "(sqrt-relative            0.00001  ): ")
(display (sqrt-relative            0.00001  )) (newline)
(display "(sqrt-relative            0.0001   ): ")
(display (sqrt-relative            0.0001   )) (newline)
(display "(sqrt-relative            0.001    ): ")
(display (sqrt-relative            0.001    )) (newline)
(display "(sqrt-relative            0.01     ): ")
(display (sqrt-relative            0.01     )) (newline)
(display "(sqrt-relative            0.1      ): ")
(display (sqrt-relative            0.1      )) (newline)
(display "(sqrt-relative            1.0      ): ")
(display (sqrt-relative            1.0      )) (newline)
(display "(sqrt-relative           10.0      ): ")
(display (sqrt-relative           10.0      )) (newline)
(display "(sqrt-relative          100.0      ): ")
(display (sqrt-relative          100.0      )) (newline)
(display "(sqrt-relative         1000.0      ): ")
(display (sqrt-relative         1000.0      )) (newline)
(display "(sqrt-relative        10000.0      ): ")
(display (sqrt-relative        10000.0      )) (newline)
(display "(sqrt-relative       100000.0      ): ")
(display (sqrt-relative       100000.0      )) (newline)
(display "(sqrt-relative      1000000.0      ): ")
(display (sqrt-relative      1000000.0      )) (newline)
(display "(sqrt-relative     10000000.0      ): ")
(display (sqrt-relative     10000000.0      )) (newline)
(display "(sqrt-relative    100000000.0      ): ")
(display (sqrt-relative    100000000.0      )) (newline)
(display "(sqrt-relative   1000000000.0      ): ")
(display (sqrt-relative   1000000000.0      )) (newline)
(display "(sqrt-relative  10000000000.0      ): ")
(display (sqrt-relative  10000000000.0      )) (newline)
(display "(sqrt-relative 100000000000.0      ): ")
(display (sqrt-relative 100000000000.0      )) (newline)
