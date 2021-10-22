;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs)
  (cond
  [(string=? cs "red") "green"]
  [(string=? cs "yellow") "red"]
  [else "yellow"])
 )

(define (semaphore-lights color)
  (list (tl-bulb "green" color) (tl-bulb "yellow" color) (tl-bulb "red" color) ))



; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (place-images/align
   (semaphore-lights current-state)
    (list (make-posn 25 20)
         (make-posn 25 60)
         (make-posn 25 100))
   "center" "top" (empty-scene 50 150)))

(define (tl-bulb current-color color-on )
  (circle 10 (if (string=? color-on current-color) "solid" "outline") current-color))

(define (three-traffic-lights color-on)
  (place-image/align (tl-bulb color-on "red")  ))
; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))