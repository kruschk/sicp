;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 3.50
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 3.50\n")

(define (stream-map proc . argstream)
  (if (null? (car argstream))
      the-empty-stream
      (cons-stream (apply proc
                          (map stream-car argstream))
                   (apply stream-map
                          (cons proc (map stream-cdr argstream))))))

(display (stream->list (stream-map +
                                   (stream 1 2 3)
                                   (stream 4 5 6))))
(newline)
