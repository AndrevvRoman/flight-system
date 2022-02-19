:- dynamic weekDay/2, nextDay/2, flightTime/3, flightDay/2, flight/3.
:- use_module(library(date)).

isLeftMoreThanRight(Left,Right):- Left @> Right, true, ! ; false, !.

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

timediff(DateTime1, DateTime2, Sec) :-
  date_time_stamp(DateTime1, TimeStamp1),
  date_time_stamp(DateTime2, TimeStamp2),
  Sec is TimeStamp2 - TimeStamp1.

timeDif(RightD,h_m(RightH,RightM),LeftD,h_m(LeftH,LeftM),Result):-
  weekDay(RightD,RightDInt),
  weekDay(LeftD,LeftDInt),
  date_time_stamp(date(1970,01,LeftDInt,LeftH,LeftM,0,0,-,-), Stamp1),
  date_time_stamp(date(1970,01,RightDInt,RightH,RightM,0,0,-,-), Stamp2),
  Result is (Stamp1 - Stamp2)/3600,!.

start:-
  % findAllFlights(london,dublin,mon,7,30,X),
  % writeln(X),
  timeDif(mon,h_m(23,30),tue,h_m(05,45),X),
  X < 7,
  writeln("Just in time"), !; write("Too late"),!.
  


findAllFlights(From,To,Day,DepartTimeH,DepartTimeM,X):-
  consult(flights),
  findall(Answer, route(From,To,Day,h_m(DepartTimeH,DepartTimeM),Answer),X).

route(From,To,Day,DepartTime,Answer):-
  route(From,To,Answer,[From],[],Day,DepartTime).
  
route(From,To,Answer,_Path,FlightNumbers,CurrentDay,CurrentTime):-
  flight(FlightNumber,From,To), % Существует прямой рейс
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays), % Летает в текущий день
  flightTime(FlightNumber,ScheduleDepartTime,_),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime), % Успеваем сесть на прямой рейс
  reverse([FlightNumber|FlightNumbers],Answer).
  
route(From,To,Answer,Path,FlightNumbers,CurrentDay,CurrentTime):-
  flight(FlightNumber, From, Transfer),
  not(member(Transfer,Path)),% Если мы еще не были в этом городе
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays), % Летает в текущий день
  flightTime(FlightNumber,ScheduleDepartTime,ScheduleArriveTime),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime),% проверка успеваем ли мы на начало рейса
  changeDayIfNeed(ScheduleDepartTime,ScheduleArriveTime,CurrentDay,NewDay),% меняем день недели, если рейс ночной
  route(Transfer,To,Answer,[Transfer|Path],[FlightNumber|FlightNumbers],NewDay,ScheduleArriveTime).%Ищем путь с пересадкой от этого города
