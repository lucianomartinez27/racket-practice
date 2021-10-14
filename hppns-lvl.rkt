;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname hppns-lvl) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (level-bar happiness-lvl)
  (rectangle 10 happiness-lvl "solid" "red")
  )
 
(define (gaug-prog happiness-lvl)
  (place-image (level-bar happiness-lvl) 250 250 (empty-scene 500 500)))

(define (decrease-by-time happiness-lvl)
  (- happiness-lvl 0.1))

(define (help-with-key happiness-lvl key)
  (cond
    [(string=? "w" key) (+ 1/3 happiness-lvl)]
    [(string=? "s" key) (- happiness-lvl 1/5)]
    [else happiness-lvl]))
(define (stop ws)
  (= ws 0))

(define (main ws)
  (big-bang ws
    [to-draw gaug-prog]
    [on-tick decrease-by-time]
    [on-key help-with-key]
    [stop-when stop]))

