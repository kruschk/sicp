;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.1 Introduction to Data Abstraction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "2.1 Introduction to Data Abstraction\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.1.1 Example: Arithmetic Operations for Rational Numbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.1.1 Example: Arithmetic Operations for Rational Numbers\n")

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

; Pairs
(display "\nPairs\n")
(define x (cons 1 2))
(display (car x)) (newline)
(display (cdr x)) (newline)
(define y (cons 3 4))
(define z (cons x y))
(display (car (car z))) (newline)
(display (car (cdr z))) (newline)

; Representing rational numbers
(display "\nRepresenting rational numbers\n")
(define (make-rat n d)
  (cons n d))
(define (numer x)
  (car x))
(define (denom x)
  (cdr x))
(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x)))

; Test the rational number procedures.
(define one-half (make-rat 1 2))
(print-rat one-half) (newline)
(define one-third (make-rat 1 3))
(print-rat (add-rat one-half one-third)) (newline)
(print-rat (mul-rat one-half one-third)) (newline)
(print-rat (add-rat one-third one-third)) (newline)

; Re-define make-rat to reduce rational numbers to lowest terms.
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))
(print-rat (add-rat one-third one-third)) (newline)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.1.2 Abstraction Barriers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.1.2 Abstraction Barriers\n")

; Alternate implementation where rational numbers are reduced to lowest terms
; when they are accessed instead of when they are constructed.
(define (make-rat n d)
  (cons n d))
(define (numer x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (car x) g)))
(define (denom x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (cdr x) g)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.1.3 What is Meant by Data?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.1.3 What is Meant by Data?\n")

(define (cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- CONS" m))))
  dispatch)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2.1.4 Extended Exercise: Interval Arithmetic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n2.1.4 Extended Exercise: Interval Arithmetic\n")

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((t1 (* (lower-bound x) (lower-bound y)))
        (t2 (* (lower-bound x) (upper-bound y)))
        (t3 (* (upper-bound x) (lower-bound y)))
        (t4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min t1 t2 t3 t4)
                   (max t1 t2 t3 t4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))
