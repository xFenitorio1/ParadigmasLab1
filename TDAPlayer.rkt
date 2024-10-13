#lang racket

(provide player-id player-name player-color player-wins player-loses player-draws player-remaining-pieces)

; ------------------------------------------------
; Nombre: player-id
; Descripcion: Obtiene el id (int) de un player
; Dominio: player
; Recorrido: id(int)
(define (player-id player) (car player))

; ------------------------------------------------
; Nombre: player-name
; Descripcion: Obtiene el name (string) de un player
; Dominio: player
; Recorrido: name(string)
(define (player-name player) (cadr player))

; ------------------------------------------------
; Nombre: player-color
; Descripcion: Obtiene el color (string) de un player
; Dominio: player
; Recorrido: color(string)
(define (player-color player) (caddr player))

; ------------------------------------------------
; Nombre: player-wins
; Descripcion: Obtiene el numero de ganadas (int) de un player
; Dominio: player
; Recorrido: wins(int)
(define (player-wins player) (cadddr player))

; ------------------------------------------------
; Nombre: player-loses
; Descripcion: Obtiene el numero de perdidas (int) de un player
; Dominio: player
; Recorrido: loses(int)
(define (player-loses player) (car (cddddr player)))

; ------------------------------------------------
; Nombre: player-draws
; Descripcion: Obtiene el numero de empatadas (int) de un player
; Dominio: player
; Recorrido: draws(int)
(define (player-draws player) (cadr (cddddr player)))

; ------------------------------------------------
; Nombre: player-remaining-pieces
; Descripcion: Obtiene el numero de piezas restantes (int) de un player
; Dominio: player
; Recorrido: remaining-pieces(int)
(define (player-remaining-pieces player)  (caddr (cddddr player)))
