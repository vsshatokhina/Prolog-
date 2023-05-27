% Именная база фактов

% Государства
country(1, "Россия", "Евразия", 144.5).
country(2, "Китай", "Азия", 1393.6).
country(3, "США", "Америка", 328.2).
country(4, "Германия", "Евразия", 83.1).
country(5, "Франция", "Евразия", 67.4).
country(6, "Италия", "Евразия", 60.4).
country(7, "Испания", "Евразия", 46.7).
country(8, "Великобритания", "Евразия", 66.0).
country(9, "Япония", "Азия", 126.2).
country(10, "Канада", "Америка", 37.7).
country(11, "Бразилия", "Америка", 209.5).
country(12, "Австралия", "Океания", 24.1).
country(13, "Южная Корея", "Азия", 51.6).
country(14, "Индия", "Азия", 1380.0).
country(15, "Египет", "Африка", 100.4).

% Столицы
capital(1, "Москва", 12.5).
capital(2, "Пекин", 21.5).
capital(3, "Вашингтон", 0.7).
capital(4, "Берлин", 3.4).
capital(5, "Париж", 2.2).
capital(6, "Рим", 2.8).
capital(7, "Мадрид", 3.2).
capital(8, "Лондон", 8.1).
capital(9, "Токио", 13.5).
capital(10, "Оттава", 1.0).
capital(11, "Бразилиа", 2.8).
capital(12, "Канберра", 0.4).
capital(13, "Сеул", 9.7).
capital(14, "Нью-Дели", 21.8).
capital(15, "Каир", 19.5).

% Связь между государствами и столицами
represents(1, 1).
represents(2, 2).
represents(3, 3).
represents(4, 4).
represents(5, 5).
represents(6, 6).
represents(7, 7).
represents(8, 8).
represents(9, 9).
represents(10, 10).
represents(11, 11).
represents(12, 12).
represents(13, 13).
represents(14, 14).
represents(15, 15).

% Определение доменов
:- module(domains, [continent/1]).

continent("Евразия").
continent("Азия").
continent("Америка").
continent("Океания").
continent("Африка").

% Правила

% Столица для заданной страны
capital_of_country(CountryName, CapitalName) :-
    country(CountryId, CountryName, _, _),
    represents(CapitalId, CountryId),
    capital(CapitalId, CapitalName, _).

% Генерация списка столиц для заданной части света
generate_capitals(Continent, Capitals) :-
    findall(CapitalName,
            (capital(CapitalId, CapitalName, _),
            represents(CapitalId, CountryId),
            country(CountryId, _, Continent, _)),
            Capitals).

% Количество стран, входящих в заданную часть света
count_countries(Continent, Count) :-
    findall(1, country(_, _, Continent, _), List),
    length(List, Count).

% Самая населенная столица заданной части света
most_populated_capital(Continent, CapitalName) :-
    capital(_, CapitalName, Pop),
    represents(CapitalId, CountryId),
    country(CountryId, _, Continent, _),
    findall(Population, (represents(CapitalId, CId), country(CId, _, _, Population)), Populations),
    max_member(Max, Populations),
    Max == Pop.

% Запросы

?- capital_of_country("Россия", Capital).
% Capital = "Москва"

?- generate_capitals("Евразия", Capitals).
% Capitals = ["Москва", "Берлин", "Париж", "Рим", "Мадрид", "Лондон"]

?- count_countries("Евразия", Count).
% Count = 8

?- most_populated_capital("Азия", Capital).
% Capital = "Пекин"
