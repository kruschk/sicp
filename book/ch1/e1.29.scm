;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.29
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.29\n")

; x^3
(define (cube x) (* x x x))

; Generic sum from the book.
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; Simpson's rule
(define (simpsons-rule f a b n)
  (define h (/ (- b a) n))
  (define (y_k k)
    (f (+ a (* k h))))
  (define (term k)
    (cond ((or (= k 0) (= k n)) (y_k k))
          ((odd? k) (* 4 (y_k k)))
          (else (* 2 (y_k k)))))
  (define (next k)
    (+ k 1))
  (/ (* (sum term 0 next n)
        h)
     3))

(display (simpsons-rule cube 0.0 1.0  100)) (newline)
(display (simpsons-rule cube 0.0 1.0 1000)) (newline)

; These results agree very nicely with the integral procedure defined previously
; and the exact value of 1/4. Simpson's rule appears to produce a more accurate
; approximation with the same step size.
