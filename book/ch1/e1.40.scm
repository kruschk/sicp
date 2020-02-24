;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.40
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.40\n")

; Utility functions.
(define (newtons-method g guess)
  (define (deriv g)
    (let ((dx 0.00001))
      (lambda (x) (/ (- (g (+ x dx)) (g x))
                     dx))))
  (define (fixed-point f first-guess)
    (let ((tolerance 0.00001))
      (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
      (define (try guess)
        (let ((next (f guess)))
          (if (close-enough? guess next)
            next
            (try next))))
      (try first-guess)))
  (define (newton-transform g)
    (lambda (x)
      (- x (/ (g x) ((deriv g) x)))))
  (fixed-point (newton-transform g) guess))

; Define `cubic` in terms of newtons-method.
(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))
(display (newtons-method (cubic 1 2 3) 1)) (newline)
