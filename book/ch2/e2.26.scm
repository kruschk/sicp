;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.27
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.27\n")

(let ((x (list 1 2 3))
      (y (list 4 5 6)))
  (display (append x y)) (newline)
  (display (cons   x y)) (newline)
  (display (list   x y)) (newline))
