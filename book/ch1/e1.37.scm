;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.37
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.37\n")
; a.
(display "a.\n")
; A procedure for calculating the first k terms of an infinite continued
; fraction. This form generates a recursive process.
(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))
; It works for calculating 1/phi!
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    1)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    9)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    10)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    11)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    12)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    13)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    100)) (newline)
; To calculate an approximation that is accurate to 4 decimal places, k must
; be at least 9 (assuming the answer will be rounded at the 4th decimal place).

; b.
(display "b.\n")
; A procedure for calculating the first k terms of an infinite continued
; fraction. This form generates an iterative process.
(define (cont-frac n d k)
  (define (helper n d k result)
    (if (= k 0)
        result
        (helper n
                d
                (- k 1)
                (/ (n k)
                   (+ (d k)
                      result)))))
  (helper n d k 0))

(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    1)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    9)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    10)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    11)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    12)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    13)) (newline)
(display (cont-frac (lambda (x) 1.0)
                    (lambda (x) 1.0)
                    100)) (newline)
