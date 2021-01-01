# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

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