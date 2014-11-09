Bible de Jésus-Christ
===

Scripts et fichiers sources de la BJC

# Procédure pour GNU/Linux

## 1. Installation des outils (Debian/Ubuntu)

```bash
# installation des paquets nécessaires
apt-get install git make texmaker texlive-lang-french texlive-fonts-recommended texlive-latex-extra texlive-xetex
```

## 2. Récupération des fichiers

```bash
# copie locale du dépôt
git clone https://github.com/bible2vie/BJC.git ~/BJC
```

## 3. Compilation PDF

```bash
# se placer dans le dossier BJC
cd ~/BJC/

# lancer la compilation avec make
make bjc_current

# pour compiler la Bible Martin 1744
make martin_1744
```

# Procédure pour Windows

## 1. Installation des outils

Télécharger le logiciel [MiKTeX](http://www.miktex.org/download).

## 2. Récupération des fichiers

Télécharger l'archive du dépôt [BJC](https://github.com/bible2vie/BJC/archive/master.zip) et l'extraire.

## 3. Compilation PDF

Ouvrir avec MiKTeX l'un des fichiers `bjc_*.tex` dans le dossier `tex/`, séléctionner le moteur XeLaTeX. Il est généralement nécessaire de lancer deux ou trois fois la compilation pour le fichier soit correctement construit. Le fichier généré se trouve ensuite dans le dossier `pdf/`.

# En savoir plus

Prochainement en ligne, site de présentation : http://www.bible-de-jesus.org/
