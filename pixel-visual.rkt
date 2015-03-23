;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname pixel-visual) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

(define SIZE 20)
(define IMAGE1 (scale 0.5 (bitmap "1418987948848.jpg")))
(define BLANK (make-color 0 0 0))
(define-struct CURSOR
  (posn clr1 clr2 clr3 clr4 clr5 clr6 clr7 clr8 clr9 image))
(define x (make-CURSOR (make-posn 0 0)
                       BLANK
                       BLANK
                       BLANK
                       BLANK
                       BLANK
                       BLANK
                       BLANK
                       BLANK
                       BLANK
                       IMAGE1))

(define (mouse-handler struct x y event)
  (make-CURSOR (make-posn x y)
               (get-pixel-color (- x 1) (- y 1) (CURSOR-image struct))
               (get-pixel-color x (- y 1) (CURSOR-image struct))
               (get-pixel-color (+ x 1) (- y 1) (CURSOR-image struct))
               (get-pixel-color (- x 1) y (CURSOR-image struct))
               (get-pixel-color x y (CURSOR-image struct))
               (get-pixel-color (+ x 1) y (CURSOR-image struct))
               (get-pixel-color (- x 1) (+ y 1) (CURSOR-image struct))
               (get-pixel-color x (+ y 1) (CURSOR-image struct))
               (get-pixel-color (+ x 1) (+ y 1) (CURSOR-image struct))
               IMAGE1))

(define (draw-handler struct)
  (place-image (above (beside (square SIZE "solid" (CURSOR-clr1 struct))
                              (square SIZE "solid" (CURSOR-clr2 struct))
                              (square SIZE "solid" (CURSOR-clr3 struct)))
                      (beside (square SIZE "solid" (CURSOR-clr4 struct))
                              (square SIZE "solid" (CURSOR-clr5 struct))
                              (square SIZE "solid" (CURSOR-clr6 struct)))
                      (beside (square SIZE "solid" (CURSOR-clr7 struct))
                              (square SIZE "solid" (CURSOR-clr8 struct))
                              (square SIZE "solid" (CURSOR-clr9 struct))))
               (posn-x (CURSOR-posn struct))
               (posn-y (CURSOR-posn struct))
               (CURSOR-image struct)))

(big-bang x
          (on-draw draw-handler)
          (on-mouse mouse-handler))