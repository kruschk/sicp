;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.4\n")

(define (make-account balance password)
  (define (call-the-cops x)
    "*Whoop-whoop* This is the police; come out with your hands up!")
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define dispatch
    (let ((incorrect-count 0))
      (lambda (pwd m)
        (if (eq? pwd password)
            (begin (set! incorrect-count 0)
                   (cond ((eq? m 'withdraw) withdraw)
                         ((eq? m 'deposit) deposit)
                         (else (error "Unknown request -- MAKE-ACCOUNT"
                                      m))))
            (begin (set! incorrect-count (+ incorrect-count 1))
                   (if (<= incorrect-count 7)
                       (lambda (x) "Incorrect password")
                       call-the-cops))))))
  dispatch)

(define acc (make-account 100 'secret-password))

(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
(display ((acc 'secret-password 'withdraw) 40)) (newline)
(display ((acc 'some-other-password 'deposit) 50)) (newline)
