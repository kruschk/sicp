;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.10\n")
(load "e2.7.scm")

(define (div-interval x y)
  (let ((x-lower (lower-bound x))
        (x-upper (upper-bound x))
        (y-lower (lower-bound y))
        (y-upper (upper-bound y)))
    (if (and (< y-lower 0) (< 0 y-upper))
        (error "Division by interval spanning 0 -- div-interval" y)
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y)))))))

(display (div-interval (make-interval 1 5) (make-interval -1 1))) (newline)
