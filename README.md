Calcolo del determinante di una matrice di ordine <= 4 con il teorema di Laplace
=======================

##Input:
Il programma chiede all'utente l'ordine della matrice che intende inserire; poi tramite  un'apposita interfaccia lo guida nell'inserimento delle cifre nella matrice riga per riga.

##Output:
Il programma restituisce in output il determinante della matrice.
Nel caso che la matrice inserita sia invece di ordine 4 viene visualizzata l'estrazione delle sottomatrici e i rispettivi complementi algebrici, infine viene mostrato il determinante.

##Scelte adottate:
Innanzitutto occorre dire che la matrice (che come sappiamo è un vettore pluridimensionale) viene organizzata in memoria .data su un vettore monodimensionale.

Per il “popolamento” della matrice ho utilizzato due cicli for, uno per scorrere le righe e uno annidato per scorrere le colonne in modo da riuscire ad organizzare la matrice in un vettore lineare.

Mentre per la procedura ricorsiva del calcolo matrice ho utilizzato 3 casi base:
- Ordine matrice uguale a 1: il determinante è dato dall'elemento stesso (m[0][0])
- Ordine matrice uguale a 2: il determinante è dato da: m[0][0]*m[1][1]-m[0][1]*m[1][0]
- Ordine matrice uguale a 3: in questo caso per calcolare il determinante della matrice utilizzo la regola di Sarrus il cui determinante è dato da:

m[0][0]*m[1][1]*m[2][2]+m[0][1]*m[1][2]*m[2][0]+

m[0][2]*m[1][0]*m[2][1]-m[2][0]*m[1][1]*m[0][2]-

m[2][1]*m[1][2]*m[0][0]-m[2][2]*m[1][0]*m[0][1]

Nel caso che invece la matrice inserita fosse di ordine 4 il programma utilizza il teorema di Laplace  il quale dice che: il determinante di una matrice è uguale alla somma dei prodotti degli elementi  di una qualunque colonna per i rispettivi complementi algebrici.
Vengono quindi calcolati e sommati i rispettivi complementi algebrici di ogni elemento in posizione m[?][0] della matrice (che per chiarezza ho chiamato caporiga nel programma assembly).
Il programma infatti mostra l'estrazione della sottomatrice rispetto l'elemento citato e il rispettivo complemento algebrico, infine restituisce il determinante della matrice iniziale inserita.

*Possibili migliorie:*
Conoscendo i casi noti in cui il determinante di una matrice è uguale a 0, ad esempio quando si ha un' intera riga/colonna di zeri oppure due righe/colonne identiche ecc ecc, una possibile ed efficace miglioria sarebbe quella di inserire un controllo preventivo sui dati inseriti dall'utente e fornire quindi in modo precoce il determinante della matrice evitando all' elaboratore tutti i macchinosi calcoli; così si può ottenere un incremento notevole delle prestazioni.
