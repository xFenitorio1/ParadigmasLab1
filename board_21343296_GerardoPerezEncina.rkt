#lang racket
(require "piece_21343296_GerardoPerezEncina.rkt")
(provide board)
(provide board-can-play?)
(provide board-set-play-piece)
(provide board-check-vertical-win)
(provide board-check-horizontal-win)
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
      (cons 0 (crear-fila (- n 1)))))

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
    (member 0 fila)) 
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
      [(equal? (list-ref (car filas) column) 0) 
       (cons (colocar-en-fila (car filas) column) (cdr filas))]
      [else (cons (car filas) (buscar-fila (cdr filas)))])) 

  (reverse (buscar-fila (reverse board))))

; ------------------------------------------------

; Nombre: board-check-vertical-win
; Descripción: Verifica si hay 4 fichas consecutivas del mismo color en cualquier columna.
; Dominio: board (lista de listas que representa el tablero)
; Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical)

(define (board-check-vertical-win board)


  (define (verificar-columna columna color consecutivas)
    (cond
      [(null? columna) 0]  
      [(equal? (car columna) color) 
       (if (= (+ consecutivas 1) 4) 
           (if (equal? color "r") 1 2)  
           (verificar-columna (cdr columna) color (+ consecutivas 1)))] 
      [else (verificar-columna (cdr columna) color 0)]))  

  ; Función para verificar todas las columnas
  (define (verificar-todas-las-columnas columna)
    (if (= columna 7)  
        0
        (cond
          [(= (verificar-columna (map (lambda (fila) (list-ref fila columna)) board) "r" 0) 1) 1]  ; Si el jugador 1 gana
          [(= (verificar-columna (map (lambda (fila) (list-ref fila columna)) board) "y" 0) 2) 2]  ; Si el jugador 2 gana
          [else (verificar-todas-las-columnas (+ columna 1))]))) 

  ; Iniciar la verificación desde la primera columna
  (verificar-todas-las-columnas 0))


; ------------------------------------------------

; Nombre: board-check-horizontal-win
; Descripción: Verifica si hay 4 fichas consecutivas del mismo color en cualquier fila.
; Dominio: board (lista de listas que representa el tablero)
; Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal)

(define (board-check-horizontal-win board)


  (define (verificar-fila fila color consecutivas)
    (cond
      [(null? fila) 0] 
      [(equal? (car fila) color)
       (if (= (+ consecutivas 1) 4)  
           (if (equal? color "r") 1 2)  
           (verificar-fila (cdr fila) color (+ consecutivas 1)))]  
      [else (verificar-fila (cdr fila) color 0)]))  

  ; Función para verificar todas las filas
  (define (verificar-todas-las-filas fila)
    (if (= fila (length board))  
        0
        (cond
          [(= (verificar-fila (list-ref board fila) "r" 0) 1) 1]  ; Si el jugador 1 gana
          [(= (verificar-fila (list-ref board fila) "y" 0) 2) 2]  ; Si el jugador 2 gana
          [else (verificar-todas-las-filas (+ fila 1))])))  

  (verificar-todas-las-filas 0))

; ------------------------------------------------

; Nombre: board-check-diagonal-win
; Descripción: Verifica si hay 4 fichas consecutivas del mismo color en cualquier diagonal del tablero.
; Dominio: board (lista de listas que representa el tablero)
; Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal)
