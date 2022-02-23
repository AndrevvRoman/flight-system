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

printProgrammInfo:-
    writeln("-------------------"),
    writeln("Flight route system"),
    writeln("-------------------"),
    writeln("Helps you to find all route from A to B by plane"),
    nl,
    nl.

readSortType(SortType):-
    writeln("Which routes are you looking for ?"),
    writeln("1) Less count of transfers as possble"),
    writeln("2) Less prices as possble"),
    read(SortType).

readQueryInfo(Origin,Dest,WeekDayDepart,DepartTimeH,DepartTimeM):-
    writeln("Type origin city. Type '.' in the end of the line to continue.."),
    read(Origin),
    writeln("Type desination city. Type '.' in the end of the line to continue.."),
    read(Dest),
    writeln("Type department weekday (mon,fri..). Type '.' in the end of the line to continue.."),
    read(WeekDayDepart),
    writeln("Type depart hour (24h format). Type '.' in the end of the line to continue.."),
    read(DepartTimeH),
    writeln("Type depart minute (24h format). Type '.' in the end of the line to continue.."),
    read(DepartTimeM).
