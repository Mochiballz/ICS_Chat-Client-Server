;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname bouncy_ball_alone) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

; object: image(picture) number(∆x) number(∆y) number(x) number(y) boolean(mn1) boolean(wn) number(t) -> struct
; determines the location, appearance, and pattern of a traveling ball on a plane

(define-struct object (picture ∆x ∆y x y mn1 wn t))
(define ball (circle 40 "solid" "blue"))
(define background (rectangle 1200 700 "solid" "white"))
(define ob1 (make-object ball 3 4 (* 1/2 (image-width background))
              (* 1/2 (image-height background)) #t #f 0))

(define (tick-handler object)
  (cond ; double conditions
           [(and (<= (object-x object) (* 1/2 (image-width (object-picture object))))
                 (<= (object-y object) (* 1/2 (image-height (object-picture object)))))
            (make-object (object-picture object) (* (object-∆x object) -1)
              (* (object-∆y object) -1) (+ (object-x object) (* (object-∆x object) -1))
              (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) (object-wn object) (object-t object))]
           [(and (<= (object-x object) (* 1/2 (image-width (object-picture object))))
                 (>= (object-y object) (- (image-height background) (* 1/2 (image-height (object-picture object))))))
            (make-object (object-picture object) (* (object-∆x object) -1)
              (* (object-∆y object) -1) (+ (object-x object) (* (object-∆x object) -1))
              (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) (object-wn object) (object-t object))]
           [(and (>= (object-x object) (- (image-width background) (* 1/2 (image-width (object-picture object)))))
                 (<= (object-y object) (* 1/2 (image-height (object-picture object)))))
            (make-object (object-picture object) (* (object-∆x object) -1)
              (* (object-∆y object) -1) (+ (object-x object) (* (object-∆x object) -1))
              (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) (object-wn object) (object-t object))]
           [(and (>= (object-x object) (- (image-width background) (* 1/2 (image-width (object-picture object)))))
                 (>= (object-y object) (- (image-height background) (* 1/2 (image-height (object-picture object))))))
            (make-object (object-picture object) (* (object-∆x object) -1)
              (* (object-∆y object) -1) (+ (object-x object) (* (object-∆x object) -1))
              (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) (object-wn object) (object-t object))]
           ; single conditions
           [(<= (object-x object) (* 1/2 (image-width (object-picture object))))
            (make-object (object-picture object) (* (object-∆x object) -1)
              (object-∆y object) (+ (object-x object) (* (object-∆x object) -1))
              (+ (object-y object) (object-∆y object)) (object-mn1 object) (object-wn object) (object-t object))]
           [(<= (object-y object) (* 1/2 (image-height (object-picture object))))
            (make-object (object-picture object) (object-∆x object)
              (* (object-∆y object) -1) (+ (object-x object) (object-∆x object))
              (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) (object-wn object) (object-t object))]
           [(>= (object-x object) (- (image-width background) (* 1/2 (image-width (object-picture object)))))
            (make-object (object-picture object) (* (object-∆x object) -1)
              (object-∆y object) (+ (object-x object) (* (object-∆x object) -1))
              (+ (object-y object) (object-∆y object)) (object-mn1 object) (object-wn object) (object-t object))]
           [(>= (object-y object) (- (image-height background) (* 1/2 (image-height (object-picture object)))))
            (make-object (object-picture object) (object-∆x object)
              (* (object-∆y object) -1) (+ (object-x object) (object-∆x object))
              (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) (object-wn object) (object-t object))]
           [else (make-object (object-picture object) (object-∆x object)
                   (object-∆y object) (+ (object-x object) (object-∆x object))
                   (+ (object-y object) (object-∆y object)) (object-mn1 object) (object-wn object) (object-t object))]))

(define (draw-handler object)
  (place-image (object-picture object) (object-x object) (object-y object) background))

(big-bang ob1
          (on-draw draw-handler)
          (on-tick tick-handler 0.01))