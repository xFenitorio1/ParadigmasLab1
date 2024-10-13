#lang racket

(provide board)

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

; ------------------------------------------------
; Nombre: board-can-play?
; Descripcion: 
; Dominio: 
; Recorrido: 