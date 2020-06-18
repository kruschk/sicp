;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 4.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\nExercise 4.1\n")

; Return the list of arguments to which a procedure shall be applied.
; Left-to-right evaluation of `exps` is guaranteed.
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (begin (define first (eval (first-operand exps) env))
             (cons first (list-of-values (rest-operands exps) env)))))

; Return the list of arguments to which a procedure shall be applied.
; Right-to-left evaluation of `exps` is guaranteed.
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (begin (define first (list-of-values (rest-operands exps) env))
             (cons (eval (first-operand exps) env) first))))
