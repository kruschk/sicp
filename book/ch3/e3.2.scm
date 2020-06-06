;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.2\n")

(define (make-monitored f)
  (let ((count 0))
    (lambda (symbol)
      (cond ((eq? symbol 'how-many-calls?) count)
            ((eq? symbol 'reset) (set! count 0))
            (else (begin (set! count (+ count 1))
                         (f symbol)))))))

(define s (make-monitored sqrt))
(display (s 100)) (newline)
(display (s 169)) (newline)
(s 'reset)
(display (s 'how-many-calls?)) (newline)
