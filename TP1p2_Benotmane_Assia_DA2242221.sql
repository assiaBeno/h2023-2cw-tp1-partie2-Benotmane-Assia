-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:                        Votre DA: 
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

SELECT *
FROM OUTILS_EMPRUNT;
SELECT *
FROM OUTILS_OUTIL;
SELECT *
FROM OUTILS_USAGER;

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_OUTIL;

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
--il me reste juste a ajouter un espace mais sa n'accpete pas car ils ne veut que deu argument  
SELECT CONCAT (CONCAT(PRENOM, ' '), NOM_FAMILLE) AS Nom_Complet
FROM OUTILS_USAGER;

-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT DISTINCT VILLE
FROM OUTILS_USAGER
ORDER BY VILLE ASC;
-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT *
FROM OUTILS_OUTIL
ORDER BY NOM, CODE_OUTIL ASC ;
-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT NUM_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_RETOUR is NULL;
-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./
SELECT NUM_EMPRUNT, DATE_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_EMPRUNT < '01-JAN-14';

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT NOM, CODE_OUTIL, UPPER(CARACTERISTIQUES) 
FROM OUTILS_OUTIl
WHERE CARACTERISTIQUES LIKE '%j%' ;
-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT NOM, CODE_OUTIL
FROM OUTILS_OUTIL
WHERE FABRICANT = 'Stanley';
-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT NOM, FABRICANT
FROM OUTILS_OUTIL
WHERE ANNEE BETWEEN 2006 AND 2008;

-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT CODE_OUTIL, NOM
FROM OUTILS_OUTIL
WHERE CARACTERISTIQUES NOT LIKE '%20 volt%';
-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(FABRICANT) "Nombre d'outils qui n'ont pas été fabriqué par Makita"
FROM OUTILS_OUTIL
WHERE FABRICANT NOT LIKE 'Makita';

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5

SELECT c.NOM_FAMILLE, c.PRENOM, a.NUM_EMPRUNT, MONTHS_BETWEEN(a.DATE_RETOUR, a.DATE_EMPRUNT) AS "DURÉE D'EMPRUNT", b.PRIX
FROM OUTILS_USAGER c
INNER JOIN OUTILS_EMPRUNT a
ON c.NUM_USAGER=a.NUM_USAGER
INNER JOIN OUTILS_OUTIL b 
ON a.CODE_OUTIL=b.CODE_OUTIL
WHERE A.DATE_EMPRUNT IS NOT NULL 
       AND A.DATE_RETOUR IS NOT NULL 
       AND B.PRIX IS NOT NULL 
       AND C.VILLE IN ('Vancouver', 'Regina')
ORDER BY c.NOM_FAMILLE, a.NUM_EMPRUNT;

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT b.NOM, b.CODE_OUTIL
FROM OUTILS_OUTIL b 
INNER JOIN OUTILS_EMPRUNT a
ON b.CODE_OUTIL=a.CODE_OUTIL 
WHERE a.DATE_RETOUR is NULL;

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT NOM_FAMILLE, PRENOM, COURRIEL 
FROM OUTILS_USAGER
WHERE NUM_USAGER NOT IN (
  SELECT DISTINCT NUM_USAGER
  FROM OUTILS_EMPRUNT);

-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT a.CODE_OUTIL as "CODE OUTILS PAS EMPRUNTER" 
FROM OUTILS_OUTIL a  
LEFT JOIN OUTILS_EMPRUNT b
ON a.CODE_OUTIL =  b.CODE_OUTIL 
WHERE b.CODE_OUTIL IS NULL;

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
-- vraiment pas sur de ce lui la mais bon 
SELECT NOM, PRIX 
FROM OUTILS_OUTIL
WHERE FABRICANT = 'Makita'
AND (prix > 
    (CASE 
        WHEN prix IS NULL 
            THEN (SELECT AVG(prix) 
                  FROM OUTILS_OUTIL 
                  WHERE prix IS NOT NULL)
        ELSE 
            (SELECT AVG(prix) 
            FROM OUTILS_OUTIL)
    END)
    );


-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT c.NOM_FAMILLE as "nom", c.PRENOM, c.ADRESSE as "Adresse des Usagers", b.NOM as "Nom des outils", a.CODE_OUTIL
FROM OUTILS_EMPRUNT a 
INNER JOIN OUTILS_OUTIL b   
ON a.CODE_OUTIL=b.CODE_OUTIL
INNER JOIN OUTILS_USAGER c  
ON a.NUM_USAGER=c.NUM_USAGER
WHERE a.DATE_EMPRUNT > '01-JAN-14'
ORDER BY c.NOM_FAMILLE;

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT COUNT(a.NUM_USAGER) as occurrences, b.NOM, AVG(b.PRIX) as prix
FROM OUTILS_EMPRUNT a 
LEFT JOIN OUTILS_OUTIL b
ON a.CODE_OUTIL=b.CODE_OUTIL
GROUP BY b.NOM 
HAVING COUNT(a.NUM_USAGER) > 1;

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

-- Une jointure     
SELECT DISTINCT NOM_FAMILLE, PRENOM, ADRESSE, VILLE
FROM OUTILS_USAGER c  
INNER JOIN OUTILS_EMPRUNT a  
ON c.NUM_USAGER= a.NUM_USAGER
WHERE a.NUM_EMPRUNT IS NOT NULL;

--IN 
SELECT DISTINCT NOM_FAMILLE, PRENOM, ADRESSE, VILLE
FROM OUTILS_USAGER
WHERE NUM_USAGER IN (SELECT NUM_USAGER 
                     FROM OUTILS_EMPRUNT 
                     WHERE NUM_EMPRUNT IS NOT NULL);
  

--EXISTS
SELECT NOM_FAMILLE, PRENOM, ADRESSE, VILLE
FROM OUTILS_USAGER c
WHERE EXISTS (SELECT 1
              FROM OUTILS_EMPRUNT a
              WHERE a.NUM_USAGER = c.NUM_USAGER);

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT FABRICANT, AVG(PRIX) AS MOYENNE_PRIX
FROM OUTILS_OUTIL
GROUP BY FABRICANT;

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT c.VILLE, SUM(b.PRIX) AS total_prix
FROM OUTILS_OUTIL b 
INNER JOIN OUTILS_EMPRUNT a 
ON b.CODE_OUTIL=a.CODE_OUTIL
INNER JOIN OUTILS_USAGER c  
ON a.NUM_USAGER=c.NUM_USAGER
GROUP BY c.ville
ORDER BY total_prix DESC;

-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL, NOM, FABRICANT, CARACTERISTIQUES, ANNEE, PRIX)
VALUES ('AF213', 'Affiloir', 'Assia', 'Longueur totale 286 mm, poids 160g, Bois de rose, Affiloir en acier extra dure', 2004, 79.99);

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO OUTILS_OUTIL (CODE_OUTIL, NOM, FABRICANT, CARACTERISTIQUES, ANNEE, PRIX)
VALUES ('HA212', 'Hache', 'Assia', '91 cm, vient avec un fourreau protecteur, lame avec enduit, efficace', 2012, 99.99);

-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM OUTILS_OUTIL
WHERE CODE_OUTIL IN('AF213', 'HA212');

-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE OUTILS_USAGER
SET NOM_FAMILLE = UPPER(NOM_FAMILLE);

