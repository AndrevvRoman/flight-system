:- dynamic 
printRoutesInfo/1,
checkTransferTime/3, 
changeDayIfNeed/4, 
timeDif/5, 
isLeftMoreThanRight/2, 
removeIfMore/3, 
flightRouteCompareByCount/3,
weekDay/2, 
nextDay/2, 
flightTime/3, 
flightDay/2, 
flight/3.

% Перегрузка для добавления переменных
route(From,To,
      DepartDay,
      DepartTime,
      TransferTimeLimitL,
      TransferTimeLimitR,
      Answer):-
  route(From,To,DepartDay,DepartTime,TransferTimeLimitL,TransferTimeLimitR,Answer,[From],[]).
  
% Перегрузка для трансфера
route(From,To,
      CurrentDay,
      CurrentTime,
      TransferTimeLimitL,TransferTimeLimitR,
      Answer,
      Path,
      FlightNumbers):-
  flight(FlightNumber, From, Transfer),
  Transfer \= To, % Для прямых есть другой предикат 
  not(member(Transfer,Path)),% Если мы еще не были в этом городе
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays), % Летает в текущий день
  flightTime(FlightNumber,ScheduleDepartTime,ScheduleArriveTime),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime),% проверка успеваем ли мы на начало рейса
  changeDayIfNeed(ScheduleDepartTime,ScheduleArriveTime,CurrentDay,NewDay),% меняем день недели, если рейс ночной
  timeDif(CurrentDay,CurrentTime,NewDay,ScheduleArriveTime,TransferTime),
  checkTransferTime(TransferTime,TransferTimeLimitL,TransferTimeLimitR),
  route(Transfer,To,NewDay,ScheduleArriveTime,TransferTimeLimitL,TransferTimeLimitR,Answer,[Transfer|Path],[FlightNumber|FlightNumbers]).%Ищем путь с пересадкой от этого города

% Перегрузка для прямого рейса
route(From,To,
      CurrentDay,
      CurrentTime,
      _TransferTimeLimitL,
      _TransferTimeLimitR,
      Answer,
      _Path,
      FlightNumbers):-
  flight(FlightNumber,From,To), 
  flightDay(FlightNumber,ScheduleDays),
  member(CurrentDay,ScheduleDays), % Летает в текущий день
  flightTime(FlightNumber,ScheduleDepartTime,_),
  isLeftMoreThanRight(ScheduleDepartTime,CurrentTime), % Успеваем сесть на прямой рейс
  reverse([FlightNumber|FlightNumbers],Answer).
