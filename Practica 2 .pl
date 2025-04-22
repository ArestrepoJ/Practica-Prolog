% Catálogo de vehículos
vehicle(toyota, rav4, suv, 28000, 2022).
vehicle(toyota, camry, sedan, 24000, 2021).
vehicle(toyota, corolla, sedan, 20000, 2020).
vehicle(ford, mustang, sport, 45000, 2023).
vehicle(ford, explorer, suv, 35000, 2022).
vehicle(ford, f150, pickup, 30000, 2021).
vehicle(bmw, x5, suv, 60000, 2021).
vehicle(bmw, 3series, sedan, 40000, 2020).
vehicle(honda, crv, suv, 32000, 2022).
vehicle(honda, civic, sedan, 22000, 2021).
vehicle(chevrolet, silverado, pickup, 35000, 2022).

% Filtrar por tipo y presupuesto
meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

% Lista de vehículos por marca
list_vehicles_by_brand(Brand, Vehicles) :-
    findall(Reference, vehicle(Brand, Reference, _, _, _), Vehicles).

% Generar informe
generate_report(Brand, Type, Budget, Result) :-
    findall((Reference, Price),
            (vehicle(Brand, Reference, Type, Price, _), Price =< Budget),
            Vehicles),
    total_value(Vehicles, TotalValue),
    TotalValue =< 1000000, % Asegurar que el valor total no exceda $1,000,000
    Result = Vehicles.

% Calcular el valor total de una lista de vehículos
total_value(Vehicles, TotalValue) :-
    findall(Price, (member((_, Price), Vehicles)), Prices),
    sum_list(Prices, TotalValue).

% Caso de prueba 1: Listar todas las referencias de SUV de Toyota con precio inferior a $30,000.
test_case_1(Result) :-
    findall(Reference, (vehicle(toyota, Reference, suv, Price, _), Price < 30000), Result).

% Caso de prueba 2: Mostrar vehículos de la marca Ford agrupados por tipo y año.
test_case_2(Result) :-
    bagof((Type, Year, Reference), vehicle(ford, Reference, Type, _, Year), Result).

% Caso de prueba 3: Calcular el valor total de un inventario filtrado por tipo "Sedan" sin exceder $500,000.
test_case_3(TotalValue) :-
    findall(Price, (vehicle(_, _, sedan, Price, _), Price =< 500000), Prices),
    sum_list(Prices, TotalValue).
