#lang racket
(require "piece_21343296_GerardoPerezEncina.rkt")
(provide board)
;(provide board-can-play?)
;(provide board-set-play-piece)
;(provide board-check-vertical-win)
;(provide board-check-horizontal-win)
;(provide board-check-diagonal-win)
;(provide board-who-is-winner)



; ------------------------------------------------
; Nombre: crear-fila
; Descripcion: Crea una fila con 'n' posiciones vacías ('empty')
; Dominio: n (int)
; Recorrido: fila (lista)
(define (crear-fila n)
  (if (= n 0)
      '()
      (cons 'empty (crear-fila (- n 1)))))

; ------------------------------------------------
; Nombre: board
; Descripcion: Permite la creacion del tablero, en este caso uno de 6x7
; Dominio: filas y columnas (ambos int)
; Recorrido: board (lista de listas)

(define (board (filas 6) (columnas 7))
  (if (equal? filas 0)
      '()
      (cons (crear-fila columnas) (board (- filas 1) columnas)))
  )
