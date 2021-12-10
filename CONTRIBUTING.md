# Contributing
## Getting started
To develop I use Visual Studio Code on Windows. In theory you could also work on Linux, but I couldn't get the SDK manager to work.

Follow [Garmin's guide](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/) to set everything up.

## Projects structure
This repository contains several projects, each in its own folder. There are projects for the data fields themselves and projects with shared code.

The `Shared_IQ_X_X_X` projects are [monkey barrels](https://developer.garmin.com/connect-iq/core-topics/shareable-libraries/) (libraries) that contain code used by the data fields projects. There's a different project for each [API level](https://developer.garmin.com/connect-iq/connect-iq-basics/#systemversusapilevel).

Although these projects are proper monkey barrels, I don't use them as such, because I couldn't make the data fields projects work with them. Instead, I added their source folders to the `base.sourcePath` property on the `monkey.jungle` file of the data field projects.

I couldn't run unit tests defined inside a barrel, so I created a dummy app project named `BarrelTests` that contains the unit tests of the monkey barrels. Run the tests as described below.

## Working on a single project
If you only need to work on one project, you can simply open its subfolder on Visual Studio Code.

`Ctrl+Shift+b` will build the project.

You can run data field projects in the simulator by pressing `F5`. The first time, the simulator will open, but the data field won't load. Keep the simulator window open, stop the debugging session (`Shift+F5`) and then press `F5` again. You'll need to do this every time the simulator window is closed.

To run the unit tests, open the command palette with `Ctrl+Shift+p` and select the `Monkey C: Run Tests` command. Test results are printed on the debug console (`Ctrl+Shift+y`).

## Working on several projects
There's a Visual Studio Code workspace on the root folder that contains every project in the repository. The workspace allows you to work on several projects at the same time.

Every time you press `Ctrl+Shift+b` Visual Studio Code will ask what project you want to build.

When pressing `F5`, Visual Studio Code will launch the simulator with whatever data field is selected on the Run and Debug tab.

![image](https://user-images.githubusercontent.com/6429775/144629757-96d37818-cfb4-4be9-b69c-5267e0ea33c3.png)

To run the unit tests for a project, make sure that a file of that project is open on the editor (Visual Studio Code will run the test command on the project of the file you are currently editing). Then open the Visual Studio Code command palette with `Ctrl+Shift+p` and select the `Monkey C: Run Tests` command.

Alternatively, you can right click on the project folder on the file explorer and select `Build Current Project` or `Run Tests`.

## Debugging unit tests
I wasn't able to debug unit tests using the Visual Studio Code debugger. As a workaround, you can call your test functions in the `initialize` function of your app class. You have to pass a logger to your test functions. There's a `Logger` class defined in the `UnitTest` of the `Shared_IQ_1_4_0` project you can use:

```
import Toybox.System;
using Shared_IQ_1_4_0.UnitTest.Logger as TestLogger;

class App extends Application.AppBase {

    (:debug)
    function initialize() {
        AppBase.initialize();

        var logger = new TestLogger() as Toybox.Test.Logger;
        var result = myTestFunction(logger);
        System.println(result);
    }

    (:release)
    function initialize() {
        AppBase.initialize();
    }
}
```
Then run your app on the simulator and you'll be able to use the debugger.