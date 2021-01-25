// Time.swift
// Created by Jérémy Goyette
// On 2020/12/29
// For SwiftSFML

import CSFML

/// Structure defining the settings of the OpenGL context attached to a window.
///
/// ContextSettings allows to define several advanced settings of the OpenGL context attached to a window.
///
/// All these settings with the exception of the compatibility flag and anti-aliasing level have no impact on the regular SFML rendering (graphics module), so you may need to use this structure only if you're using SFML as a windowing system for custom OpenGL rendering. (Not currently supported by SwiftSFML)
///
/// The `depthBits` and `stencilBits` members define the number of bits per pixel requested for the (respectively) depth and stencil buffers.
///
/// `antialiasingLevel` represents the requested number of multisampling levels for anti-aliasing.
///
/// majorVersion and minorVersion define the version of the OpenGL context that you want. Only versions greater or equal to 3.0 are relevant; versions lesser than 3.0 are all handled the same way (i.e. you can use any version < 3.0 if you don't want an OpenGL 3 context).
///
/// When requesting a context with a version greater or equal to 3.2, you have the option of specifying whether the context should follow the core or compatibility profile of all newer (>= 3.2) OpenGL specifications. For versions 3.0 and 3.1 there is only the core profile. By default a compatibility context is created. You only need to specify the core flag if you want a core profile context to use with your own OpenGL rendering. Warning: The graphics module will not function if you request a core profile context. Make sure the attributes are set to Default if you want to use the graphics module.
///
/// Setting the debug attribute flag will request a context with additional debugging features enabled. Depending on the system, this might be required for advanced OpenGL debugging. OpenGL debugging is disabled by default.
///
/// Please note that these values are only a hint. No failure will be reported if one or more of these values are not supported by the system; instead, SFML will try to find the closest valid match. You can then retrieve the settings that the window actually used to create its context, with `RenderWindow.settings`.
///
/// - note: For macOS, Apple only supports choosing between either a legacy context (OpenGL 2.1) or a core context (OpenGL version depends on the operating system version but is at least 3.2). Compatibility contexts are not supported. Further information is available on the OpenGL Capabilities Tables page. macOS also currently does not support debug contexts.

public typealias ContextSettings = sfContextSettings
