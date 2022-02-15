proc(From,To,Day,X):-
  findall(Answer, route(From,To,Day,Answer),X).

route(From,To,Day,Answer):-
    consult(flights),
    route(From,To,Answer,[From],[], Day).
  
  route(From,To,Answer,_,FlightNumbers, Day):-
    flight(FlightNumber,From,To, Schedule), %Существует прямой рейс
    member(Day,Schedule),
    reverse([FlightNumber|FlightNumbers],Answer).
  
  route(From,To,Answer,Path,FlightNumbers, Day):-
    flight(FlightNumber, From, Transfer, Schedule),
    not(member(Transfer,Path)),%Если мы еще не были в этом городе
    member(Day,Schedule),
    route(Transfer,To,Answer,[Transfer|Path],[FlightNumber|FlightNumbers], Day).%Ищем путь с пересадкой от этого города
