;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "curves.scm")

(define (connect-ends curve1 curve2)
  (lambda (t)
    (if (< t (/ 1 2))
        (curve1 (* 2 t))
        (((translate (- (x-of (curve1 1)) (x-of (curve2 0)))
                     (- (y-of (curve1 1)) (y-of (curve2 0))))
          curve2) (- (* 2 t) 1)))))

; Define a linear curve procedure.
(define (linear a b)
  (lambda (x)
    (make-point x
                (+ (* a x) b))))

(let ((point ((linear 2 0) 3)))
  (display "(")
  (display (x-of point))
  (display ", ")
  (display (y-of point))
  (display ")\n"))

; Test `connect-ends` using two different linear curves.
(let ((c1 (linear 7 0))
      (c2 (linear 1 1)))
  (display (y-of ((connect-ends c1 c2) 0.0))) (newline)
  (display (y-of ((connect-ends c1 c2) 0.25))) (newline)
  (display (y-of ((connect-ends c1 c2) 0.5))) (newline)
  (display (y-of ((connect-ends c1 c2) 0.75))) (newline)
  (display (y-of ((connect-ends c1 c2) 1.0))) (newline))
; It seems to work!
