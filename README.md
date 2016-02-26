# KbFocusTestApp
App to illustrate iOS9 external keyboard bug

##Summary
On iPad Air 2 and iPad Pro it is possible to run 2 apps simultaneously by using "Split View". After activating and deactivating "Split View", primary app stops receiving bluetooth keyboard events.

##Steps to Reproduce
1. Open KbFocusTest app (small test app attached) on iPad Air 2 or iPad Pro, running iOS9, in full-screen mode;
2. Press up/down/left/right on BT keyboard (or PC keyboard in simulator) to make sure that KB events are processed by KbFocusTest app.
3. Activate "Split view" mode so that KbFocusTest is primary app on the left and another app is in secondary mode.
4. Touch secondary app with finger to direct KB events to it. 
5. Press up/down/left/right. As you can see, iOS doesn't deliver keystrokes to KbFocusTest app. It is OK.
6. Turn off "Split view" multitasking
7. Press up/down/left/right. iOS still doesn't deliver keystrokes to KbFocusTest app. Why???

##Expected Results
After activating and deactivating "Split View", primary app should receive keyboard events.

##Actual Results
After activating and deactivating "Split View", primary app stops receiving keyboard events.

##Version
iOS 9.2 (13C75)

##Configuration
iPad Air 2
