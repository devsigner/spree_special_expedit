INSTALLATION
============

Dans le répertoire de l'application Spree dans laquelle cette gem sera utilisée
- Editer le fichier Gemfile et ajouter gem 'spree_shoppierre', :path => 'vers la gem' (ou source vers le repository git)
- bundle install
- rake spree_shoppierre:install:migrations
- rake db:migrate (préciser l'environnement si autre que dev, RAILS_ENV=production )
- rake spree_shoppierre:set_defaults (préciser l'environnement si autre que dev, RAILS_ENV=production)

Dans l'admin du projet spree

- Dans Configuration / Zones, créer une zone 'France' et y affecter la france comme pays d'expédition
- Dans Configuration / Shipping Methods, supprimer les éventuelles méthodes existantes et en créer une nouvelle
  - Nom : 'Palette Ou Colis France'
  - Zone : France
  - Display : 'Both'
  - Calculator : Choisir impérativement 'Envoi colis ou palette'

  Pour le reste des paramètres du calculateur, se référer au point 3) ci dessous

UTILISATION
===========

1) Echantillons

Dans chaque fiche produit (en mode admin) pour lequel un échantillon est possible, activer le bouton radio 'Oui'.

2) Unités

Dans chaque fiche produit (en mode admin) choisir si le produit se vend par unité ou au M²

3) Livraison

Les frais de livraison utilisent plusieurs paramètres pour déterminer la manière dont l'envoi sera calculé.

* dans Configuration / General Settings, déterminer le poids par défaut d'un échantillon (float)
* dans Configuration / States, choisir France puis éditer les states qui vont correspondre aux différentes zones de tarification pour les envois par palettes
  - pour chaque zone, indiquer le prix d'envoi ainsi que les départements concernés (attention à bien saisir le 0 pour les départements < à 10)
  - le calculateur de frais d'envoi utilisera le code postal de l'adresse de livraison pour déterminer le coût d'envoi des palettes dans la zone en question
* dans Configuration / Shipping Methods, éditer la méthode 'colis ou palette' et modifier les paramètres
  - le calculateur doit être impérativement fixé à 'Envoi colis ou palette'
  - le coût de base d'un envoi postal s'applique pour les envois sans palettes, dès le premier article
  - le coût supplémentaire d'un envoi postal s'applique pour les articles suivants 
  - le poids maxi d'un envoi postal correspond à la limite au delà de laquelle on passe à un envoi par palette
  - le poids maxi d'une palette correspond à sa capacité maximale

Dans le répertoire du projet Spree, utiliser la commande bundle rake spree_shoppierre:verify_france_shipping_deps pour vérifier que tous les départements ont bien été affecté à une zone de livraison

RSPEC
=====

cd gem_shoppierre/spec/dummy
procéder à l'installation de spree (db migrate, etc.)
bundle exec rake spree_shoppierre:install:migrations
cd gem_shoppierre
rspec spec

Les spec utilisent spork, mais devraient fonctionner même si cette gem n'est pas dispo. Dans le cas contraire, procéder à son installation et lancer
Spork dans un shell et rspec dans un autre, en précisant --drb dans le fichier .rspec


