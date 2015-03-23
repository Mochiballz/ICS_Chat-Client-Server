;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 21e_21f) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

; 21E - 21F

; 21.7.2

(define-struct placed-circ (posn radius))

; 21.7.4

(define circ1 (make-placed-circ (make-posn 20 40) 10))
(define circ2 (make-placed-circ (make-posn 30 10) 20))
(define circ3 (make-placed-circ (make-posn 5 5) 30))
(define circ4 (make-placed-circ (make-posn 6 6) 40))

(define (circ-overlap? circ1 circ2)
  (< (sqrt (+ (expt (- (posn-x (placed-circ-posn circ2)) (posn-x (placed-circ-posn circ1))) 2) 
              (expt (- (posn-y (placed-circ-posn circ2)) (posn-y (placed-circ-posn circ1))) 2)))
     (+ (placed-circ-radius circ1)
        (placed-circ-radius circ2))))

(check-expect (circ-overlap? circ1 circ2) #f)
(check-expect (circ-overlap? circ3 circ4) #t)

; 21.7.6, 21.7.7, 21.7.8

; object: image(picture) number(∆x) number(∆y) number(x) number(y) boolean(mn1) boolean(wn) number(t) -> struct
; determines the location, appearance, and pattern of a traveling ball on a plane

(define-struct object (picture ∆x ∆y x y mn1 wn t))
(define ball (circle 40 "solid" "blue"))
(define background (rectangle 1200 700 "solid" "white"))
(define ob1 (make-object ball 3 4 (* 1/2 (image-width background))
              (* 1/2 (image-height background)) #t #f 0))

(define (key-handler object key)
  (cond [(string=? key "up")
         (make-object (object-picture object) (object-∆x object) (+ (object-∆y object) -1)
           (object-x object) (object-y object) (object-mn1 object) (object-wn object) (object-t object))]
        [(string=? key "down")
         (make-object (object-picture object) (object-∆x object) (+ (object-∆y object) 1)
           (object-x object) (object-y object) (object-mn1 object) (object-wn object) (object-t object))]
        [(string=? key "right")
         (make-object (object-picture object) (+ (object-∆x object) 1) (object-∆y object)
           (object-x object) (object-y object) (object-mn1 object) (object-wn object) (object-t object))]
        [(string=? key "left")
         (make-object (object-picture object) (+ (object-∆x object) -1) (object-∆y object)
           (object-x object) (object-y object) (object-mn1 object) (object-wn object) (object-t object))]
        [else object]))

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
          (on-key key-handler)
          (on-tick tick-handler 0.01))
