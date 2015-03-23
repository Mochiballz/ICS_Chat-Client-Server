;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 21-3-8_21-4-11_work) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

; 21.3.8

(define-struct time (hours minutes seconds))
(define chicago-time (make-time 13 30 0))
(define tokyo-time (make-time 3 30 0))

; 21.4.10

(define (seconds-since-midnight time)
  (+ (* (time-hours time) 60 60)
     (* (time-minutes time) 60)
     (time-seconds time)))

(check-expect (seconds-since-midnight chicago-time) 48600)
(check-expect (seconds-since-midnight tokyo-time) (+ 10800 1800))
              
; 21.4.11

(define (seconds-between time-1 time-2)
  (abs (- (seconds-since-midnight time-1) (seconds-since-midnight time-2))))

