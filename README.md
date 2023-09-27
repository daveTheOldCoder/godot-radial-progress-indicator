# Radial Progress Indicator
Radial progress indicator is a plugin for the Godot game engine. It is a Control that displays a radial progress indicator with several options.
<br/>

## Properties<br/>

- max\_value : maximum value<br/>
- progress : progress value<br/>
- radius : radius of indicator<br/>
- thickness : thickness of indicator<br/>
- bg\_color : background color<br/>
- bar\_color : indicator color<br/>

Set the *progress* property to a positive value to move the indicator clockwise, and to a negative value to move the indicator counterclockwise.

Instead of setting the *progress* property, the *animate* method can be called to move the progress indicator from *initial_value* to *max_value* over *duration* seconds.

- animate(duration: float, clockwise: bool = true, initial\_value: float = 0.0) <br/>

## Installation

The plugin is provided inside a simple demonstration project.

To use the plugin in another project, copy the folder *addons/radial_progress* into the project folder.

![](README_images/filesystem_dock.png)

Then enable the plugin in Project / Project Settings... / Plugins.

![](README_images/project_settings_plugins.png)

Now the RadialProgress is available when creating a new node.

![](README_images/create_new_node.png)