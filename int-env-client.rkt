#lang racket

; INTERACTIVE-ENVIRONMENT: CLIENT
; dots that move on a plane

(require 2htdp/universe)
(require 2htdp/image)
(require rackunit)
(require picturing-programs)
(require test-engine/racket-tests)

; DEFINITIONS

(define DOT (square 4 "solid" "red"))
(define PLANE (rectangle 800 600 "solid" "blue"))

(define-struct object (x y act time))
(define client-element (make-object (* .5 (image-width PLANE))
                         (* .5 (image-height PLANE)) 'active 0))

; FUNCTIONS

; draw-handler: struct(str) -> image
; takes in a struct to determine what to draw
; upon "wasd" controls, square moves on window
; if idle, shows idle screen

(define (draw-handler str)
  (cond [(equal? (object-act str) 'inactive) PLANE]
        [else (place-image DOT (object-x str) (object-y str) PLANE)]))

(check-expect (draw-handler client-element) (place-image DOT 400 300 PLANE))

; key-handler: struct(str) string(key) -> struct
; changes x and y coordinates when keys are pressed

(define (key-handler str key)
  (cond [(string=? key "w") (struct-copy object str [y (- (object-y str) 4)])]
        [(string=? key "a") (struct-copy object str [x (- (object-x str) 4)])]
        [(string=? key "s") (struct-copy object str [y (+ (object-y str) 4)])]
        [(string=? key "d") (struct-copy object str [x (+ (object-x str) 4)])]
        [else str]))

(define (recieve str sexp)
  (struct-copy object str [act 'active]))

(big-bang client-element
          (on-draw draw-handler)
          (on-key key-handler)
          (on-receive recieve)
          (register LOCALHOST)
          (name "Test Client"))

(test)
