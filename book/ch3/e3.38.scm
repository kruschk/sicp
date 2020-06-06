;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.38
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.38\n")

; a.
; Case 1:
(let ((balance 100))
  (set! balance (+ balance 10)) ; 110
  (display balance) (newline)
  (set! balance (- balance 20)) ; 90
  (display balance) (newline)
  (set! balance (- balance (/ balance 2))) ; 45
  (display balance) (newline) (newline))
; Case 2:
(let ((balance 100))
  (set! balance (+ balance 10)) ; 110
  (display balance) (newline)
  (set! balance (- balance (/ balance 2))) ; 55
  (display balance) (newline)
  (set! balance (- balance 20)) ; 35
  (display balance) (newline) (newline))
; Case 3
(let ((balance 100))
  (set! balance (- balance 20)) ; 80
  (display balance) (newline)
  (set! balance (+ balance 10)) ; 90
  (display balance) (newline)
  (set! balance (- balance (/ balance 2))) ; 45
  (display balance) (newline) (newline))
; Case 4
(let ((balance 100))
  (set! balance (- balance 20)) ; 80
  (display balance) (newline)
  (set! balance (- balance (/ balance 2))) ; 40
  (display balance) (newline)
  (set! balance (+ balance 10)) ; 50
  (display balance) (newline) (newline))
; Case 5
(let ((balance 100))
  (set! balance (- balance (/ balance 2))) ; 50
  (display balance) (newline)
  (set! balance (- balance 20)) ; 30
  (display balance) (newline)
  (set! balance (+ balance 10)) ; 40
  (display balance) (newline) (newline))
; Case 6
(let ((balance 100))
  (set! balance (- balance (/ balance 2))) ; 50
  (display balance) (newline)
  (set! balance (+ balance 10)) ; 60
  (display balance) (newline)
  (set! balance (- balance 20)) ; 40
  (display balance) (newline) (newline))

; b.
; If two assignments read balance at the same time, the final balance could
; become one of the intermediate value (i.e. one of the computations will be
; clobbered). For example, in case 6, above, if the last two assignments
; access `balance` at the same time, reading a value of 50, the first will
; set `balance` to 60, and the second will set it to 30. Depending on which
; procedure finishes last, the final balance could end up as either of these
; two values, neither of which conserve the proper balance of funds.
