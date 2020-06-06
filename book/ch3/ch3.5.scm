;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 3.5 Streams
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "3.5 Streams\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 3.5.1 Streams Are Delayed Lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "3.5.1 Streams Are Delayed Lists\n")

; From section 1.2
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

(define (sum-primes a b)
  (define (iter count accum)
    (cond ((> count b) accum)
          ((prime? count) (iter (+ count 1) (+ count accum)))
          (else (iter (+ count 1) accum))))
  (iter a 0))
(display (sum-primes 43 102)) (newline)

; From section 2.2
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low
            (enumerate-interval (+ low 1)
                                high))))
(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (sum-primes a b)
  (accumulate +
              0
              (filter prime? (enumerate-interval a b))))
(display (sum-primes 43 102)) (newline)

;(display (car (cdr (filter prime?
;                           (enumerate-interval 10000 1000000))))) (newline)

(stream-car (cons-stream 'x 'y))
(stream-cdr (cons-stream 'x 'y))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))

; (cons-stream <a> <b>) = (cons <a> (delay <b>))

;(define (stream-car stream) (car stream))
;(define (stream-cdr stream) (force (cdr stream)))

; The stream implementation in action
(display "\nThe stream implementation in action\n")

;(stream-car (stream-cdr (stream-filter
;                          prime?
;                          (stream-enumerate-interval 10000 1000000))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low
                   (stream-enumerate-interval (+ low 1) high))))

(stream-car (stream-cdr (stream-filter
                          prime?
                          (stream-enumerate-interval 10000 1000000))))

(cons 10000
      (delay (stream-enumerate-interval 10001 1000000)))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(cons 10001
      (delay (stream-enumerate-interval 10001 1000000)))

;(cons-stream (stream-car stream)
;             (stream-filter pred (stream-cdr stream)))

(cons 100007
      (delay (stream-filter prime?
                            (cons 10008
                                  (delay (stream-enumerate-interval
                                           10009
                                           1000000))))))
(cons 100009
      (delay (stream-filter prime?
                            (cons 10010
                                  (delay (stream-enumerate-interval
                                           10011
                                           1000000))))))

; Implementing delay and force
(display "\nImplementing delay and force\n")

; (delay <exp>) = (lambda () expr)

(define (force delayed-object)
  (delayed-object))

(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))

; (delay <exp>) = (memo-proc (lambda () <exp>))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 3.5.2 Infinite Streams
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n3.5.2 Infinite Streams\n")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))
(define no-sevens
  (stream-filter (lambda (x) (not (divisible? x 7)))
                 integers))

(display (stream-ref no-sevens 100)) (newline)

(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))
(define fibs (fibgen 0 1))

(define (sieve stream)
  (cons-stream (stream-car stream)
               (sieve (stream-filter
                        (lambda (x)
                          (not (divisible? x (stream-car stream))))
                        (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))
(display (stream-ref primes 50)) (newline)

; Defining streams implicitly
(display "\nDefining streams implicitly\n")

(define ones (cons-stream 1 ones))

; The `stream-map` procedure from Exercise 3.50.
(define (stream-map proc . argstream)
  (if (null? (car argstream))
      the-empty-stream
      (cons-stream (apply proc
                          (map stream-car argstream))
                   (apply stream-map
                          (cons proc (map stream-cdr argstream))))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define integers (cons-stream 1 (add-streams ones integers)))

(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs)
                                         fibs))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define double (cons-stream 1 (scale-stream double 2)))

(define primes
  (cons-stream 2
               (stream-filter prime? (integers-starting-from 3))))

(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) true)
          ((divisible? n (stream-car ps)) false)
          (else (iter (stream-cdr ps)))))
  (iter primes))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 3.5.3 Exploiting the Stream Paradigm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n3.5.3 Exploiting the Stream Paradigm\n")

; Formulating iterations as stream processes
(display "\nFormulating iterations as stream processes\n")

(define (sqrt-improve guess x)
  (define (average x y)
    (/ (+ x y) 2))
  (average guess (/ x guess)))
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)
;(display-stream (sqrt-stream 2))

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s) (partial-sums s))))
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))
(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))
;(display-stream pi-stream)

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))
;(display-stream (euler-transform pi-stream))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))
;(display-stream (accelerated-sequence euler-transform
;                                      pi-stream))

; Infinite streams of pairs
(display "\nInfinite streams of pairs\n")

;(stream-filter (lambda (pair)
;                 (prime? (+ (car pair) (cadr pair))))
;               int-pairs)

;(stream-map (lambda (x) (list (stream-car s) x))
;            (stream-cdr t))

;(define (pairs s t)
;  (cons-stream
;    (list (stream-car s) (stream-car t))
;    (<combine-in-some-way>
;      (stream-map (lambda (x) (list (stream-car s) x))
;                  (stream-cdr t))
;      (pairs (stream-cdr s) (stream-cdr t)))))

;(define (stream-append s1 s2)
;  (if (stream-null? s1)
;      s2
;      (cons-stream (stream-car s1)
;                   (stream-append (stream-cdr s1) s2))))

;(pairs integers integers)

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))
(define (pairs s t)
  (cons-stream (list (stream-car s) (stream-car t))
               (interleave (stream-map (lambda (x) (list (stream-car s) x))
                                       (stream-cdr t))
                           (pairs (stream-cdr s) (stream-cdr t)))))
(define int-pairs (pairs integers integers))
;(display-stream int-pairs)

;(display-stream (stream-filter (lambda (pair)
;                                 (prime? (+ (car pair) (cadr pair))))
;                               int-pairs))

; Streams as signals
(display "\nStreams as signals\n")

;(define (integral integrand initial-value dt)
;  (define int
;    (cons-stream initial-value
;                 (add-streams (scale-stream integrand dt)
;                              int)))
;  int)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 3.5.4 Streams and Delayed Evaluation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "\n3.5.4 Streams and Delayed Evaluation\n")

;(define int
;  (cons-stream initial-value
;               (add-streams (scale-stream integrand dt)
;                            int)))

;(define (solve f y0 dt)
;  (define y (integral dy y0 dt))
;  (define dy (stream-map f y))
;  y)

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

; This doesn't work and I'm not sure why.
;(display (stream-ref (solve (lambda (y) y) 1 0.001) 1000)) (newline)

; Normal-order evaluation
(display "\nNormal-order evaluation\n")

; 3.5.5 Modularity of Functional Programs and Modularity of Objects
(display
  "\n3.5.5 Modularity of Functional Programs and Modularity of Objects\n")

(define random-init 0)
(define (rand-update x)
  (modulo (+ (* 7 x) 13) 4294967295))
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))
(define random-numbers
  (cons-stream random-init
               (stream-map rand-update random-numbers)))
(define (map-successive-pairs f s)
  (cons-stream
    (f (stream-car s) (stream-car (stream-cdr s)))
    (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define cesaro-stream
  (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1))
                        random-numbers))
(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo
        (stream-cdr experiment-stream) passed failed))
    (if (stream-car experiment-stream)
        (next (+ passed 1) failed)
        (next passed (+ failed 1))))
  (define pi
    (stream-map (lambda (p) (sqrt (/ 6 p)))
                (monte-carlo cesaro-stream 0 0))))

; A functional-programming view of time
(display "\nA functional-programming view of time\n")

(define (make-simplified-withrdaw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))

(define (stream-withdraw balance amount-stream)
  (cons-stream balance
               (stream-withdraw (- balance (stream-car amount-stream))
                                (stream-cdr amount-stream))))
