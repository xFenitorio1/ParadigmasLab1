#lang racket
(require "piece_21343296_GerardoPerezEncina.rkt")
(provide board)
(provide board-can-play?)
(provide board-set-play-piece)
;(provide board-check-vertical-win)
;(provide board-check-horizontal-win)
;(provide board-check-diagonal-win)
;(provide board-who-is-winner)



; ------------------------------------------------
; Nombre: board
; Descripcion: Permite la creacion del tablero, en este caso uno de 6x7
; Dominio: filas y columnas (ambos int)
; Recorrido: board (lista de listas)

(define (board)
  (list (lista-vacia) (lista-vacia) (lista-vacia)
        (lista-vacia) (lista-vacia) (lista-vacia)))

(define (lista-vacia)
  (list 0 0 0 0 0 0 0))

; ------------------------------------------------
; Nombre: board-can-play?
; Descripcion: Verifica si es que se puede jugar en el tablero, si hay al menos un espacio vacio, devuelve #t y en caso contrario #f
; Dominio: board (lista de listas)
; Recorrido: booleano (#t o #f)

(define (board-can-play? board)
  (define (fila-tiene-espacio? fila)
    (member 0 fila))  ; Busca si hay un 0 en la fila
  (define (revisar-tablero filas)
    (if (null? filas)
        #f  ; Si no hay más filas, no se puede jugar
        (if (fila-tiene-espacio? (car filas))
            #t  ; Si hay espacio en la fila actual, se puede jugar
            (revisar-tablero (cdr filas)))))  ; Continua verificando las siguientes filas
  (revisar-tablero board))


; ------------------------------------------------
; Nombre: board-set-play-piece 
; Descripción: Coloca una ficha en la posición más baja disponible de la columna seleccionada en el tablero.
; Dominio: board (lista de listas), column (int), piece (símbolo)
; Recorrido: board (lista de listas actualizada con la ficha colocada)

(define (board-set-play-piece board column piece)
  (define (colocar-en-fila fila columna)
    (cond
      [(= columna 0) (cons piece (cdr fila))]  ; Coloca la ficha en la posición especificada
      [else (cons (car fila) (colocar-en-fila (cdr fila) (- columna 1)))]))

  ; Buscar la fila más baja disponible en la columna
  (define (buscar-fila filas)
    (cond
      [(null? filas) '()]  ; Caso base: no hay más filas
      [(= (list-ref (car filas) column) 0)  ; Si la posición está vacía (0)
       (cons (colocar-en-fila (car filas) column) (cdr filas))]  ; Coloca la ficha
      [else (cons (car filas) (buscar-fila (cdr filas)))]))  ; Recurre a la siguiente fila

  (reverse (buscar-fila (reverse board))))

