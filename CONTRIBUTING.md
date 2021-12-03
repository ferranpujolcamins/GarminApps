# Contributing
## Getting started
To develop I use Visual Studio Code on Windows. In theory you could also work on Linux, but I couldn't get the SDK manager to work.

Follow [Garmin's guide](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/) to set everything up.

## Projects structure
This repository contains several projects, each in its own folder. There are projects for the data fields themselves and projects with code that is shared among several fields.

The `Shared_IQ_X_X_X` projects are [monkey barrels](https://developer.garmin.com/connect-iq/core-topics/shareable-libraries/) (libraries) that contain code used by the data fields projects. There's a different project for each [API level](https://developer.garmin.com/connect-iq/connect-iq-basics/#systemversusapilevel).

Although these projects are proper monkey barrels, I don't use them as such because I couldn't make the data fields projects work with them. Instead, I just simply add their source folders to the `base.sourcePath` property on the `monkey.jungle` file of the data fields projects.

## Working on a single project
If you need to work on only one project, you can simply open its subfolder on Visual Studio Code.

`Ctrl+Shift+b` will build the project.

For data fields projects, you can launch them in the simulator by pressing `F5`. The first time, the simulator will open, but the data field won't load. Keep the simulator window open, stop the debugging session (`Shift+F5`) and press `F5` again. This will happen every time you close the simulator window.

## Working on several projects
There's a Visual Studio Code workspace on the root folder that contains every project in the repository. The workspace allows you to work on several projects at the same time.

Every time you press `Ctrl+Shift+b` Visual Studio Code will ask what project you want to build.

When pressing `F5`, Visual Studio Code will launch the simulator with whatever data field is selected on the Run and Debug tab.

![image](https://user-images.githubusercontent.com/6429775/144629757-96d37818-cfb4-4be9-b69c-5267e0ea33c3.png)
