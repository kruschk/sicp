; 1. Before Turning on your Computer
(display (- 8 9)) (newline) ; Prints -1.
(display (> 3.7 4.4)) (newline) ; Prints #f.
(display (- (if (> 3 4) 7 10) (/ 16 10))) (newline) ; (- 10 1.6) -> Prints 8.4.
(define b 13) (newline) ; b = 13. Defines have nothing to display.
(display 13) (newline) ; Prints 13.
(display b) (newline) ; Prints 13.
; Prints #[arity-dispatched-procedure 12] (no idea what that means!).
(display >) (newline)
(define square (lambda (x) (* x x))) (newline)
(display square) (newline) ; Prints #[compound-procedure 13 square].
(display (square 13)) (newline) ; Prints 169
(display (square b)) (newline) ; Prints 169
(display (square (square (/ b 1.3)))) (newline) ; Prints 10000.
(define multiply-by-itself square) (newline)
(display (multiply-by-itself b)) (newline) ; Prints 169.
(define a b) (newline) ; a = 13. Nothing to display.
(display (= a b)) (newline) ; Prints #t.
; Prints #f.
(display (if (= (* b a) (square 13))
             (< a b)
             (- a b))) (newline)
; Prints 13.
(display (cond ((>= a 2) b) ; #t
               ((< (square b) (multiply-by-itself a)) (/ 1 0)) ; #f
               (else (abs (- (square a) b))))) (newline)
