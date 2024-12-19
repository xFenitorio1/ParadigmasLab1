#lang racket
(provide piece)



(define (piece x)
  (cond
    [(string=? x "red") "r"]
    [(string=? x "yellow") "y"]
    )
  )