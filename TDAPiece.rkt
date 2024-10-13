#lang racket
(provide piece-color)
; ------------------------------------------------
; Nombre: piece-color
; Descripcion: Obtiene el color (string) de una piece
; Dominio: piece
; Recorrido: color(string)
(define (piece-color piece) (car piece))