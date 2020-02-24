;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.28
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.28\n")

; The `fringe` procedure.
; fringe: List -> List
(define (fringe x)
  (cond ((null? x) '())
        ((not (pair? x)) (list x))
        (else (append (fringe (car x)) (fringe (cdr x))))))
; It works!
(let ((x (list (list 1 2) (list 3 4))))
  (display x) (newline)
  (display (fringe x)) (newline)
  (display (fringe (list x x))) (newline))
