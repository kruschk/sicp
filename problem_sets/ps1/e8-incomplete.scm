;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 8\n")
; This poorly-formatted procedure definition...
(define test-procedure
(lambda (a b)
(cond ((>= a 2) b)
   ((< (square b)
 (multiply-by-itself a))
         (/ 1 0))
(else (abs (- (square a) b))))))

; becomes this, automagically! To do this in vim, go to the first line and type
; `=7`, then hit `enter`.
(define test-procedure
  (lambda (a b)
    (cond ((>= a 2) b)
          ((< (square b)
              (multiply-by-itself a))
           (/ 1 0))
          (else (abs (- (square a) b))))))

; I'm not sure how to do it in edwin.
