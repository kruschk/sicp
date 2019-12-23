;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.3\n")
; Return the maximum of a and b.
(define (max a b)
  (if (< a b)
      b
      a))

; Return the minimum of a and b.
(define (min a b)
  (if (< a b)
      a
      b))

; Return the square of x.
(define (square x)
  (* x x))

; Return the sum of squares of x and y (x*x + y*y).
(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (max3 x y z)
  (max x (max y z)))

; Return the middle value of three elements.
(define (middle3 x y z)
  (cond ((<= x y) (cond ((<= y z) y)
                        ((<= z x) x)
                        (else     z)))
        ((<= y x) (cond ((<= x z) x)
                        ((<= z y) y)
                        (else     z)))
        ((<= z x) (cond ((<= y z) z)
                        ((<= x y) x)
                        (else     y)))))

; Return the sum of squares of the two largest values between x, y, and z.
(define (sum-squares-two-biggest x y z)
  (sum-of-squares (middle3 x y z)
                  (max3    x y z)))

(display "Sum of squares of the two largest values: ")
(display (sum-squares-two-biggest -1 -2 -3))
(display ".\n")
