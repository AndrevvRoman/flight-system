:- dynamic flightCost/2, flightTime/3, flight/3.

printRoutesInfo(Route):-
    printRoutesInfo(Route, 1).

printRoutesInfo([Route | Tail], Count):-
    write("Option: "), writeln(Count),
    printSingleRouteInfo(Route, 0, TotalCost),
    writeln("You arrived!"),
    write("Total cost of the route: "), writeln(TotalCost),
    writeln("--------"),
    IncCount is Count + 1,
    printRoutesInfo(Tail,IncCount).

printRoutesInfo([],_).

printSingleRouteInfo([FlightNumber | Tail], CurrentCost, TotalCost):-
    flight(FlightNumber,From,To),
    flightTime(FlightNumber,h_m(DepartTimeH,DepartTimeM),h_m(ArrivalTimeH,ArrivalTimeM)),
    flightCost(FlightNumber,Cost),
    CurrentCostInc is CurrentCost + Cost,
    write("Take flight number: "), writeln(FlightNumber),
    write("From: "), write(From), write(", to: "), writeln(To),
    write("Depart time is: "), printTime(DepartTimeH,DepartTimeM),
    write("Arrival time is: "), printTime(ArrivalTimeH,ArrivalTimeM),
    write("It will cost you: "), writeln(Cost),
    writeln("And then..."),
    printSingleRouteInfo(Tail,CurrentCostInc, TotalCost).

printSingleRouteInfo([],CurrentCost,TotalCost):-
    TotalCost is CurrentCost.

printTime(TimeH,TimeM):-
    write(TimeH), write(":"), 
    TimeM = 0, writeln("00"), true, !; writeln(TimeM).
