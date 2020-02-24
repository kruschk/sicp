;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.61
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.61\n")

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set))
         (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(let ((set (list 1 2 3 4 6 7 8 9 10)))
  (display (adjoin-set 4 set)) (newline)
  (display (adjoin-set 5 set)) (newline)
  (display (adjoin-set 0 set)) (newline)
  (display (adjoin-set 11 set)) (newline))
