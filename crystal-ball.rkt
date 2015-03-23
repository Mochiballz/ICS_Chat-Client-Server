;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname crystal-ball) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

; base-constants

(define base-length 300)
(define base-leg 60)
(define base-angle 70)

; crystal-ball-base: number(base) number(angle) -> image
; takes in base length and angle and creates a cropped triangle of 60 pixels

(define (crystal-ball-base base angle)
  (crop-top (rotate 90 (triangle/asa angle base angle "solid" "blue"))
            (- (image-height (rotate 90 (triangle/asa angle base angle "solid" "blue"))) 60)))