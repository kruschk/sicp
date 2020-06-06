;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.14\n")

; Reverses the list `x` in place such that value passed in to `mystery`
; points to the last element of the modified list and the returned value
; points to the first element of the modified list. E.g.:
; (define v '(a b c d))
; v: '(a b c d)
; (define w (mystery v))
; v: '(a)
; w: '(d c b a)
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

; `mystery` returns the same list but reversed.

; v: [a|.]->[b|.]->[c|.]->[d|/]
(define v (list 'a 'b 'c 'd))
(display v) (newline)

; v: [.|/]
;     `--------------------,
;                          v
; w: [d|.]->[c|.]->[b|.]->[a|/]
(define w (mystery v))
(display v) (newline)
(display w) (newline)

(set-car! v 'z)
(display v) (newline)
(display w) (newline)

(set-car! (last-pair w) 'a)
(display v) (newline)
(display w) (newline)
