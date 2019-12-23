;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 1.19
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 1.19\n")
; The transformation T_pq is defined as:
; T_pq:
;     a <- bq + aq + ap
;     b <- bp + aq

; Applying this transformation once yields a'
; a' <- bq + aq + ap
; b' <- bp + aq

; Applying it again yields a''
; a'' <- b'q + a'q + a'p = (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
; b'' <- b'p + a'q = (bp + aq)p + (bq + aq + ap)q

; That is to say:
; a'' <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
; b'' <- (bp + aq)p + (bq + aq + ap)q

; Rearranging the RHS of a'':
; a'' <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
; a'' <- bpq + aqq + bqq + aqq + apq + bpq + apq + app
; a'' <- b(2pq + qq) + aqq + aqq + apq + apq + app
; a'' <- b(2pq + qq) + a*(2pq + qq) + aqq + app
; a'' <- b(2pq + qq) + a*(2pq + qq) + a*(qq + pp)

; Rearranging the RHS of b'':
; b'' <- (bp + aq)p + (bq + aq + ap)q
; b'' <- b*(qq + pp) + a*(2pq + qq)

; So the transformation T_p'q' is equivalent to:
; T_p'q':
;     a'' <- b(2pq + qq) + a*(2pq + qq) + a*(qq + pp)
;     b'' <- b*(qq + pp) + a*(2pq + qq)

; Or, in terms of p' and q':
; T_p'q':
;     a'' <- bq' + aq' + ap'
;     b'' <- bp' + aq'

; Which has the same form as the original (T_pq).

; So the procedure is defined as:
(define (fib n)
  (define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count) (fib-iter a
                                   b
                                   (+ (square q) (square p)) ; My answer.
                                   (+ (* 2 p q) (square q))  ; My answer.
                                   (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))
  (fib-iter 1 0 0 1 n))

(display (fib 0)) (newline)
(display (fib 1)) (newline)
(display (fib 2)) (newline)
(display (fib 3)) (newline)
(display (fib 4)) (newline)
(display (fib 5)) (newline)
(display (fib 6)) (newline)
(display (fib 7)) (newline)
(display (fib 8)) (newline)
(display (fib 9)) (newline)
