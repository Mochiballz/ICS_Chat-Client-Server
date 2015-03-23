;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname bouncy_ball) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
(require picturing-programs)

; REVISIONS 2-13-15
; made the tick handler smaller by breaking it down functions
; edited the draw handler by putting in constants

; object: image(picture) number(∆x) number(∆y) number(x) number(y) boolean(mn1) boolean(wn) number(t) -> struct
; determines the location, appearance, and pattern of a traveling ball on a plane

(define-struct object (picture ∆x ∆y x y mn1 wn t))
(define ball (circle 100 "solid" "blue"))
(define background (rectangle 1000 700 "solid" "lightcyan"))
(define tick 1)
(define button-color "yellow")
(define button-background "orange")
(define ob1 (make-object ball 2 2 (* 1/2 (image-width background))
              (* 1/2 (image-height background)) #t #f 0))
(define ob2 (make-object ball (+ -4 (random 6)) (+ -2 (random 6)) (* 1/2 (image-width background))
              (* 1/2 (image-height background)) #t #f 0))

; key-handler: struct(object) string(key) -> struct
; checks if key is pressed and changes boolean to change menus

; key-handler-inventory:
; object -> a struct
; key -> string

(define (key-handler object key)
  (cond [(and (equal? (object-mn1 object) #t) 
              (string=? key "s"))
         (make-object (object-picture object) (object-∆x object) (object-∆y object)
           (object-x object) (object-y object) #f #f (object-t object))]
        [(and (equal? (object-wn object) #t) 
              (string=? key "r"))
         (make-object (object-picture object) (+ 1 (random 5)) (+ 1 (random 5))
           (* 1/2 (image-width background)) (* 1/2 (image-height background)) #t #f 0)]
        [else object]))

(check-expect (key-handler ob1 "s") (make-object (object-picture ob1) (object-∆x ob1) (object-∆y ob1)
                                      (object-x ob1) (object-y ob1) #f #f (object-t ob1)))
(check-expect (key-handler ob1 "e") ob1)

; mouse-handler: struct(object) number(x) number(y) string(event) -> struct
; checks if mouse coordinates follows the inequality (outside circle boundaries)
; changes boolean to change menu

(define (mouse-handler object x y event)
  (cond [(and (and (equal? (object-mn1 object) #f) (equal? (object-wn object) #f)) 
              (> (+ (expt (- x (object-x object)) 2)
                    (expt (- y (object-y object)) 2))
                 (expt (* 1/2 (image-width (object-picture object))) 2)))
         (make-object (object-picture object) (object-∆x object) (object-∆y object)
           (object-x object) (object-y object) #f #t (object-t object))]
        [else object]))

(check-expect (mouse-handler ob1 (image-width background) (image-height background) "move") ob1)

; tick-handler-components

; tests

; double-less-than: struct(object) -> struct
; checks if ball is in one corner

(define (double-less-than object)
  (and (<= (object-x object) (* 1/2 (image-width (object-picture object))))
                 (<= (object-y object) (* 1/2 (image-height (object-picture object))))))

; x-less-y-greater: struct(object) -> struct
; checks if ball is in one corner

(define (x-less-y-greater object)
  (and (<= (object-x object) (* 1/2 (image-width (object-picture object))))
                 (>= (object-y object) (- (image-height background) (* 1/2 (image-height (object-picture object)))))))

; x-greater-y-less: struct(object) -> struct
; checks if ball is in one corner

(define (x-greater-y-less object)
  (and (>= (object-x object) (- (image-width background) (* 1/2 (image-width (object-picture object)))))
                 (<= (object-y object) (* 1/2 (image-height (object-picture object))))))

; double-greater-than: struct(object) -> struct
; checks if ball is in one corner
  
(define (double-greater-than object)
  (and (>= (object-x object) (- (image-width background) (* 1/2 (image-width (object-picture object)))))
                 (>= (object-y object) (- (image-height background) (* 1/2 (image-height (object-picture object)))))))

; x-less-than: struct(object) -> struct
; checks if ball is touching side

(define (x-less-than object)
  (<= (object-x object) (* 1/2 (image-width (object-picture object)))))

; y-less-than: struct(object) -> struct
; checks if ball is touching side
  
(define (y-less-than object)
  (<= (object-y object) (* 1/2 (image-height (object-picture object)))))

; x-greater-than: struct(object) -> struct
; checks if ball is touching side
  
(define (x-greater-than object)
  (>= (object-x object) (- (image-width background) (* 1/2 (image-width (object-picture object))))))

; y-greater-than: struct(object) -> struct
; checks if ball is touching side
  
(define (y-greater-than object)
  (>= (object-y object) (- (image-height background) (* 1/2 (image-height (object-picture object))))))

; actions

; reverse-∆x-∆y: struct(object) -> struct
; changes both ∆x and ∆y for object

(define (reverse-∆x-∆y object)
  (make-object (object-picture object) (* (object-∆x object) -1)
    (* (object-∆y object) -1) (+ (object-x object) (* (object-∆x object) -1))
    (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) 
    (object-wn object) (+ tick (object-t object))))

(check-expect (reverse-∆x-∆y ob1) (make-object (object-picture ob1) -2
                                    -2 (+ (object-x ob1) -2)
                                    (+ (object-y ob1) -2) (object-mn1 ob1) 
                                    (object-wn ob1) (+ tick (object-t ob1))))

; reverse-∆x: struct(object) -> struct
; changes ∆x for object

(define (reverse-∆x object)
  (make-object (object-picture object) (* (object-∆x object) -1)
    (object-∆y object) (+ (object-x object) (* (object-∆x object) -1))
    (+ (object-y object) (object-∆y object)) (object-mn1 object) 
    (object-wn object) (+ tick (object-t object))))

(check-expect (reverse-∆x ob1) (make-object (object-picture ob1) -2
                                 (object-∆y ob1) (+ (object-x ob1) -2)
                                 (+ (object-y ob1) (object-∆y ob1)) (object-mn1 ob1) 
                                 (object-wn ob1) (+ tick (object-t ob1))))

; reverse-∆y: struct(object) -> struct
; changes ∆y for object

(define (reverse-∆y object)
  (make-object (object-picture object) (object-∆x object)
    (* (object-∆y object) -1) (+ (object-x object) (object-∆x object))
    (+ (object-y object) (* (object-∆y object) -1)) (object-mn1 object) 
    (object-wn object) (+ tick (object-t object))))

(check-expect (reverse-∆y ob1) (make-object (object-picture ob1) (object-∆x ob1)
                                 -2 (+ (object-x ob1) (object-∆x ob1))
                                 (+ (object-y ob1) -2) (object-mn1 ob1) 
                                 (object-wn ob1) (+ tick (object-t ob1))))

; add-time: struct(object) -> struct
; adds time and increase in position

(define (add-time object)
  (make-object (object-picture object) (object-∆x object)
    (object-∆y object) (+ (object-x object) (object-∆x object))
    (+ (object-y object) (object-∆y object)) (object-mn1 object) 
    (object-wn object) (+ tick (object-t object))))

; main-tick-function: struct(object) -> struct
; takes necessary checks and actions to animate ball

(define (main-tick-function object)
  (cond ; double conditions
           [(double-less-than object)
            (reverse-∆x-∆y object)]
           [(x-less-y-greater object)
            (reverse-∆x-∆y object)]
           [(x-greater-y-less object)
            (reverse-∆x-∆y object)]
           [(double-greater-than object)
            (reverse-∆x-∆y object)]
           ; single conditions
           [(x-less-than object)
            (reverse-∆x object)]
           [(y-less-than object)
            (reverse-∆y object)]
           [(x-greater-than object)
            (reverse-∆x object)]
           [(y-greater-than object)
            (reverse-∆y object)]
           [else (add-time object)]))

; game-playing?: struct(object) -> boolean
; checks if game is currently being played

(define (game-playing? object)
  (and (equal? (object-mn1 object) #f) (equal? (object-wn object) #f)))

; tick-handler: struct(object) -> struct
; depending on where the ball hits the screen, 
; changes the ∆x and/or ∆y

(define (tick-handler object)
  (cond [(game-playing? object)
         (main-tick-function object)]
        [else object]))

(define (draw-handler object)
  (cond [(equal? (object-mn1 object) #t)
         (overlay/align "middle" "middle" (above/align "middle" (text "ON POINT" 160 "white")
                                                       (overlay/align "middle" "middle"
                                                                      (text "Press \"S\" to Start!" 30 "orange")
                                                                      (rectangle 300 50 "solid" button-color)))
                        (rectangle (image-width background) (image-height background) "solid" button-background))]
        [(equal? (object-wn object) #t)
         (overlay/align "middle" "middle" (above/align "middle" (text "GAME OVER" 160 "white")
                                                       (text (string-append "High Score: " (number->string (real->int (object-t object)))) 40 "white") 
                                                       (text "(Press \"R\" to try again)" 40 "white"))
                        (rectangle (image-width background) (image-height background) "solid" "red"))]
        [else (place-image (object-picture object) (object-x object) (object-y object) 
                           (overlay/align "middle" "middle" 
                                          (text (number->string (real->int (object-t object))) 160 (make-color 0 0 255 100)) background))]))

(big-bang ob1
          (on-draw draw-handler)
          (on-tick tick-handler 0.01)
          (on-mouse mouse-handler)
          (on-key key-handler))
