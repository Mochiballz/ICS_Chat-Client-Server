;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname mouse-handlers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

; animation-elements: 

; background: image

(define background-width 500)
(define background-height 500)
(define background (empty-scene background-width
                                background-height))

; reserverd-area: image

(define reserved-area-width 100)
(define reserved-area-height 100)
(define reserved-area (rectangle reserved-area-width
                                 reserved-area-height
                                 "outline"
                                 "black"))

; cursor: image

(define cursor (overlay/align "middle" "middle"
                              (rectangle 50 2 "solid" "blue")
                              (rectangle 2 50 "solid" "blue")))

; reserved-area-placer: number(x-coord) number(y-coord) -> image
; takes in two numbers and places the reserved area according to the x and y coordinates inputted
; the x coordinate and y coordinate must be at least 50 or bigger

(define (reserved-area-placer x-coord y-coord)
  (cond [ (< x-coord 50)
          "This number is not valid. Please choose a value above 50." ]
        [ else (cond [ (< y-coord 50)
                       "This number is not valid. Please choose a value above 50." ]
                     [ else (place-image reserved-area x-coord y-coord background) ] ) ] ))

(check-expect (reserved-area-placer 50 50) (place-image reserved-area 50 50 background))
(check-expect (reserved-area-placer 43 23) "This number is not valid. Please choose a value above 50.")

(define (moving-square in-x x-lim1 x-lim2 inc-x)
  (cond [ (= in-x x-lim1)
          (+ in-x inc-x) ]
        [ else (cond [ (= in-x x-lim2)
                       (- in-x inc-x) ]
                     [ else (cond [ (> in-x x-lim1)
                                    (+ in-x inc-x) ]
                                  [ else (cond [ (< in-x x-lim2)
                                                 (- in-x inc-x) ]
                                               [ else in-x ] ) ] ) ] ) ] ))

(define (moving-square-handler x)
  (moving-square x 25 75 1))

(check-expect (moving-square 50 25 60 1) 51)

(define (place-imager x)
  (place-image (square 5 "solid" "green") 
               (moving-square-handler x) 
               50 (empty-scene 250 250)))

(big-bang 50
          (on-draw place-imager)
          (on-tick moving-square-handler 0.01))
                      
                                   