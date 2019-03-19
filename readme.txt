Reverse Polish notation
	Se citesc numerele din stringul dat ca input. Odata citite, numerele se vor pune in stiva. Daca avem un numar care are mai mult de 2 cifre, 
se vor concatena cifrele respective ale acestuia, urmand ca numarul final sa fie adaugat in stiva. De asemenea se verifica daca numarul este pozitiv
sau negativ. In registrul edx se regaseste 1 cand numarul este negativ sau 0 cand numarul este pozitiv. La intalnirea unuia dintre operatori, se vor 
scoate din stiva ultimele 2 numere adaugate, facandu-se operatia de rigoare. Rezultatul final este introdus inapoi in stiva si se continua procedeul pana
cand se ajunge la capatul acesteia;
