;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname button) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require picturing-programs)

; button-constants
; b = button

(define b-color "green")
(define b-color-hover "lime")
(define b-color-pressed "red")

(define b-point-1 (make-posn 10 10))
(define b-point-2 (make-posn 10 30))
(define b-point-3 (make-posn 50 30))
(define b-point-4 (make-posn 50 10))

; scene-constants
; s = scene

(define s-width 800)
(define s-height 500)

; button: posn(posn-1) posn(posn-1) posn(posn-1) posn(posn-1) string(color) string(color-hover) string(color-pressed) -> struct
; takes in the following arguments to create a struct that describes the button's attributes

(define-struct button-values (posn-1 posn-2 posn-3 posn-4 color color-hover color-pressed))
(define button (make-button-values b-point-1 b-point-2 b-point-3 b-point-4 b-color b-color-hover b-color-pressed))

; button-drawer: struct(button) -> image
; takes in four coordinates to create a button with those specific points
; overlayed on an empty scene using "overlay"

(define (button-drawer struct)
  (overlay/align "left" "top" (polygon (list (button-values-posn-1 struct)
                              (button-values-posn-2 struct)
                              (button-values-posn-3 struct)
                              (button-values-posn-4 struct))
                    "solid"
                    (button-values-color struct))
           (empty-scene s-width s-height)))
           

; button-mouse-handler: image(old) number(x) number(y) string(event) -> image
; takes in the following parameters to create an interactive button
; the button changes color on hover
; shows image when pressed

