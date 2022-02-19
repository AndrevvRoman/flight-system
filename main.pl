:- dynamic weekDay/2, nextDay/2, flightTime/3, flightDay/2, flight/3.
:- use_module(library(date)).

isLeftMoreThanRight(Left,Right):- Left @> Right, true, ! ; false, !.

checkTransferTime(TransferTime,TransferTimeLimitL,TransferTimeLimitR):-
  TransferTime > TransferTimeLimitL, TransferTime < TransferTimeLimitR, 
  true;
  false.

removeIfMore(_,[],[]).
removeIfMore(RequiredSize,[Head|Tail],Result):-
    length(Head,Count),
    Count > RequiredSize,
    removeIfMore(RequiredSize,Tail,Result).
removeIfMore(RequiredSize,[Head|Tail],[Head|Result]):-
    length(Head,Count),
    Count =< RequiredSize,
    removeIfMore(RequiredSize,Tail,Result).

changeDayIfNeed(DepartTime,ArrivalTime,CurDay,Result):-
  isLeftMoreThanRight(DepartTime,ArrivalTime),
  nextDay(CurDay,NewDay),
  Result = NewDay, !; Result = CurDay, !.

timeDif(RightD,h_m(RightH,RightM),LeftD,h_m(LeftH,LeftM),Result):-
  weekDay(RightD,RightDInt),
  weekDay(LeftD,LeftDInt),
  date_time_stamp(date(1970,01,LeftDInt,LeftH,LeftM,0,0,-,-), Stamp1),
  date_time_stamp(date(1970,01,RightDInt,RightH,RightM,0,0,-,-), Stamp2),
  Result is (Stamp1 - Stamp2)/3600,!.

start:-
  findAllFlights(london,dublin,mon,7,30,-1,999,3,X),
  writeln(X).


findAllFlights(From,To,Day,DepartTimeH,DepartTimeM,TransferTimeLimitL,TransferTimeLimitR,TransferCountLimit,X):-
  consult(flights),
  findall(Answer, route(From,To,Day,h_m(DepartTimeH,DepartTimeM),TransferTimeLimitL,TransferTimeLimitR,Answer),AllPaths),
  removeIfMore(TransferCountLimit,AllPaths,X), !.

route(From,To,DepartDay,DepartTime,TransferTimeLimitL,TransferTimeLimitR,Answer):-
  route(From,To,DepartDay,DepartTime,TransferTimeLimitL,TransferTimeLimitR,Answer,[From],[]).
  
route(From,To,CurrentDay,CurrentTime,TransferTimeLimitL,TransferTimeLimitR,Answer,_Path,FlightNumbers):-
  flight(FlightNumber,From,To), % Существует прямой рейс
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays), % Летает в текущий день
  flightTime(FlightNumber,ScheduleDepartTime,_),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime), % Успеваем сесть на прямой рейс
  reverse([FlightNumber|FlightNumbers],Answer).
  
route(From,To,CurrentDay,CurrentTime,TransferTimeLimitL,TransferTimeLimitR,Answer,Path,FlightNumbers):-
  flight(FlightNumber, From, Transfer),
  not(member(Transfer,Path)),% Если мы еще не были в этом городе
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays), % Летает в текущий день
  flightTime(FlightNumber,ScheduleDepartTime,ScheduleArriveTime),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime),% проверка успеваем ли мы на начало рейса
  changeDayIfNeed(ScheduleDepartTime,ScheduleArriveTime,CurrentDay,NewDay),% меняем день недели, если рейс ночной
  timeDif(CurrentDay,CurrentTime,NewDay,ScheduleArriveTime,TransferTime),
  checkTransferTime(TransferTime,TransferTimeLimitL,TransferTimeLimitR),
  route(Transfer,To,NewDay,ScheduleArriveTime,TransferTimeLimitL,TransferTimeLimitR,Answer,[Transfer|Path],[FlightNumber|FlightNumbers]).%Ищем путь с пересадкой от этого города
