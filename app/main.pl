:- dynamic 
flightRouteCompareByCost/3, 
readSortType/1, 
readQueryInfo/8, 
printProgrammInfo/0, 
printRoutesInfo/1, 
removeIfMore/3,
route/7, 
flightRouteCompareByCount/3.

start:-
  consult(frontend),
  printProgrammInfo(),
  readSortType(SortType),
  setSortType(SortType).

setSortType(1):-
  readQueryInfo(Origin,Dest,WeekDayDepart,DepartTimeH,DepartTimeM,LTimeLimit,RTimeLimit,TransferCountLimit),
  findAllFlights(
    Origin,Dest, % Откуда и куда летим
    WeekDayDepart, % День отправления
    DepartTimeH,DepartTimeM, % Время отправления
    LTimeLimit,RTimeLimit,% Интервал допустимого кол-ва часов между пересадками
    TransferCountLimit, % Ограничение по кол-ву пересадок
    X),
    predsort(flightRouteCompareByCount, X, Sorted),
    consult(frontend),
    printRoutesInfo(Sorted), !.

setSortType(2):-
  readQueryInfo(Origin,Dest,WeekDayDepart,DepartTimeH,DepartTimeM,LTimeLimit,RTimeLimit,TransferCountLimit),
  findAllFlights(
    Origin,Dest, % Откуда и куда летим
    WeekDayDepart, % День отправления
    DepartTimeH,DepartTimeM, % Время отправления
    LTimeLimit,RTimeLimit,% Интервал допустимого кол-ва часов между пересадками
    TransferCountLimit, % Ограничение по кол-ву пересадок
    X),
    predsort(flightRouteCompareByCost, X, Sorted),
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
