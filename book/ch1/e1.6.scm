; Exercise 1.6
(display "Exercise 1.6\n")
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else      else-clause)))

(display (new-if (= 2 3) 0 5)) (newline) ; Prints 5
(display (new-if (= 1 1) 0 5)) (newline) ; Prints 0

(define (square x) (* x x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
; `new-if` version of `sqrt-iter` hangs!
;(define (sqrt-iter guess x)
;  (new-if (good-enough? guess x)
;          guess
;          (sqrt-iter (improve guess x)
;                     x)))
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

; This new version of `sqrt-iter` using `new-if` will hang. I believe this is due to Scheme's use of applicative-order evaluation. When Scheme uses new-if, it always evaluates the predicate, consequent, and alternate clauses. There is no short-circuiting. Since the alternate clause of our new-if is a recursive step which itself calls sqrt-iter, Scheme will attempt to evaluate this clause even when the guess is good enough. The result is an infinite recursion, and the program hangs.
