; 1.1 The Elements of Programming
(display "1.1 The Elements of Programming\n")
; 1.1.1 Expressions
(display "\n1.1.1 Expressions\n")
(display (+ (* 3 
               (+ (* 2 4)
                  (+ 3 5)))
            (+ (- 10 7)
               6))) (newline)

; 1.1.2 Naming and the Environment
(display "\n1.1.2 Naming and the Environment\n")
(define size 2)
(display size) (newline)
(display (* 5 size)) (newline)
(define pi 3.14159)
(define radius 10)
(display (* pi radius radius)) (newline)
(define circumference (* 2 pi radius))
(display circumference) (newline)

; 1.1.3 Evaluating Combinations
(display "\n1.1.3 Evaluating Combinations\n")
(display (* (+ 2
               (* 4 6))
            (+ 3 5 7))) (newline)

; 1.1.4 Compound Procedures
(display "\n1.1.4 Compound Procedures\n")
(define (square x) (* x x))
(display (square 21)) (newline)
(display (square (+ 2 5))) (newline)
(display (square (square 3))) (newline)
(define (sum-of-squares x y)
  (+ (square x)
     (square y)))
(display (sum-of-squares 3 4))
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(display (f 5)) (newline)

; 1.1.5 The Substitution Model for Procedure Application
(display "\n1.1.5 The Substitution Model for Procedure Application\n")
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
(display "\n1.1.6 Conditional Expressions and Predicates\n")
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
(display (abs -1)) (newline)
(define (betwixt x)
  (and (> x 5)
       (< x 10)))
(display (betwixt 7)) (newline)
;(define (>= x y)
;  or (> x y) (= x y))
(display (>= 7 1)) (newline)
(define (>= x y)
  (not (< x y)))
(display (>= 7 1)) (newline)

; 1.1.7 Example: Square Roots by Newton's Method
(display "\n1.1.7 Example: Square Roots by Newton's Method\n")
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
(display (sqrt 9)) (newline)
(display (sqrt (+ 100 37))) (newline)
(display (sqrt (+ (sqrt 2) (sqrt 3)))) (newline)
(display (square (sqrt 1000))) (newline)

; 1.1.8 Procedures as Black-Box Abstractions
(display "\n1.1.8 Procedures as Black-Box Abstractions\n")
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
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
(display (sqrt 9)) (newline)
