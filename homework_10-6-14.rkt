;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname homework_10-6-14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

(define (move-left img)
  (beside (square 1 "solid" "white") img))

(define (move-down img)
  (above (square 1 "solid" "white") img))

(define (move-down-handler img x y source)
  (move-down img))

(define (reset img)
  (place-image img 0 0 (square 1000 "solid" "white")))

(define (reset-handler img key)
  (reset img))

(big-bang pic:calendar
     (on-draw reset)
     (on-key reset-handler)
     (on-mouse move-down-handler)
     (on-tick move-left 0.01))

;this is stupid. can't even.
