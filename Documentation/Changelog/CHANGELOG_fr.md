# Changelog
Tous les changements notables apportés au projet seront documentés dans ce fichier.

Le format est basé sur [Tenez un changelog](https://keepachangelog.com/fr/1.0.0/)
et ce projet est conforme à la [Gestion sémantique de version](https://semver.org/lang/fr/).

## Non-publié

## 0.1.1
Les fenêtres sont maintenant un peu plus interactives.
- Il est possible d'accéder à certaines de leur propriétés:
    - `position`
    - `size`
    - `settings`
    - `hasFocus`
    - `isOpen`
- Il est aussi possible d'en contrôler:
    - `position`
    - `size`
    - Le comportement de la souris
    - La syncronisation verticale
    - Le taux de rafraîchissement d'écran
    - Le titre
    - La visibilité et la mise en premier plan

## 0.1.0
- Les composants nécéssaires à la création d'une fenêtre ont étés implementés:
    `ContextSettings`
    - `VideoMode`
    - `WindowStyle`
    - `RenderWindow` (incomplet)
- Les types utilitaires suivants ont aussi été ajoutés:
    - `Clock`
    - `Time`
    - `Vector2`
    - `Vector3`
- La fonction `sleep(_:)` est disponible.