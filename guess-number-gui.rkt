#lang racket
(require 2htdp/universe 2htdp/image)
(define TEXT-SIZE 20)
(define TEXT-X 20)
(define TEXT-LOWER-Y 50)
(define TEXT-UPPER-Y 300)
(define WIDTH 500)
(define HEIGHT 500)
(define SIZE 40)
(struct interval (small big))

(define HELP-TEXT
  (text "↑ for larger numbers, ↓ for smaller ones"
        TEXT-SIZE
        "blue"))

(define HELP-TEXT2
  (text "Press = when your number is guessed; q to quit."
        TEXT-SIZE
        "blue"))

(define COLOR "red")

(define MT-SC
  (place-image/align
   HELP-TEXT TEXT-X TEXT-UPPER-Y "left" "top"
   (place-image/align
    HELP-TEXT2 TEXT-X TEXT-LOWER-Y "left" "bottom"
    (empty-scene WIDTH HEIGHT))))

(define (smaller w)
  (interval (interval-small w)
            (sub1 (guess w))))

(define (guess w)
  (quotient (+ (interval-small w) (interval-big w)) 2))

(define (bigger w)
  (interval  (add1 (guess w))
            (interval-big w)))

(define (render-last-scene w)
  (place-image (text (number->string (guess w)) SIZE COLOR) 250 350 (overlay (text "End, your number is" SIZE COLOR) MT-SC)))

(define (single? w)
  (= (interval-small w) (interval-big w)))

(define (render w)
  (place-image (text (number->string (interval-big w)) 30  COLOR) 100 100
               (place-image (text (number->string (interval-small w)) 30  COLOR) 100 200
                            (overlay (text (number->string (guess w)) SIZE COLOR) MT-SC))))

(define (deal-with-guess w key)
  (cond [(key=? key "up") (bigger w)]
        [(key=? key "down") (smaller w)]
        [(key=? key "q") (stop-with w)]
        [(key=? key "=") (stop-with w)]
        [else w]))

(define (start lower upper)
  (big-bang (interval lower upper)
    (on-key deal-with-guess)
    (to-draw render)
    (stop-when single? render-last-scene)))