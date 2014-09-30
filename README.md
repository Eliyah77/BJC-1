Bible de Jésus-Christ
===

Scripts et fichiers sources de la BJC

## Installation des outils (Debian)

```bash
# installation des paquets nécessaires
apt-get install git texmaker texlive-lang-french texlive-fonts-recommended texlive-xetex
```

## Récupération des fichiers

```bash
# copie locale du dépôt
git clone https://github.com/bible2vie/BJC.git ~/BJC
```

## Compilation PDF

```bash
# se placer dans le dossier BJC
cd ~/BJC/

# lancer la compilation avec make
make bjc_current

# pour compiler la Bible Martin 1744
make martin_1744
```
Prochainement en ligne, site de présentation : http://www.bible-de-jesus.org/
