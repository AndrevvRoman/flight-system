:- dynamic 
printRoutesInfo/1, 
removeIfMore/3,
route/7, 
flightRouteCompare/3.

start:-
  findAllFlights(
    london,moscow, % Откуда и куда летим
    mon, % День отправления
    7,30, % Время отправления
    -1,999,% Интервал допустимого кол-ва часов между пересадками
    2, % Ограничение по кол-ву пересадок
    X), 
  writeln(X),
  predsort(flightRouteCompare, X, Sorted),
  consult(frontend),
  printRoutesInfo(Sorted), !.


findAllFlights(From,To,
               Day,
               DepartTimeH,DepartTimeM,
               TransferTimeLimitL,TransferTimeLimitR,
               TransferCountLimit,
               X):-
  consult(core),
  consult(flights),
  consult(util),
  findall(Answer, route(From,To,Day,h_m(DepartTimeH,DepartTimeM),TransferTimeLimitL,TransferTimeLimitR,Answer),AllPaths),
  removeIfMore(TransferCountLimit,AllPaths,X), !.
