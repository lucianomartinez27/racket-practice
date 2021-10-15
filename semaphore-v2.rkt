;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname semaphore-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define bg
  (empty-scene 50 150))

(define turned-off-light
  (circle 15 "solid" "gray"))

(define (semaphore-lights color)
  (cond
    [(string=? "red" color) (list (semaphore-light color) turned-off-light turned-off-light)]
    [(string=? "yellow" color) (list  turned-off-light (semaphore-light color) turned-off-light)]
    [else (list  turned-off-light turned-off-light (semaphore-light color))]))


(define (semaphore color)
  (place-images/align
   (semaphore-lights color)
    (list (make-posn 25 20)
         (make-posn 25 60)
         (make-posn 25 100))
   "center" "top" bg))



; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

(check-expect (semaphore-light "red") (circle 15 "solid" "red"))
(check-expect (semaphore-light "yellow") (circle 15 "solid" "yellow"))
(check-expect (semaphore-light "green") (circle 15 "solid" "green"))
              
(define (semaphore-light color)
  (circle 15 "solid" color))


(define (main ws)
  (big-bang ws
    [to-draw semaphore]
    [on-tick traffic-light-next 2]
    ))
