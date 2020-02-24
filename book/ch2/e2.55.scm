;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.55
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.55\n")

; All of the following construct the same things:
(display ''abracadabra) (newline)
(display (car ''abracadabra)) (newline)
(display (cadr ''abracadabra)) (newline)

(display (quote (quote abracadabra))) (newline)
(display (car (quote (quote abracadabra)))) (newline)
(display (cadr (quote (quote abracadabra)))) (newline)

(display '(quote abracadabra)) (newline)
(display (car '(quote abracadabra))) (newline)
(display (cadr '(quote abracadabra))) (newline)

(display (quote 'abracadabra)) (newline)
(display (car (quote 'abracadabra))) (newline)
(display (cadr (quote 'abracadabra))) (newline)
; Due to the leftmost quote, the argument that is actually sent to `car` is
; the list `(quote abracadabra)` (alternatively, just `'abracadabra`). Since
; `car` takes the first element of a list, the result is simply "quote".
