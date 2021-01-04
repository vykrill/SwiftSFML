# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased
### The Rendering Update
#### Additions
- Ported the `Color` struct.
- Added a more reliable version of `setTitle()` in `RenderWindow`.

## 0.2.0 Event Update (2021/01/03)
### Breaking changes
- many RenderWindow methods now have the label `to:` for their first argument.

### Additions
- Added `setKeyRepeat(to:)` and `setVisible(to:)` methods to `RenderWindow`.
- Imported the event infrastructure of SFML
    - Created the `Event` enumeration, which can handle nearly all use cases.
        - The related data have been ported as well.
    - Added `poll(event:)` and `wait(event:)` to `RenderWindow` to get events.
- Created a demo project to test the library.

### Warning
- Many of the enumerations declared in `Event` will be moved to futur distinct classes. The ones concerned are as follow:
    - `Event.JoystickMoveData.Axis`
    - `Event.KeyData.Code`
    - `Event.MouseButtonData.Button`
    - `Event.MouseWheelScrollData.Wheel`
    - `Event.SensorData.SensorType`

## 0.1.1 (2020/12/31)
The windows are now a little bit more interactive.
- Access to some `RenderWindow`'s properties:
    - `position`
    - `size`
    - `settings`
    - `hasFocus`
    - `isOpen`
- Control over some of `RenderWindow` properties:
    - `position`
    - `size`
    - Framerate
    - Mouse behaviour
    - Title
    - Vertical sync
    - Visibility and focus

## 0.1.0 (2020/12/31)
- The basic components required to create a window have been implemented:
    - `ContextSettings`
    - `VideoMode`
    - `WindowStyle`
    - `RenderWindow` (incomplete)
- The following utility types have been ported too:
    - `Clock`
    - `Time`
    - `Vector2`
    - `Vector3`
- The `sleep(_:)` function is available.