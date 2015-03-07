## Ajout titres

Les titres sont à mettre dans la balise `\TextTitle{}`, les renvois (sur les titres) sont à mettre dans la balise `\FTNTT{}` (attention différent de `\FTNT{}`, il y a deux 'T') sur le dernier mot du titre.

* Titre simple :
```tex
\TextTitle{Famine en Juda}
```

* Titre avec renvois ou note :
```tex
\TextTitle{Retour du Roi de la terre à la fin de la tribulation\FTNTT{Mc. 13:24-27 ; Lu. 21:25-28.}}
```

* Exemples :

```tex
% en tête de chapitre
\VS{24}Joseph s’étant donc réveillé de son sommeil, fit ce que l'ange du Seigneur lui avait ordonné, et il prit sa femme.
\VS{25}Mais il ne la connut point jusqu'à ce qu'elle ait enfanté son fils premier-né, auquel il donna le nom de Jésus.
\Chap{2}
\TextTitle{Arrivée des mages}
\VerseOne{}Jésus étant né à Bethléem, ville de Juda, au temps du roi Hérode, voici des mages d'Orient arrivèrent à Jérusalem.
\VS{2}En disant : Où est le Roi des Juifs qui vient de naître ? Car nous avons vu son étoile en Orient, et nous sommes venus l'adorer.
\VS{3}Le roi Hérode ayant entendu, fut troublé et tout Jérusalem avec lui.

% dans le texte
\VS{10}Quand ils virent l'étoile, ils furent saisis d’une très grande joie.
\VS{11}Ils entrèrent dans la maison, virent le petit enfant avec Marie sa mère, se prosternèrent et l’adorèrent. Ils ouvrirent ensuite leurs trésors et lui offrirent des présents : De l'or, de l'encens et de la myrrhe.
\VS{12}Puis, divinement avertis en songe de ne pas retourner vers Hérode, ils regagnèrent leur pays par un autre chemin.
\TextTitle{Fuite en Egypte\FTNTT{Mt. 3:1-15}}
\VS{13}Lorsqu’ils furent partis, voici, l’Ange du Seigneur apparut dans un songe à Joseph, et lui dit : Lève-toi et prends le petit enfant et sa mère, fuis en Egypte, et demeure là, jusqu'à ce que je te le dise ; car Hérode cherchera le petit enfant pour le faire mourir.
\VS{14}Joseph donc étant réveillé, prit de nuit le petit enfant et sa mère, et se retira en Egypte.
\VS{15}Il y resta là jusqu’à la mort d'Hérode ; afin que s’accomplisse ce que le Seigneur avait annoncé par le prophète : J'ai appelé mon Fils hors d'Egypte\FTNT{Os. 11:1}.
\TextTitle{Hérode massacre des enfants innocents}
\VS{16}Alors Hérode voyant que les mages s'étaient moqués de lui, se mit dans une grande colère, et il envoya tuer tous les enfants qui étaient à Bethléem, et dans tout son territoire ; depuis l'âge de deux ans, et au-dessous, selon la date dont il s'était exactement enquis auprès des mages.
\VS{17}Alors s’accomplit ce qui avait été annoncé par Jérémie le prophète :
```

## Ajout notes

Utiliser la balise `\FTNT{}` collée au mot auquel lequel doit correspondre la note.

* Exemple :

```tex
\VS{9}Après avoir entendu le roi, ils partirent. Et voici, l'étoile\FTNT{Il est évident que cette étoile qui se déplace pour guider les mages n’est pas une étoile ordinaire. Il s’agit de Jésus-Christ lui-même (Ap. 22:16).} qu'ils avaient vue en Orient allait devant eux, jusqu’au moment où, arrivée au-dessus du lieu où était le petit enfant, elle s’arrêta.
```

S'il s'agit d'une notre à mettre sur un titre, il faut utiliser la balise `\FTNTT{}` sur le dernier mot, cf. « Titre avec renvois ou note ».
