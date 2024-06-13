# Apka z fiszkami

##  Widoki i funkcjonalności na nich

### Lista kolekcji fiszek - strona główna
- Wyświetla wszystkie kolekcje fiszek, które są dostępne w bazie danych.
- Każda kolekcja zawiera nazwę, liczbę fiszek oraz progress (bar) pokazujący ile fiszek z danej kolekcji zostało oznaczonych jako "nauczone"
- Możliwość dodania nowej kolekcji (toolbar)
- Możliwość usunięcia kolekcji (swipe)
- Klikniecie na kolekcje przenosci [do widoku poszczególnej kolekcji](#widok-pojedynczej-kolekcji)

### Widok pojedynczej kolekcji
- Wyświetla wszystkie fiszki z danej kolekcji (jakos zrobic scroll??)
- Każda fiszka ma wyświetlone pytanie oraz liczbę odpowiedzi i status (nauczone/nie nauczone)
- Możliwośc przejścia do widoku edycji kolekcji (toolbar)
- Możliwość dodania nowej fiszki (toolbar)
- Możliwość usunięcia fiszki (swipe)
- Mozliwosc wyswietlenia szczegolow fiszki, odpowiedzi itp (klikniecie na fiszke) - przenosi do [widoku pojedynczej fiszki](#widok-pojedynczej-fiszki)
- Możliwość edycji fiszki (przytrzymanie fiszki przenosi do [widoku edycji fiszki](#widok-edycji-i-dodawania-fiszki))
- Możliwość powrotu do [listy kolekcji](#lista-kolekcji-fiszek---strona-główna)
- Możliwość przejcia do [trybu nauki](#widok-nauki) (ładny przycisk)
- Możliwośc zresetowania progressu (toolbar)
- Możliwość usunięcia kolekcji (toolbar)
- Jeżeli kolekcja nie zawiera żadnych fiszek, lub wszystkie są oznaczone jako "nauczone", wyświetla się stosowny komunikat

### widok pojedynczej fiszki
- Pytanie
- Poprawna odpowiedź
- Pozostałe odpowiedzi
- Przyciski do usuwania fiszki, edycji fiszki, powrotu 

### Widok edycji i dodawania fiszki
- Pole do wpisania pytania
- Pole do wpisania poprawnej odpowiedzi
- Pole do wpisania niepoprawnej odpowiedzi i przycisk do dodania kolejnego pola
- Możliwość zapisania zmian lub anulowania zmian

### Widok nauki
- Progressbar
- Losowo wyświetla fiszki z danej kolekcji, które nie zostały wcześniej oznaczone jako "nauczone"
- Wybranie odpowiedzi pokazuje poprawną odpowiedź
- Przyciski "Umiem" i "Nie umiem", które przenoszą do kolejnej fiszki
- "Nie umiem" sprawia fiszka zostaje dodana na koniec kolejki
- "Umiem" sprawia, że fiszka zostaje oznaczona jako "nauczona" i nie jest już wyświetlana w trybie nauki
- Po przejściu przez wszystkie fiszki, wyświetla się komunikat o zakończeniu nauki i możliwość powrotu do [widoku kolekcji](#widok-pojedynczej-kolekcji)

### Widok edycji i dodawania kolekcji
- Pole do wpisania nazwy kolekcji
- Pole do dodania koloru
- Możliwość zapisania zmian lub anulowania zmian (cofniecia)

### Widok kontaktu 
- Mapa

## Model danych

### Kolekcja
- Nazwa
- Fiszki (relacja toMany)
- Kolor

### Fiszka
- Pytanie
- Poprawna odpowiedź (relacja toOne)
- Pozostałe odpowiedzi (relacja toMany)
- Kolekcja (relacja toOne)
- Nauczone (bool)

### Odpowiedź
- Treść
- Fiszka (relacja toOne)
