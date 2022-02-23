:- dynamic 
readSortType/1, 
readQueryInfo/5, 
printProgrammInfo/0, 
printRoutesInfo/1, 
removeIfMore/3,
route/7, 
flightRouteCompare/3.

start:-
  consult(frontend),
  printProgrammInfo(),
  readSortType(SortType),
  setSortType(SortType).

setSortType(1):-
  readQueryInfo(Origin,Dest,WeekDayDepart,DepartTimeH,DepartTimeM),
  findAllFlights(
    Origin,Dest, % Откуда и куда летим
    WeekDayDepart, % День отправления
    DepartTimeH,DepartTimeM, % Время отправления
    -1,999,% Интервал допустимого кол-ва часов между пересадками
    2, % Ограничение по кол-ву пересадок
    X),
    predsort(flightRouteCompare, X, Sorted),
    consult(frontend),
    printRoutesInfo(Sorted), !.

setSortType(_):-
  writeln("Inputed type is not supported yet.").

findAllFlights(
               From,To,
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
