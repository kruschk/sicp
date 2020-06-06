;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.7\n")

(define (make-account balance password)
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (dispatch pwd m)
    (if (eq? pwd password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              ((eq? m 'balance) balance)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m)))
        (lambda args "Incorrect password")))
  dispatch)

(define (make-joint account original-pwd new-pwd)
  (lambda (pwd m)
    (if (eq? pwd new-pwd)
        (account original-pwd m)
        (lambda (x) "Incorrect password"))))

(define peter-acc (make-account 100 'open-sesame))

(display (peter-acc 'open-sesame 'balance)) (newline)
(display ((peter-acc 'open-sesame 'withdraw) 40)) (newline)
(display ((peter-acc 'rosebud 'deposit) 50)) (newline)

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

(display ((paul-acc 'open-sesame 'withdraw) 15)) (newline)
(display ((paul-acc 'rosebud 'withdraw) 15)) (newline)
(display (peter-acc 'open-sesame 'balance)) (newline)
