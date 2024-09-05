---
layout: post
title: "how to enable auto-ratation for just one specific page in Flutter"
date: 2024-09-05 11:16:00 +0800
categories: jekyll update
---

When you browse this article, i suppose you want to create an application with most of the pages is only supported for portrait orientation, but one specific page can be autorated and can be supported for protrait and landscape orientation. etc. Your application contains video playing functionality and customer would have a good experience when browse video page that they don't need to click the rotate button. The can simply rotate the mobile phone then the video will automatically rotate and display in full screen. The following practice i will explain how to implement that.
### Step 1: Check Deployment Info in iOS project
Open your iOS project in the directory `flutter_demo/ios/Runner.xcworkspace`, navigate to General panel and check that all the three options Portrait Orientation and Landscape Left and Landscape Right in the deployment info in your iOS project are checked.
Only did you check the options in general configuration in native project that flutter can change the orientation configuration for specific pages.

### Step 2: Config Portrait Orientation in main.dart
In your main.dart file. call the `SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);` either in the `main()` function or in the first widget's State class lifecycle method `initState()`.

```
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
```

### Step3: Config Portait and Landscape Orientation in your video player page
You should config both Portait and Landscape when video player page appears. Addtionally you should revert to Portrait when video player page disappears. This ensure that when you navigate to another page from the video player page, it does not affect the orientation configuration of other pages. However, flutter does not provide a native lifecycle method to detect when a page appears and disappears. To solve this, i introduce a third-party package called `PageLifeCycle` to help  implment the configuration in this step.
```
@override
  Widget build(BuildContext context) {
    return PageLifecycle(
      stateChanged: (apper) {
        if (apper) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight,DeviceOrientation.portraitUp]);
        } else {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }
      },
      child: ...
    )
  }
```

### All done
The above code is in this repository. [flutter_auto_ratation](https://github.com/heeween/flutter_auto_ratation) in github.

Speaking of the auto orientation in UIKit. You never can specify the orientation for individual view controller on a case-by-case basis if you use Navigationcontroller. You can only specify the orientation for the UINavigationController. If you try to set the orientation for a child controller within UINavigationController, it will have no effect. However, it's nearly impossible to build an iOS application without Navigationcontroller. So you should override the `var supportedInterfaceOrientations: UIInterfaceOrientationMask {}` method with a variable. Then you should change the variable in the child controller.

And for android and harmoneyOS, it's very flexible for developer to config the orientation programmatically. For example in harmonyOS.

```
let context = getContext(this) as common.UIAbilityContext;
let win = context.windowStage.getMainWindowSync();
win.setPreferredOrientation(window.Orientation.AUTO_ROTATION_RESTRICTED);
```