vocaloid(megurineLuka, nightFever).
vocaloid(megurineLuka, foreverYoung).

vocaloid(hatsuneMiku, tellYourWorld).

vocaloid(gumi, foreverYoung).
vocaloid(gumi, tellYourWorld).

vocaloid(seeU, novemberRain).
vocaloid(seeU, nightFever).

vocaloid(kaito,_).

cancion(nightFever, 4).
cancion(foreverYoung, 5).
cancion(tellYourWorld, 4).
cancion(foreverYoung, 4).
cancion(tellYourWorld, 5).
cancion(novemberRain, 6).
cancion(nightFever, 5).

% Punto 1

esNovedoso(Vocaloid):-
    findall(Minutos, minutosDeCancion(Vocaloid, Minutos), Lista),
    Lista >= 2,
    sumlist(Lista, Suma),
    Suma < 15.
    

minutosDeCancion(Vocaloid, Minutos):-
    vocaloid(Vocaloid, Cancion),
    cancion(Cancion, Minutos).    

% ---------------------------------------------------------------------

% Punto 2

esAcelerado(Vocaloid):-
    not((minutosDeCancion(Vocaloid, Minutos), Minutos > 4)).

% ---------------------------------------------------------------------

% PARTE 2

% Punto 1

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(1, 4)).

% Punto 2

puedeParticipar(Concierto, hatsuneMiku):-
    concierto(Concierto, _, _, _).

puedeParticipar(Concierto, Vocaloid):-
    vocaloid(Vocaloid,_),
    Vocaloid \= hatsuneMiku,
    concierto(Concierto, _, _, Tipo),
    cumpleTipo(Vocaloid, Tipo).

cumpleTipo(Vocaloid, gigante(CantMinDeCanciones, DuracionTotal)):-
    listaMinutos(Vocaloid, Lista),
    cancionesYTiempoTotal(Lista, CantCanciones, Tiempo),
    CantCanciones >= CantMinDeCanciones,
    Tiempo > DuracionTotal. 


cumpleTipo(Vocaloid, mediano(DuracionTotal)):-
    listaMinutos(Vocaloid, Lista),
    cancionesYTiempoTotal(Lista, _, Tiempo),
    Tiempo < DuracionTotal.


cumpleTipo(Vocaloid, pequenio(DuracionTotal)):-
    listaMinutos(Vocaloid, Lista),
    member(Cancion, Lista),
    Cancion > DuracionTotal.
    

listaMinutos(Vocaloid, Lista):-
    findall(Minutos, minutosDeCancion(Vocaloid, Minutos), Lista).

cancionesYTiempoTotal(Lista, CantCanciones, Tiempo):-
    length(Lista, CantCanciones),
    sumlist(Lista, Tiempo).


% ---------------------------------------------------------------------

% Punto 3

vocaloidMasFamoso(Vocaloid):-
    vocaloid(Vocaloid, _),
    forall(esOtro(OtroVocaloid, Vocaloid), esMasFamoso(Vocaloid, OtroVocaloid)).

esOtro(OtroVocaloid, Vocaloid):-
    vocaloid(OtroVocaloid, _),
    OtroVocaloid \= Vocaloid.

esMasFamoso(Vocaloid, OtroVocaloid):-
    listaFama(Vocaloid, ListaFama1),
    listaFama(OtroVocaloid, ListaFama2),
    listaCanciones(Vocaloid, Canciones1),
    listaCanciones(OtroVocaloid, Canciones2),

    sumlist(ListaFama1, SumaFama1),
    sumlist(ListaFama2, SumaFama2),

    length(Canciones1, CantCanciones1),
    length(Canciones2, CantCanciones2),

    FamaTotal1 is SumaFama1 * CantCanciones1,
    FamaTotal2 is SumaFama2 * CantCanciones2,

    FamaTotal1 > FamaTotal2.    


listaFama(Vocaloid, ListaFama):-
    findall(Fama, famaDeConcierto(Vocaloid, Fama), ListaFama).


listaCanciones(Vocaloid, Canciones):-
    findall(Cancion, vocaloid(Vocaloid, Cancion), Canciones).

famaDeConcierto(Vocaloid, Fama):-
    puedeParticipar(Concierto, Vocaloid),
    concierto(Concierto, _, Fama, _).