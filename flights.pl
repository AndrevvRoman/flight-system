%flight(Number,Origin,Dest,Day,DepartTime,ArrivalTime,Cost)
flight(a1,london,dublin).
flight(b2,london,chicago).
flight(c3,rome,london).
flight(d4,rome,paris).
flight(e5,paris,dublin).
flight(f6,berlin,moscow).
flight(a7,paris,amsterdam).
flight(b8,berlin,dublin).
flight(c9,london,newyork).
flight(d10,dublin,newyork).
flight(e11,dublin,cork).
flight(f12,dublin,rome).
flight(g13,dublin,chicago).
flight(a14,amsterdam,hongkong).
flight(b15,london,hongkong).
flight(c16,dublin,amsterdam).

% flightDay(Number,[DaysFly])
flightDay(a1,[mon]).
flightDay(b2,[mon]).
flightDay(c3,[mon]).
flightDay(d4,[mon]).
flightDay(e5,[mon,tue]).
flightDay(f6,[mon]).
flightDay(a7,[mon]).
flightDay(b8,[mon]).
flightDay(c9,[mon]).
flightDay(d10,[mon]).
flightDay(e11,[mon]).
flightDay(f12,[mon]).
flightDay(g13,[mon]).
flightDay(a14,[mon]).
flightDay(b15,[mon]).
flightDay(c16,[mon]).

% X = [[a1], [a1, f12, d4, e5]].
% flightTime(Number,h_mDepart,h_mArrival)
flightTime(a1,h_m(12,40),h_m(13,00)).
flightTime(b2,h_m(12,40),h_m(15,00)).
flightTime(c3,h_m(12,40),h_m(15,00)).
flightTime(d4,h_m(15,30),h_m(0,40)).
flightTime(e5,h_m(3,30),h_m(20,00)).
flightTime(f6,h_m(12,40),h_m(15,00)).
flightTime(a7,h_m(12,40),h_m(15,00)).
flightTime(b8,h_m(12,40),h_m(15,00)).
flightTime(c9,h_m(12,40),h_m(15,00)).
flightTime(d10,h_m(12,40),h_m(15,00)).
flightTime(e11,h_m(12,40),h_m(15,00)).
flightTime(f12,h_m(14,00),h_m(15,00)).
flightTime(f12,h_m(14,00),h_m(21,00)).
flightTime(g13,h_m(12,40),h_m(15,00)).
flightTime(a14,h_m(12,40),h_m(15,00)).
flightTime(b15,h_m(12,40),h_m(15,00)).
flightTime(c16,h_m(12,40),h_m(15,00)).

% flightCost(Number,Cost)
flightCost(a1,15).
flightCost(b2,12).
flightCost(c3,13).
flightCost(d4,14).
flightCost(e5,15).
flightCost(f6,16).
flightCost(a7,20).
flightCost(b8,30).
flightCost(c9,56).
flightCost(d10,21).
flightCost(e11,20).
flightCost(f12,30).
flightCost(g13,11).
flightCost(a14,12).
flightCost(b15,15).
flightCost(c16,19).

%nextDay(CurrentDay,NextDay).
nextDay(mon,tue).
nextDay(tue,wed).
nextDay(wed,thu).
nextDay(thu,fri).
nextDay(fri,sat).
nextDay(sat,sun).
nextDay(sun,mon).