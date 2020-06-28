;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 4.42
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 4.42\n")

; This procedure should solve the problem.
(define (exam-placements)
  (let ((betty (amb 1 2 3 4 5))
        (ethel (amb 1 2 3 4 5))
        (joan  (amb 1 2 3 4 5))
        (kitty (amb 1 2 3 4 5))
        (mary  (amb 1 2 3 4 5)))
    (require (distinct? (list betty ethel joan kitty mary)))
    (require (or (= kitty 2) (= betty 3)))
    (require (or (= ethel 1) (= joan  2)))
    (require (or (= joan  3) (= ethel 5)))
    (require (or (= kitty 2) (= mary  4)))
    (require (or (= mary  4) (= betty 1)))
    (list (list 'betty betty)
          (list 'ethel ethel)
          (list 'joan  joan)
          (list 'kitty kitty)
          (list 'mary  mary))))
