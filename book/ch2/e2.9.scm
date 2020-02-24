;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.9\n")

(load "e2.8.scm")

; An interval can be defined as the pair: I = (l, u)
; To compute the width of an interval: w(I) = (u - l)/2
; Addition:
; Addition is defined as: I1 + I2 = (l1 + l2, u1 + u2)
; So the width of the sum is:
; w(I1 + I2) = w((l1 + l2, u1 + u2)) = ((u1 + u2) - (l1 + l2))/2
;     = (u1 + u2 - l1 - l2)/2 = (u1 - l1)/2 + (u2 - l2)/2 = w(I1) + w(I2)
; Subtraction:
; Subtraction is defined as: I1 - I2 = (l1 - u2, u1 - l2)
; The width of the difference is therefore:
; w(I1 - I2) = w((l1 - u2, u1 - l2)) = ((u1 - l2) - (l1 - u2))/2
;     = (u1 + u2 - l1 - l2)/2 = (u1 - l1)/2 + (u2 - l2)/2 = w(I1) + w(I2)
; Multiplication:
; Since multiplication is defined using the min and max functions, which
; require selecting a value from a set, the width of a multiplication is
; not a simple function of the two input intervals.
; Division:
; Since division is the inverse function of multiplication, a similar
; argument can be used to argue that the division operation is not a simple
; function of the two input intervals.
; The above conclusions are tested below:

(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))

(let ((i1 (make-interval -5  5))
      (i2 (make-interval  1  3))
      (i3 (make-interval  0 10))
      (i4 (make-interval -2  0)))
  (display i1) (newline)
  (display (width i1)) (newline)
  (display i2) (newline)
  (display (width i2)) (newline)
  ; The width of the sum is a function of the widths of the respective
  ; summands, as shown above.
  (display "Addition:\n")
  (display (add-interval i1 i2)) (newline)
  (display (width (add-interval i1 i2))) (newline)
  ; The width of the sum is a function of the widths of the minuend and
  ; of the subtrahend, respectively, as shown above.
  (display "Subtraction:\n")
  (display (sub-interval i1 i2)) (newline)
  (display (width (sub-interval i1 i2))) (newline)
  ; w(i1) = w(i3) and w(i2) = w(i4), but the width of the products are not
  ; the same, so the width of a product is not a function of the widths of
  ; the respective factors.
  (display "Multiplication:\n")
  (display (width i1)) (newline)
  (display (width i2)) (newline)
  (display (mul-interval i1 i2)) (newline)
  (display (width (mul-interval i1 i2))) (newline)
  (display (width i3)) (newline)
  (display (width i4)) (newline)
  (display (mul-interval i3 i4)) (newline)
  (display (width (mul-interval i3 i4))) (newline)
  ; w(i1) = w(i3) and w(i2) = w(i4), but the width of the quotients are not
  ; the same, so the width of a quotient is not a function of the widths of
  ; the dividend and of the divisor, respectively.
  (display "Division:\n")
  (display (width i1)) (newline)
  (display (width i2)) (newline)
  (display (div-interval i1 i2)) (newline)
  (display (width (div-interval i1 i2))) (newline)
  (display (width i3)) (newline)
  (display (width i4)) (newline)
  (display (div-interval i3 i4)) (newline)
  (display (width (div-interval i3 i4))) (newline)))
