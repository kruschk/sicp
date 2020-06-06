;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.6\n")

(define rand
  (let* ((random-init 7)
         (x random-init))
    (define (rand-update x)
      (modulo (+ (* 7 x) 13) 4294967295))
    (lambda (s)
      (cond ((eq? s 'generate)
             (begin (set! x (rand-update x))
                    x))
            ((eq? s 'reset)
             (lambda (new-value) (set! x new-value))))))))

(display (rand 'generate)) (newline)
(display (rand 'generate)) (newline)
(display (rand 'generate)) (newline)
(display (rand 'generate)) (newline)
((rand 'reset) 17)
(display (rand 'generate)) (newline)
(display (rand 'generate)) (newline)
(display (rand 'generate)) (newline)
(display (rand 'generate)) (newline)
