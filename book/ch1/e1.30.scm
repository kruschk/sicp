;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.30
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.30\n")
; Generic sum procedure which generates a linear recursion.
(define (sum-rec term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum-rec term (next a) next b))))

; Generic sum procedure which generates an iterative process.
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (+ result
                 (term a)))))
  (iter a 0))

(define (identity x) x)
(define (term x) (+ 3 x))
(define (inc x) (+ x 1))

; It works!
(display (sum-rec  identity 0 inc 10)) (newline)
(display (sum-iter identity 0 inc 10)) (newline)
(display (sum-rec  term     0 inc 10)) (newline)
(display (sum-iter term     0 inc 10)) (newline)
