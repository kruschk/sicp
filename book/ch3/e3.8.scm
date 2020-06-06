;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.8\n")

(define f
  (let ((mutable 1))
    (lambda (x) 
      (if (= 0 x)
          (begin (set! mutable (- mutable 1))
                 mutable)
          mutable))))

(display (+ (f 0) (f 1))) (newline)
(display (+ (f 1) (f 0))) (newline)
