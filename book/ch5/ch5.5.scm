;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5 Compilation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "5.5 Compilation\n")

; An overview of the compiler
(display "\nAn overview of the compiler\n")

;(assign proc (op lookup-variable-value) (const f) (reg env))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5.1 Structure of the Compiler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.5.1 Structure of the Compiler\n")

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp) (compile-variable exp target linkage))
        ((assignment? exp) (compile-assignment exp target linkage))
        ((definition? exp) (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           taget
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((application? exp) (compile-application exp target linkage))
        (else (error "Unknown expression type -- COMPILE" exp))))

; Targets and linkages
(display "\nTargets and linkages\n")

;(assign val (const 5))

;(assign val (const 5))
;(goto (reg continue))

; Instruction sequences and stack usage
(display "\nInstruction sequences and stack usage\n")

;(append-instruction-sequences <seq1> <seq2>)

;<seq1>
;<seq2>

;(preserving (list <reg1> <reg2>) <seq1> <seq2>)

(define (make-instruction-sequence needs modifies statements)
  (list needs modifies statements))

(make-instruction-sequence
  '(env continue) '(val)
  '((assign val (op lookup-variable-value) (const x) (reg env))
    (goto (reg continue))))

(define (empty-instruction-sequence)
  (make-instruction-sequence '() '() '()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5.2 Compiling Expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.5.2 Compiling Expressions\n")

; Compiling linkage code
(display "\nCompiling linkage code\n")

(define (compile-linkage linkage)
  (cond ((eq? linkage 'return)
         (make-instruction-sequence '(continue) '()
                                    '((goto (reg continue)))))
        ((eq? linkage 'next)
         (empty-instruction-sequence))
        (else
          (make-instruction-sequence '() '()
                                     `((goto (label ,linkage)))))))

(define (end-with-linkage linkage instruction-sequence)
  (preserving '(continue)
              instruction-sequence
              (compile-linkage linkage)))

; Compiling simple expressions
(display "\nCompiling simple expressions\n")

(define (compile-self-evaluating exp target linkage)
  (end-with-linkage
    linkage
    (make-instruction-sequence '()
                               (list target)
                               `((assign ,target (const ,exp))))))
(define (compile-quoted exp target linkage)
  (end-with-linkage
    linkage
    (make-instruction-sequence
      '()
      (list target)
      `((assign ,target (const ,(text-of-quotation exp)))))))
(define (compile-with-variable exp target linkage)
  (end-with-linkage
    linkage
    (make-instruction-sequence '(env)
                               (list target)
                               `((assign ,target
                                         (op lookup-variable-value)
                                         (const ,exp)
                                         (reg env))))))

(define (compile-assignment exp target linkage)
  (let ((var (assignment-variable exp))
        (get-value-code (compile (assignment-value exp) 'val 'next)))
    (end-with-linkage
      linkage
      (preserving
        '(env)
        get-value-code
        (make-instruction-sequence '(env val)
                                   (list target)
                                   `((perform (op set-variable-value!)
                                              (const ,var)
                                              (reg val)
                                              (reg env))
                                     (assign ,target (const ok))))))))
(define (compile-definition exp target linkage)
  (let ((var (definition-variable exp))
        (get-value-code (compile (definition-value exp) 'val 'next)))
    (end-with-linkage
      linkage
      (preserving
        '(env)
        get-value-code
        (make-instruction-sequence '(env val) (list target)
                                   `((perform (op define-variable!)
                                              (const ,var)
                                              (reg val)
                                              (reg env))
                                     (assign ,target (const ok))))))))

; Compiling conditional expressions
(display "\nCompiling conditional expressions\n")

;<compilation of predicate, target val, linkage next>
;(test (op false?) (reg val))
;(branch (label false-branch))
;true-branch
;<compilation of consequent with given target and given linkage or after-if>
;false-branch
;<compilation of alternative with given target and linkage>
;after-if

(define (compile-if exp target linkage)
  (let ((t-branch (make-label 'true-branch))
        (f-branch (make-label 'false-branch))
        (after-if (make-label 'after-if)))
    (let ((consequent-linkage
            (if (eq? linkage 'next) after-if linkage)))
      (let ((p-code (compile (if-predicate-exp) 'val 'next))
            (c-code (compile (if-consequent exp) target consequent-linkage))
            (a-code (compile (if-alternative exp) target linkage)))
        (preserving
          '(env continue)
          p-code
          (append-instruction-sequences
            (make-instruction-sequence '(val)
                                       '()
                                       `((test (op false?) (reg val))
                                         (branch (label ,f-branch))))
            (parallel-instruction-sequences
              (append-instruction-sequences t-branch c-code)
              (append-instruction-sequences f-branch a-code))
            after-if))))))

; Compiling sequences
(display "\nCompiling sequences\n")

(define (compile-sequence seq target linkage)
  (if (last-exp? seq)
      (compile (first-exp seq) target linkage)
      (preserving '(env continue)
                  (compile (first-exp seq) target 'next)
                  (compile-sequence (rest-exps seq) target linkage))))

; Compiling lambda expressions
(display "\nCompiling lambda expressions\n")

;<construct procedure object and assign it to target register>
;<linkage>

;<construct procedure object and assign it to target register>
;<code for given linkage> or (goto (label after-lambda))
;<compilation of procedure body>
;after-lambda

(define (compile-lambda exp target linkage)
  (let ((proc-entry (make-label 'entry))
        (after-lambda (make-label 'after-lambda)))
    (let ((lambda-linkage (if (eq? linkage 'next) after-lambda linkage)))
      (append-instruction-sequences
        (tack-on-instruction-sequence
          (end-with-linkage
            lambda-linkage
            (make-instruction-sequence
              '(env)
              (list target)
              `((assign ,target
                        (op make-compiled-procedure)
                        (label ,proc-entry)
                        (reg env)))))
          (compile-lambda-body exp proc-entry))
        after-lambda))))

(define (compile-lambda-body exp proc-entry)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
      (make-instruction-sequence
        '(env proc argl)
        '(env)
        `(,proc-entry
           (assign env (op compiled-procedure-env) (reg proc))
           (assign env
                   (op extend-environment)
                   (const ,formals)
                   (reg argl)
                   (reg env))))
      (compile-sequence (lambda-body exp) 'val 'return))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5.3 Compiling Combinations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.5.3 Compiling Combinations\n")

;<compilation of operator, target proc, linkage next>
;<evaluate operands and construct argument list in argl>
;<compilation of procedure call with given target and linkage>

(define (compile-application exp target linkage)
  (let ((proc-code (compile (operator exp) 'proc 'next))
        (operand-codes (map (lambda (operand) (compile operand 'val 'next))
                            (operands exp))))
    (preserving '(env continue)
                proc-code
                (preserving '(proc continue)
                            (construct-arglist operand-codes)
                            (compile-procedure-call target linkage)))))

;<compilation of last operand, targeted to val>
;(assign argl (op list) (reg val))
;<compilation of next operand, targeted to val>
;(assign argl (op cons) (reg val) (reg argl))
;...<compilation of first operand, targeted to val>
;(assign argl (op cons) (reg val) (reg argl))

;(assign argl (const ()))

(define (construct-arglist operand-codes)
  (let ((operand-codes (reverse operand-codes)))
    (if (null? operand-codes)
        (make-instruction-sequence '()
                                   '(argl)
                                   '((assign argl (const ()))))
        (let ((code-to-get-last-arg
                (append-instruction-sequences
                  (car operand-codes)
                  (make-instruction-sequence
                    '(val)
                    '(argl)
                    '((assign argl (op list) (reg val)))))))
          (if (null? (cdr operand-codes))
              code-to-get-last-arg
              (preserving '(env)
                          code-to-get-last-arg
                          (code-to-get-rest-args (cdr operand-codes))))))))
(define (code-to-get-rest-args operand-codes)
  (let ((code-for-next-arg
          (preserving
            '(argl)
            (car operand-codes)
            (make-instruction-sequence
              '(val argl)
              '(argl)
              '((assign argl (op cons) (reg val) (reg argl)))))))
    (if (null? (cdr operand-codes))
        (code-for-next-arg
          (preserving '(env)
                      code-for-next-arg
                      (code-to-get-rest-args (cdr operand-codes)))))))

; Applying procedures
(display "\nApplying procedures\n")

;(test (op primitive-procedure?) (reg proc))
;(branch (label primitive-branch))
;compiled-branch
;<code to apply compiled procedure with given target and appropriate linkage>
;primitive-branch
;(assign <target>
;        (op apply-primitive-procedure)
;        (reg proc)
;        (reg argl))
;<linkage>
;after-call

(define (compile-procedure-call target linkage)
  (let ((primitive-branch (make-label 'primitive-branch))
        (compiled-branch (make-label 'compiled-branch))
        (after-call (make-label 'after-call)))
    (let ((compiled-linkage (if (eq? linkage 'next) after-call linkage)))
      (append-instruction-sequences
        (make-instruction-sequence
          '(proc)
          '()
          `((test (op primitive-procedure?) (reg proc))
            (branch (label ,primitive-branch))))
        (parallel-instruction-sequences
          (append-instruction-sequences
            compiled-branch
            (compile-proc-apply target compiled-linkage))
          (append-instruction-sequences
            primitive-branch
            (end-with-linkage
              linkage
              (make-instruction-sequence
                '(proc argl)
                (list target)
                `((assign ,target
                          (op apply-primitive-procedure)
                          (reg proc)
                          (reg argl)))))))
        after-call))))

; Applying compiled procedures
(display "\nApplying compiled procedures\n")

;  (assign continue (label proc-return))
;  (assign val (op compiled-procedure-entry) (reg proc))
;  (goto (reg val))
;proc-return
;  (assign <target> (reg val)) ; included if target is not val
;  (goto (label <linkage>)) ; linkage code

;  (save continue)
;  (assign continue (label proc-return))
;  (assign val (op compiled-procedure-entry) (reg proc))
;  (goto (reg val))
;proc-return
;  (assign <target> (reg val)) ; included if target is not val
;  (restore continue)
;  (goto (reg continue)) ; linkage code

;<set up continue for linkage>
;(assign val (op compiled-procedure-entry) (reg proc))
;(goto (reg val))

;(assign continue (label <linkage>))
;(assign val (op compiled-procedure-entry) (reg proc))
;(goto (reg val))

;(assign val (op compiled-procedure-entry) (reg proc))
;(goto (reg val))

(define (compile-proc-appl target linkage)
  (cond ((and (eq? target 'val) (not (eq? linkage 'return)))
         (make-instruction-sequence
           '(proc)
           all-regs
           `((assign continue (label ,linkage))
             (assign val (op compiled-procedure-entry) (reg proc))
             (goto (reg val)))))
        ((and (not (eq? target 'val))
              (not (eq? linkage 'return)))
         (let ((proc-return (make-label 'proc-return)))
           (make-instruction-sequence
             '(proc)
             all-regs
             `((assign continue (label ,proc-return))
               (assign val (op compiled-procedure-entry) (reg proc))
               (goto (reg val))
               ,proc-return
               (assign ,target (reg val))
               (goto (label ,linkage))))))
        ((and (eq? target 'val) (eq? linkage 'return))
         (make-instruction-sequence
           '(proc continue)
           all-regs
           `((asign val (op compiled-procedure-entry) (reg proc))
             (goto (reg val)))))
        ((and (not (eq? target 'val)) (eq? linkage 'return))
         (error "return linkage, target not val -- COMPILE" target))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5.4 Combining Instruction Sequences
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.5.4 Combining Instruction Sequences\n")

(define (registers-needed s)
  (if (symbol? s) '() (car s)))
(define (registers-modified s)
  (if (symbol? s) '() (cadr s)))
(define (statements s)
  (if (symbol? s) (list s) (caddr s)))

(define (needs-register seq reg)
  (memq reg (registers-needed seq)))
(define (modifies-register? seq reg)
  (memq reg (registers-modified seq)))

(define (append-instruction-sequences . seqs)
  (define (append-2-sequences seq1 seq2)
    (make-instruction-sequence
      (list-union (registers-needed seq1)
                  (list-difference (registers-needed seq2)
                                   (registers-modified seq1)))
      (list-union (registers-modified seq1)
                  (registers-modified seq2)))
    (append (statements seq1) (statements seq2)))
  (define (append-seq-list seqs)
    (if (null? seqs)
        (empty-instruction-sequence)
        (append-2-sequences (car seqs)
                            (append-seq-list (cdr seqs)))))
  (append-seq-list seqs))


(define (list-union s1 s2)
  (cond ((null? s1) s2)
        ((memq (car s1) s2) (list-union (cdr s1) s2))
        (else (cons (car s1) (list-union (cdr s1) s2)))))
(define (list-difference s1 s2)
  (cond ((null? s1) '())
        ((memq (car s1) s2) (list-difference (cdr s1) s2))
        (else (cons (car s1)
                    (list-difference (cdr s1) s2)))))

(define (preserving regs seq1 seq2)
  (if (null? regs)
      (append-instruction-sequences seq1 seq2)
      (let ((first-reg (car regs)))
        (if (and (needs-register? seq2 first-reg)
                 (modifies-register? seq1 first-reg))
            (preserving
              (cdr regs)
              (make-instruction-sequence
                (list-union (list first-reg)
                            (registers-needed seq1))
                (list-difference (registers-modified seq1)
                                 (list first-reg))
                (append `((save ,first-reg))
                        (statements seq1)
                        `((restore ,first-reg))))
              seq2)
            (preserving (cdr regs) seq1 seq2)))))

(define (tack-on-instruction-sequence seq body-seq)
  (make-instruction-sequence
    (registers-needed seq)
    (registers-modified seq)
    (append (statements seq)
            (statements body-seq))))

(define (parallel-instruction-sequences seq1 seq2)
  (make-instruction-sequence
    (list-union (registers-needed seq1)
                (registers-needed seq2))
    (list-union (registers-modified seq1)
                (registers-modified seq2))
    (append (statements seq1)
            (statements seq2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5.5 An Example of Compiled Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.5.5 An Example of Compiled Code\n")

;(compile
;  '(define (factorial n)
;     (if (= n 1)
;         1
;         (* (factorial (- n 1)) n)))
;  'val
;  'next)

;<save env if modified by code to compute value>
;<compilation of definition value, target val, linkage next>
;<restore env if saved above>
;(perform (op define-variable!)
;         (const factorial)
;         (reg val)
;         (reg env))
;(assign val (const ok))

;  (assign val (op make-compiled-procedure) (label entry2) (reg env))
;  (goto (label after-lambda))
;entry2
;  (assign env (op compiled-procedure-env) (reg proc))
;  (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
;  <compilation of procedure body>
;after-lambda1
;  (perform (op define-variable!) (const factorial) (reg val) (reg env))
;  (assign val (const ok))

;(if (= n 1)
;    1
;    (* (factorial (- n 1)) n))

;  <save continue, env if modified by predicate and needed by branches>
;  <compilation of predicate, target val, linkage next>
;  <restore continue, env if saved above>
;  (test (op false?) (reg val))
;  (branch (label false-branch4))
;true-branch5
;  <compilation of true branch, target val, linkage return>
;false-branch4
;  <compilation of false branch, target val, linkage return>
;after-if3

;  (assign proc (op lookup-variable-value) (const =) (reg env))
;  (assign val (const 1))
;  (assign argl (op list) (reg val))
;  (assign val (op lookup-variable-value) (const n) (reg env))
;  (assign argl (op cons) (reg val) (reg argl))
;  (test (op primitive-procedure?) (reg proc))
;  (branch (label primitive-branch17))
;compiled-branch16
;  (assign continue (label after-call15))
;  (assign val (op compiled-procedure-entry) (reg proc))
;  (goto (reg val))
;primitive-branch17
;  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
;after-call15

;  (assign val (const 1))
;  (goto (reg continue))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5.6 Lexical Addressing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.5.6 Lexical Addressing\n")

;(let ((x 3) (y 4))
;  (lambda (a b c d e)
;    (let ((y (* a b x))
;          (z (+ c d x)))
;      (* x y z))))

((lambda (x y)
   (lambda (a b c d e)
     ((lambda (y z) (* x y z))
      (* a b x)
      (+ c d x))))
 3
 4)

((lambda (x y)
   (lambda (a b c d e)
     ((lambda (y z) <e1>)
      <e2>
      (+ c d x))))
 3
 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5.5.7 Interfacing Compiled Code to the Evaluator
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n5.5.7 Interfacing Compiled Code to the Evaluator\n")

;(compile-and-go
;  '(define (factorial n)
;     (if (= n 1)
;         1
;         (* (factorial (- n 1)) n))))
;;;; EC-Eval value:
;ok
;;;; EC-Eval input:
;(factorial 5)
;;;; EC-Eval value:
;120

;apply-dispatch
;  (test (op primitive-procedure?) (reg proc))
;  (branch (label primitive-apply))
;  (test (op compound-procedure?) (reg proc))
;  (branch (label compound-apply))
;  (test (op compiled-procedure?) (reg proc))
;  (branch (label compiled-apply))
;  (goto (label unkown-procedure-type))
;compiled-apply
;  (restore continue)
;  (assign val (op compiled-procedure-entry) (reg proc))
;  (goto (reg val))

;  (branch (label external-entry)) ; branches if flag is set
;read-eval-print-loop
;  (perform (op initialize-stack))
;  ...

;external-entry
;  (perform (op initialize-stack))
;  (assign env (op get-global-environment))
;  (assign continue (label print-result))
;  (goto (reg val))

(define (compile-and-go expression)
  (let ((instructions (assemble (statements (compile expression
                                                     'val
                                                     'return))
                                eceval)))
    (set! the-global-environment (setup-environment))
    (set-register-contents! eceval 'val instructions)
    (set-register-contents! eceval 'flag true)
    (start eceval)))

;(compile-and-go '(define (factorial n)
;                   (if (= n 1)
;                       1
;                       (* (factorial (- n 1)) n))))

;(total-pushes = 0 maximum-depth = 0)
;;;; EC-Eval value:
;ok
;;;; EC-Eval input:
;(factorial 5)
;(total-pushes = 31 maximum-depth = 14)
;;;; EC-Eval value:
;120

; Interpretation and compilation
(display "\nInterpretation and compilation\n")
