:- use_module(library(date)).

flightRouteCompare(>,RouteLeft,RouteRight):-
    length(RouteLeft,LengthL),length(RouteRight,LengthR), LengthL > LengthR.
  flightRouteCompare(<,RouteLeft,RouteRight):-
    length(RouteLeft,LengthL),length(RouteRight,LengthR), LengthL < LengthR.
  flightRouteCompare(=,RouteLeft,RouteRight):-
    length(RouteLeft,LengthL),length(RouteRight,LengthR), LengthL = LengthR.
  
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
