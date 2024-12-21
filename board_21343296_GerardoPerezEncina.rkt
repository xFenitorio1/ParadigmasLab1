#lang racket
(require "piece_21343296_GerardoPerezEncina.rkt")
(provide board)
(provide board-can-play?)
(provide board-set-play-piece)
(provide board-check-vertical-win)
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

; ------------------------------------------------
; Nombre: board-can-play?
; Descripcion: Verifica si es que se puede jugar en el tablero, si hay al menos un espacio vacio, devuelve #t y en caso contrario #f
; Dominio: board (lista de listas)
; Recorrido: booleano (#t o #f)

(define (board-can-play? board)
  (define (fila-tiene-espacio? fila)
    (member 'empty fila)) 
  (define (revisar-tablero filas)
    (if (null? filas)
        #f  
        (if (fila-tiene-espacio? (car filas))
            #t 
            (revisar-tablero (cdr filas)))))  
  (revisar-tablero board))


; ------------------------------------------------
; Nombre: board-set-play-piece 
; Descripción: Coloca una ficha en la posición más baja disponible de la columna seleccionada en el tablero.
; Dominio: board (lista de listas), column (int), piece (símbolo)
; Recorrido: board (lista de listas actualizada con la ficha colocada)

(define (board-set-play-piece board column piece)
  (define (colocar-en-fila fila columna)
    (cond
      [(= columna 0) (cons piece (cdr fila))]  
      [else (cons (car fila) (colocar-en-fila (cdr fila) (- columna 1)))]))

  ; Función recursiva para buscar la fila mas baja disponible
  (define (buscar-fila filas)
    (cond
      [(null? filas) '()]  
      [(equal? (list-ref (car filas) column) 'empty) 
       (cons (colocar-en-fila (car filas) column) (cdr filas))]
      [else (cons (car filas) (buscar-fila (cdr filas)))])) 

  (reverse (buscar-fila (reverse board))))

; ------------------------------------------------

; Nombre: board-check-vertical-win
; Descripción: Verifica si hay 4 fichas consecutivas del mismo color en cualquier columna.
; Dominio: board (lista de listas que representa el tablero)
; Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical)

(define (board-check-vertical-win board)

  (define (verificar-columna filas color consecutivas)
    (cond
      [(null? filas) 0] 
      [(equal? (car (car filas)) color) 
       (if (= (+ 1 consecutivas) 4) 
           (if (equal? color 'red) 1 2)  
           (verificar-columna (cdr filas) color (+ consecutivas 1)))]
      [else (verificar-columna (cdr filas) color 0)]))  

  (define (verificar-todas-las-columnas columna)
    (if (= columna 7) 
        0 
        (let ([resultado-red (verificar-columna (map (lambda (fila) (list-ref fila columna)) board) 'red 0)]
              [resultado-yellow (verificar-columna (map (lambda (fila) (list-ref fila columna)) board) 'yellow 0)])
          (cond
            [(= resultado-red 1) 1] 
            [(= resultado-yellow 2) 2] 
            [else (verificar-todas-las-columnas (+ columna 1))])))) 

  (verificar-todas-las-columnas 0))