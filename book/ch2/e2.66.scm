;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Exercise 2.66
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(display "Exercise 2.66\n")

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key (key set-of-records)) set-of-records)
        ((< given-key (key set-of-records))
         (lookup given-key (left-tree set-of-records)))
        ((> given-key (key set-of-records))
         (lookup given-key (right-tree set-of-records)))))
