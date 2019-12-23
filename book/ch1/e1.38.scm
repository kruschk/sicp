;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ; Exercise 1.38
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.38\n")
(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n k)
         (+ (d k)
            (cont-frac n d (- k 1))))))

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

; It works!
; Note: the second lambda is based on this derivation:
; 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, ...
; 1, 2, 1, 1, 4, 1, 1, 6, 1,  1,  8,  1, ...
; 2  -> 2
; 5  -> 4
; 8  -> 6
; 11 -> 8 
; Relationship appears to be linear... f(x) = mx + b
; m = (f(x2) - f(x1))/(x2 - x1) = (4 - 2)/(5 - 2) = 2/3
; b = f(x) - m*x = 6 - (2/3)*8 = 6 - 16/3 = (18 - 16)/3 = 2/3
; f(x) = (2/3)*x + 2/3
; f(x) = (2/3)*(x + 1)
(display (+ (cont-frac (lambda (x) 1.0)
                       (lambda (x)
                         (if (= 2 (remainder x 3))
                             (* (/ 2 3) (+ x 1))
                             1.0))
                       10)
            2)) (newline)
