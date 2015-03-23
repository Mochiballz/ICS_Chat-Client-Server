;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname lists-practice) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

(define l1 (list 1 2 3 4 5 6))
(define l2 (list 2 7 1 3 5 2))
(define l3 (list 12 13 14 15 1))
(define l4 (list 1))
(define l5 (list "potato"))
(define l6 (list 13 15))
(define l7 (list (list 1 2 3) 3 5))

(define (increasing? list)
  (cond [(or (empty? list) (= (length list) 1)) false]
        [(and (= (length list) 2) (< (first list) (first (rest list))))
         true]
        [(< (first list) (first (rest list)))
         (increasing? (rest list))]
        [else false]))

(check-expect (increasing? l1) true)
(check-expect (increasing? l2) false)
(check-expect (increasing? l3) false)
(check-expect (increasing? l4) false)
(check-expect (increasing? (list )) false)
(check-expect (increasing? l5) false)
(check-expect (increasing? l6) true)
(check-expect (increasing? l7) false)