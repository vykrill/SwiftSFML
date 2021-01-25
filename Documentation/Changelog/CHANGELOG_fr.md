# Changelog
Tous les changements notables apportés au projet seront documentés dans ce fichier.

[Appuyez ici pour la version anglaise.](../../CHANGELOG.md)

Le format est basé sur [Tenez un changelog](https://keepachangelog.com/fr/1.0.0/)
et ce projet est conforme à la [Gestion sémantique de version](https://semver.org/lang/fr/).

## Non-publié

## 0.3.0 La mise a jour du rendu
Avec cette mise à jour, vous pouvez maintenant dessiner du contenu dans vos fenêtres!

### Changements cassants
- Le nom de plusieurs méthodes de `RenderWindow` a été modifié.

> **Rappel!**
>
> La prochaine version va inclure des changements cassants par rapport au stockage des données relatives aux événements:
>    - `Event.JoystickMoveData.Axis`
>    - `Event.KeyData.Code`
>    - `Event.MouseButtonData.Button`
>    - `Event.MouseWheelScrollData.Wheel`
>    - `Event.SensorData.SensorType`

### Additions
- Importation de la majorité du module graphique:
    - `BlendMode`
    - `CircleShape`
    - `Color`
    - `Image`
    - `RectF` and `RectI`
    - `RenderState`
    - `RenderTexture`
    - `Sprite`
    - `Texture`
    - `Transform`
    - `TransformHandler` (`sfTransformable`)
    - `Vertex`
    - `View`
- Addition de la possibilité de dessiner du contenu dans `RenderWindow`.
- Création d'un protocole afin de créer du contenu dessinable:
    - `Drawable`
    - `Transformable`
    - `VertexArray`
- `VideoMode` comprend maintenant des propriétés afin d'obtenir et de valider des modes plein-écran.
- Ajout d'un lien reliant les différentes localisations des changelogs.

### Changements
- `Vector2F` peut maintenant être initialisé à partir de nombres entiers.
- La démo a été mise à jour afin d'inclure une démonstrations des possibilités de dessin.
- La nomenclature d'API de `RenderWindow` a été modifié.
    
    Par exemple, la fonction `display()` a été renommée en `update()`.

### Corrections
- Correction d'un problème où le titre d'une `RenderWindow` s'affichait incorrectement et causait le plantage de l'application.
- Correction d'un problème causant l'échec du test d'égalité entre deux `Vector2F` égaux.

## 0.2.0 Mise à jour des événements (2021/01/03)
### Changements cassants
- Plusieurs méthodes de `RenderWindow` ont maintenant l'étiquette `to:` avant le premier argument.

### Additions
- Ajout des méthodes `setKeyRepeat(to:)` et `setVisible(to:)` à `RenderWindow`.
- Importation de l'infrastucture événementielle de SFML
    - Création de l'énumération `Event`, capable de représentater presque tous les événements de SFML.
        - Les données liées aux événements sont aussi disponibles.
    - Ajout des méthodes `poll(event:)` et `wait(event:)` à `RenderWindow` afin d'obtenir les événements.
- Création d'un projet modèle afin de tester la librairie.

### Attention
- Plusieurs énumérations déclarées dans `Event` vont être déplacées dans des classes distinctes. Voici celles qui sont
  concernées:
    - `Event.JoystickMoveData.Axis`
    - `Event.KeyData.Code`
    - `Event.MouseButtonData.Button`
    - `Event.MouseWheelScrollData.Wheel`
    - `Event.SensorData.SensorType`

## 0.1.1 (2020/12/31)
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

## 0.1.0 (2020/12/31)
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