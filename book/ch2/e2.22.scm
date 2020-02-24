;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.22
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.22\n")

; Louis' first attempt:
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))
(display (square-list (list 1 2 3 4))) (newline)
; The answer gets reversed because it starts with the empty list, then it
; get's built out (or backward) as we iterate forward through the source
; list. For example, (1 2 3 4) is equivalent to (1 . (2 . (3 . (4 . ())))),
; so as we go through the list, starting at 1, we construct the answer as
; follows: () -> (1 . ()) -> (4 . (1 . ())) -> (9 . (4 . (1 . ()))) ->
; (16 . (9 . (4 . (1 . ())))), and the squared list has clearly been
; reversed.

; Louis' second attempt:
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))
(display (square-list (list 1 2 3 4))) (newline)
; Although this approach appears promising at first, it doesn't work
; because the data structure that is constructed is no longer a list. It is
; a different data structure where the first element of the pair points to
; the rest of the "list", and the second element of the pair points to the
; data. In a proper list, the first element stores the data and the second
; element points to the rest of the list.
