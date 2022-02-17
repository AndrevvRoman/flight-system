:- dynamic flightTime/3, flightDay/2, flight/3.
% flightCost(Number,Cost).
% flightTime(Number,h_mDepart,h_mArrival).
% flightDay(Number,[DaysFly]).
% flight(Number,Origin,Dest).


isLeftMoreThanRight(Left,Right):- Left @> Right, true, ! ; false, !.

findAllFlights(From,To,Day,DepartTimeH,DepartTimeM,X):-
  consult(flights),
  findall(Answer, route(From,To,Day,h_m(DepartTimeH,DepartTimeM),Answer),X).

route(From,To,Day,DepartTime,Answer):-
  route(From,To,Answer,[From],[],Day,DepartTime).
  
route(From,To,Answer,_Path,FlightNumbers,CurrentDay,CurrentTime):-
  flight(FlightNumber,From,To), %Существует прямой рейс
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays),
  flightTime(FlightNumber,ScheduleDepartTime,_),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime),
  reverse([FlightNumber|FlightNumbers],Answer).
  
route(From,To,Answer,Path,FlightNumbers,CurrentDay,CurrentTime):-
  flight(FlightNumber, From, Transfer),
  not(member(Transfer,Path)),%Если мы еще не были в этом городе
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays),
  flightTime(FlightNumber,ScheduleDepartTime,ScheduleArriveTime),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime),
  route(Transfer,To,Answer,[Transfer|Path],[FlightNumber|FlightNumbers],CurrentDay,ScheduleArriveTime).%Ищем путь с пересадкой от этого города
