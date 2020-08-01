;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.1 Designing Register Machines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "5.1 Designing Register Machines\n")

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.1.1 A Language for Describing Register Machines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.1.1 A Language for Describing Register Machines\n")

;(data-paths
;  (registers
;    ((name a)
;     (buttons ((name a<-b) (source (register b)))))
;    ((name b)
;     (buttons ((name b<-t) (source (register t)))))
;    ((name t)
;     (buttons ((name t<-r) (source (operation rem)))))))

;(operations
;  ((name rem)
;   (inputs (register a) (register b)))
;  ((name =)
;   (inputs (register b) (constant 0))))

;(controller
;  test-b                    ; label
;  (test =)                  ; test
;  (branch (label gcd-done)) ; conditional branch
;  (t<-r)                    ; button push
;  (a<-b)                    ; button push
;  (b<-t)                    ; button push
;  (goto (label test-b))     ; unconditional branch
;  gcd-done)                 ; label

;(controller
;  test-b
;  (test (op =) (reg b) (const 0))
;  (branch (label gcd-done))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label test-b))
;  gcd-done)

; Actions
(display "\nActions\n")

;(perform (op print) (reg a))

;(controller
;  gcd-loop
;  (assign a (op read))
;  (assign b (op read))
;  test-b
;  (test (op =) (reg b) (const 0))
;  (branch (label gcd-done))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label test-b))
;  gcd-done
;  (perform (op print) (reg a))
;  (goto (label gcd-loop)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.1.2 Abstraction in Machine Design
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.1.2 Abstraction in Machine Design\n")

(define (remainder n d)
  (if (< n d)
      n
      (remainder (- n d) d)))

;(assign t (op rem) (reg a) (reg b))

;(controller
;  test-b
;  (test (op =) (reg b) (const 0))
;  (branch (label gcd-done))
;  (assign t (reg a))
;  rem-loop
;  (test (op <) (reg t) (reg b))
;  (branch (label rem-done))
;  (assign t (op -) (reg t) (reg b))
;  (goto (label rem-loop))
;  rem-done
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label test-b))
;  gcd-done)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.1.3 Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.1.3 Subroutines\n")

;(controller
;  gcd-1
;  (test (op =) (reg b) (const 0))
;  (branch (label after-gcd-1))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label gcd-1))
;  after-gcd-1
;  ...
;  gcd-2
;  (test (op =) (reg d) (const 0))
;  (branch (label after-gcd-2))
;  (assign s (op rem) (reg c) (reg d))
;  (assign c (reg d))
;  (assign d (reg s))
;  (goto (label gcd-2))
;  after-gcd-2)

;(controller
;  gcd-1
;  (test (op =) (reg b) (const 0))
;  (branch (label after-gcd-1))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label gcd-1))
;  after-gcd-1
;  ...
;  gcd-2
;  (test (op =) (reg b) (const 0))
;  (branch (label after-gcd-2))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label gcd-2))
;  after-gcd-2)

;(controller
;  gcd
;  (test (op =) (reg b) (const 0))
;  (branch (label gcd-done))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label gcd))
;  gcd-done
;  (test (op =) (reg continue) (const 0))
;  (branch (label after-gcd-1))
;  (goto (label after-gcd-2))
;  ...
;  ;; Before branching to gcd from the first place where it is needed, we
;  ;; place 0 in the continue register
;  (assign continue (const 0))
;  (goto (label gcd))
;  after-gcd-1
;  ;; Before the second use of gcd, we place 1 in the continue register
;  (assign continue (const 1))
;  (goto (label gcd))
;  after-gcd-2)

;(controller
;  gcd
;  (test (op =) (reg b) (const 0))
;  (branch (label gcd-done))
;  (assign t (op rem) (reg a) (reg b))
;  (assign a (reg b))
;  (assign b (reg t))
;  (goto (label gcd))
;  gcd-done
;  (goto (reg continue))
;  ...
;  ;; Before calling gcd, we assign to continue the label to which gcd should
;  ;; return.
;  (assign continue (label after-gcd-1))
;  (goto (label gcd))
;  after-gcd-1
;  ;; Here is the second call to gcd, with a different continuation.
;  (assign continue (label after-gcd-2))
;  (goto (label gcd))
;  after-gcd-2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.1.4 Using a Stack to Implement Recursion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.1.4 Using a Stack to Implement Recursion\n")

(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; A double recursion
(display "\nA double recursion\n")

(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

;(controller
;  (assign continue (label fact-done))
;  fact-loop
;  (test (op =) (reg n) (const 1))
;  (branch (label base-case))
;  ;; Set up for the recursive call by saving n and continue.
;  ;; Set up continue so that the computation will continue at after-fact
;  ;; when the subroutine returns.
;  (save continue)
;  (save n)
;  (assign n (op -) (reg n) (const 1))
;  (assign continue (label after-fact))
;  (goto (label fact-loop))
;  after-fact
;  (restore n)
;  (restore continue)
;  (assign val (op *) (reg n) (reg val)) ; val now contains n(n - 1)!
;  (goto (reg continue))                 ; return to caller
;  base-case
;  (assign val (const 1))                ; base case: 1! = 1
;  (goto (reg continue))                 ; return to caller
;  fact-done)

;(controller
;  (assign continue (label fib-done))
;  fib-loop
;  (test (op <) (reg n) (const 2))
;  (branch (label immediate-answer))
;  ;; set up to compute Fib(n - 1)
;  (save continue)
;  (assign continue (label afterfib-n-1))
;  (save n)                            ; save old value of n
;  (assign n (op -) (reg n) (const 1)) ; clobber n to n - 1
;  (goto (label fib-loop))             ; perform recursive call
;  afterfib-n-1                        ; upon return, val contains Fib(n - 1)
;  (restore n)
;  (restore continue)
;  ;; set up to compute Fib(n - 2)
;  (assign n (op -) (reg n) (const 2))
;  (save continue)
;  (assign continue (label afterfib-n-2))
;  (save val)                        ; save Fib(n - 1)
;  (goto (label fib-loop))
;  afterfib-n-2                      ; upon return, val contains Fib(n - 2)
;  (assign n (reg val))              ; n now contains Fib(n - 2)
;  (restore val)                     ; val now contains Fib(n - 1)
;  (restore continue)
;  (assign val                       ; Fib(n - 1) + Fib(n - 2)
;          (op +) (reg val) (reg n))
;  (goto (reg continue))             ; return to caller, answer is in val
;  immediate-answer
;  (assign val (reg n))              ; base case: Fib(n) = n
;  (goto (reg continue))
;  fib-done)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.1.5 Instruction Summary
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.1.5 Instruction Summary\n")

;(assign <register-name (reg <register-name>))
;(assign <register-name (const <constant-value>))
;(assign <register-name (op <operation-name>) <input1> ... <inputn>)
;(perform (op <operation-name>) <input1> ... <inputn>)
;(test (op <operation-name>) <input1> ... <inputn>)
;(branch (label <label-name>))
;(goto (label <label-name>))

;(assign <register-name> (label <label-name>))
;(goto (reg <register-name>))

;(save <register-name>)
;(restore <register-name>)
