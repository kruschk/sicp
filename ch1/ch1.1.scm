; 1.1 The Elements of Programming
; 1.1.1 Expressions
(print "1.1.1 Expressions")
(print (+ (* 3 
             (+ (* 2 4)
                (+ 3 5)))
          (+ (- 10 7)
             6)))

; 1.1.2 Naming and the Environment
(print "1.1.2 Naming and the Environment")
(define size 2)
(print size)
(print (* 5 size))
(define pi 3.14159)
(define radius 10)
(print (* pi radius radius))
(define circumference (* 2 pi radius))
(print circumference)

; 1.1.3 Evaluating Combinations
(print "1.1.3 Evaluating Combinations")
(print (* (+ 2
             (* 4 6))
          (+ 3 5 7)))

; 1.1.4 Compound Procedures
(print "1.1.4 Compound Procedures")
(define (square x) (* x x))
(print (square 21))
(print (square (+ 2 5)))
(print (square (square 3)))
(define (sum-of-squares x y)
  (+ (square x)
     (square y)))
(print (sum-of-squares 3 4))
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(print (f 5))

; 1.1.5 The Substitution Model for Procedure Application
(print "1.1.5 The Substitution Model for Procedure Application")
; Applicative-order evaluation ("evaluate the arguments and then apply")
; (f 5)
; `-> (sum-of-squares (+ 5 1) (* 5 2))
; `-> (sum-of-squares 6 10)
; `-> (+ (square 6) (square 10))
; `-> (+ (* 6 6) (* 10 10))
; `-> (+ 36 100)
; `-> 136
; Normal-order evaluation ("fully expand and then reduce")
; (f 5)
; `-> (sum-of-squares (+ 5 1) (* 5 2))
; `-> (+ (square (+ 5 1)) (square (* 5 2)))
; `-> (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
; `-> (+ (* 6 6) (* 10 10))
; `-> (+ 36 100)
; `-> 136

; 1.1.6 Conditional Expressions and Predicates
(print "1.1.6 Conditional Expressions and Predicates")
;(define (abs x)
;  (cond ((> x 0) x)
;        ((= x 0) 0)
;        ((< x 0) (- x))))
;(define (abs x)
;  (cond ((< x 0) (- x))
;        (else x))
(define (abs x)
  (if (< x 0)
      (- x)
      x))
(print (abs -1))
(define (betwixt x)
  (and (> x 5)
       (< x 10)))
(print (betwixt 7))
;(define (>= x y)
;  or (> x y) (= x y))
(print (>= 7 1))
(define (>= x y)
  (not (< x y)))
(print (>= 7 1))

; 1.1.7 Example: Square Roots by Newton's Method
(print "1.1.7 Example: Square Roots by Newton's Method")
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (sqrt x)
  (sqrt-iter 1.0 x))
(print (sqrt 9))
(print (sqrt (+ 100 37)))
(print (sqrt (+ (sqrt 2) (sqrt 3))))
(print (square (sqrt 1000)))

; 1.1.8 Procedures as Black-Box Abstractions
; Hmm... this might clutter our program's namespace
;(define (square x) (* x x))
;(define (square x)
;  (exp (double (log x))))
;(define (double x) (+ x x))
;(define (sqrt x)
;  (sqrt-iter 1.0 x))
;(define (sqrt-iter guess x)
;  (if (good-enough? guess x)
;      guess
;      (sqrt-iter (improve guess x) x)))
;(define (good-enough? guess x)
;  (< (abs (- (square guess) x)) 0.001))
;(define (improve guess x)
;  (average guess (/ x guess)))
;(define (average x y)
;  (/ (+ x y) 2))

; Block structure helps!
;(define (sqrt x)
;  (define (good-enough? guess x)
;    (< (abs (- (square guess) x)) 0.001))
;  (define (improve guess x)
;    (average guess (/ x guess)))
;  (define (sqrt-iter guess x)
;    (if (good-enough? guess x)
;        guess
;        (sqrt-iter (improve guess x) x)))
;  (sqrt-iter 1.0 x))

; Lexical scoping is even better!
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))
(sqrt 9)
