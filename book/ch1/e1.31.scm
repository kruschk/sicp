;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.31
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.31\n")
; First, define a few utility functions.
(define (identity x) x)
(define (term x) (+ 3 x))
(define (inc x) (+ x 1))

; a.
; Generic product procedure which generates a recursive process.
(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-rec term
                      (next a)
                      next
                      b))))

; Product-rec seems to work.
(display (product-rec identity 1 inc 10)) (newline)
(display (product-rec term 1 inc 10)) (newline)

; Define factorial using product-rec.
(define (factorial n)
  (define (term x) x)
  (define (next x) (+ x 1))
  (product-rec term 1 next n))

; Factorial works!
(display (factorial 0)) (newline)
(display (factorial 10)) (newline)

; Define pi-product using product-rec.
(define (pi-product n)
  (define (term x)
    (/ (* (- x 1)
          (+ x 1))
       (* x x)))
  (define (next x) (+ x 2))
  (* 4.0 (product-rec term 3 next (+ n 2))))

; pi-product works!
(display (pi-product 10000)) (newline)

; b.
; Generic product procedure which generates an iterative process.
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (* result
                 (term a)))))
  (iter a 1))

; It works!
(display (product-iter identity 1 inc 10)) (newline)
(display (product-iter term     1 inc 10)) (newline)

; Define factorial using product-iter.
(define (factorial n)
  (define (term x) x)
  (define (next x) (+ x 1))
  (product-iter term 1 next n))

; Factorial works!
(display (factorial 0)) (newline)
(display (factorial 10)) (newline)

; Define pi-product using product-iter.
(define (pi-product n)
  (define (term x)
    (/ (* (- x 1)
          (+ x 1))
       (* x x)))
  (define (next x) (+ x 2))
  (* 4.0 (product-iter term 3 next (+ n 2))))

; pi-product works!
(display (pi-product 10000)) (newline)
