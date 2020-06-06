;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.53
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.53\n")

; Helpers
(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

; Define a special stream, `s`.
(define s (cons-stream 1 (add-streams s s)))

;(s (cons-stream 1 (add-stream (cons-stream 1 (add-streams s s))
;                              (cons-stream 1 (add-streams s s)))))
; Prediction: `s` will generate s(n) = 2^n for n = 0, 1, 2, ....

(display (stream-ref s 0)) (newline) ; 1
(display (stream-ref s 1)) (newline) ; 2
(display (stream-ref s 2)) (newline) ; 4
(display (stream-ref s 3)) (newline) ; 8
(display (stream-ref s 4)) (newline) ; 16
; ...

; So it does!
