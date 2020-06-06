;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.13
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.13\n")

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

; Original:
; [a|.]->[b|.]->[c|/]
; Cyclic:
; [a|.]->[b|.]->[c|.]-,
;  ^                  |
;  `------------------'
; So trying to compute `(last-pair z)` results in an infinite loop!
;(last-pair z) ; Infinite loop!
