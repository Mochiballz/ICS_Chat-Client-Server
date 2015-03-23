;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname house-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

; side-c-finder: number(side-a) number(side-b) -> number(side-c)
; takes in two leg sides of triangle and creates side c

(define (side-c-finder side-a side-b)
  ; side-a -> number
  ; side-b -> number
  (sqrt (+ (* side-a side-a) (* side-b side-b))))

(check-expect (side-c-finder 3 4) 5)
(check-expect (side-c-finder 8 15) 17)

; house-body-elements:
; house-body-door: string(color) -> image
; takes in a color and gives an outlined rectangle of that color

(define (house-body-door color) (rectangle 50 100 "outline" color))

; house-body-structure: number(width) number(height) string(color) -> image
; takes in a width, height, and color to create a body of a house

(define (house-body-structure width height color) (rectangle width height "outline" color))

; house-body: number(width) number(height) string(color) -> image
; takes in a width, height, and color to create a body of a house overlayed with a door

(define (house-body width height color)
  (overlay/align "middle" "bottom"
                 (house-body-door color)
                 (house-body-structure width height color)))

; house-roof: number(roof-side) number(base) string(color) -> image
; takes in the base length, the roof side length, and a color and creates a triangle for a roof

(define (house-roof roof-side base color)
  (flip-vertical (triangle/sss roof-side roof-side base "outline" color)))

; roof-height:

(define roof-height 100)

; house: number(length) number(width) string(color) -> image
; puts a roof above a body with a door overlayed

(define (house width height color)
  (above (house-roof (side-c-finder (* width 0.5) roof-height) width color)
         (house-body width height color)))




