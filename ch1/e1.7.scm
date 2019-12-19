; Exercise 1.7
(print "Exercise 1.7")

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
(print "Testing `sqrt`:")
(print "(sqrt 9): " (sqrt 9))
(print "(sqrt (+ 100 37)): " (sqrt (+ 100 37)))
(print "(sqrt (+ (sqrt 2) (sqrt 3))): " (sqrt (+ (sqrt 2) (sqrt 3))))
(print "(square (sqrt 1000)): " (square (sqrt 1000)) "\n")

; Testing some numbers:
(print "The weakness of this implementation for small numbers is apparent from the first few values:")
(print "(sqrt            0.0000001): " (sqrt            0.0000001))
(print "(sqrt            0.000001 ): " (sqrt            0.000001 ))
(print "(sqrt            0.00001  ): " (sqrt            0.00001  ))
(print "(sqrt            0.0001   ): " (sqrt            0.0001   ))
(print "(sqrt            0.001    ): " (sqrt            0.001    ))
(print "(sqrt            0.01     ): " (sqrt            0.01     ))
(print "(sqrt            0.1      ): " (sqrt            0.1      ))
(print "(sqrt            1.0      ): " (sqrt            1.0      ))
(print "(sqrt           10.0      ): " (sqrt           10.0      ))
(print "(sqrt          100.0      ): " (sqrt          100.0      ))
(print "(sqrt         1000.0      ): " (sqrt         1000.0      ))
(print "(sqrt        10000.0      ): " (sqrt        10000.0      ))
(print "(sqrt       100000.0      ): " (sqrt       100000.0      ))
(print "(sqrt      1000000.0      ): " (sqrt      1000000.0      ))
(print "(sqrt     10000000.0      ): " (sqrt     10000000.0      ))
(print "(sqrt    100000000.0      ): " (sqrt    100000000.0      ))
(print "(sqrt   1000000000.0      ): " (sqrt   1000000000.0      ))
(print "(sqrt  10000000000.0      ): " (sqrt  10000000000.0      ))
(print "(sqrt 100000000000.0      ): " (sqrt 100000000000.0      ))
(print "The next factor of 10 larger than the last will hang.\n")

(print "When finding square roots of very small numbers, the `good-enough?` test will not be very effective because `0.001` is very large relative to the values we're interested in.\n")

(print "When finding square roots of very large numbers, the `good-enough?` test will not be very effective because `0.001` is very small relative to the values we're interested in. The test may therefore never be satisfied due to the limited precision of the floating point representation.\n")

; Print some tests.
(print "Testing `sqrt-relative`:")
(print "(sqrt-relative 9): " (sqrt-relative 9))
(print "(sqrt-relative (+ 100 37)): " (sqrt-relative (+ 100 37)))
(print "(sqrt-relative (+ (sqrt-relative 2) (sqrt-relative 3))): "
       (sqrt-relative (+ (sqrt-relative 2) (sqrt-relative 3))))
(print "(square (sqrt-relative 1000)): " (square (sqrt-relative 1000)) "\n")
(print "This works much better!")
(print "(sqrt-relative            0.0000001): "
       (sqrt-relative            0.0000001))
(print "(sqrt-relative            0.000001 ): "
       (sqrt-relative            0.000001 ))
(print "(sqrt-relative            0.00001  ): "
       (sqrt-relative            0.00001  ))
(print "(sqrt-relative            0.0001   ): "
       (sqrt-relative            0.0001   ))
(print "(sqrt-relative            0.001    ): "
       (sqrt-relative            0.001    ))
(print "(sqrt-relative            0.01     ): "
       (sqrt-relative            0.01     ))
(print "(sqrt-relative            0.1      ): "
       (sqrt-relative            0.1      ))
(print "(sqrt-relative            1.0      ): "
       (sqrt-relative            1.0      ))
(print "(sqrt-relative           10.0      ): "
       (sqrt-relative           10.0      ))
(print "(sqrt-relative          100.0      ): "
       (sqrt-relative          100.0      ))
(print "(sqrt-relative         1000.0      ): "
       (sqrt-relative         1000.0      ))
(print "(sqrt-relative        10000.0      ): "
       (sqrt-relative        10000.0      ))
(print "(sqrt-relative       100000.0      ): "
       (sqrt-relative       100000.0      ))
(print "(sqrt-relative      1000000.0      ): "
       (sqrt-relative      1000000.0      ))
(print "(sqrt-relative     10000000.0      ): "
       (sqrt-relative     10000000.0      ))
(print "(sqrt-relative    100000000.0      ): "
       (sqrt-relative    100000000.0      ))
(print "(sqrt-relative   1000000000.0      ): "
       (sqrt-relative   1000000000.0      ))
(print "(sqrt-relative  10000000000.0      ): "
       (sqrt-relative  10000000000.0      ))
(print "(sqrt-relative 100000000000.0      ): "
       (sqrt-relative 100000000000.0      ))
