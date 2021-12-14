# ScrollFlipper

A [Hammerspoon][hammerspoon] Spoon that flips your scroll direction to 'normal' while a USB device of your choice is plugged in, and 'natural' otherwise.

## Why

Look, natural scrolling is fantastic. Direct manipulation. You're touching a surface and moving it around. Phones do it. Tablets do it. Laptops do it. 

But mice should **not** do it. You are not touching a surface, you are cranking a wheel. When you crank a wheel up, if it doesn't make the thing go up, it is monsterous.

So what happens if you have a MacBook, which you use both docked and undocked, with a mouse. Well, don't worry, Apple's mouse is a touch surface. And that's the only mouse you'd care to use on it, right? So no need for normal scrolling just for mice, right?

Seriously, though, Apple makes incredible hardware and software, but they have never, ever made a good mouse. Ever. If you're like me, the moment I touch one of those things my hand starts cramping immediately. No, if you're like me you have an actually good mouse, that you use for maybe a PC as well, for PC games.

But that's okay, there are still some great options available to you... unless you have a really very good mouse that is really good because it can be used wired AND wirelessly. So it appears to be two separate devices. So nothing will work properly with it.

Enter ScrollFlipper. This is the best software that I've ever made, and I've made some *corkers*. It makes me happy every time it activates. It's a pure ray of sunshine. Maybe one day it will be Sherlocked into the simple checkbox in macOS that it should be, but for now, let's get started.

## Installation

1. Install [Hammerspoon][hammerspoon]
2. [Download ScrollFlipper as a zip](https://github.com/Alazoral/ScrollFlipper/archive/refs/heads/main.zip)
3. Double click ScrollFlipper.spoon to install it.
4. Open your Hammerspoon Config using the menu item
5. Add the following to your config:
   ```lua
   hs.spoons.use("ScrollFlipper")
   spoon.ScrollFlipper:start() 
   ```
6. Save and reload your config

## Setup

You should now have a little 🐭 menu item in your menu bar. This is your manual control.

1. Figure out what device you want to watch. Remember, this is a device where if it's plugged in, it should use regular mouse scrolling and if it's not, it should be natural touch scrolling. If you're like me and you have a wireless mouse, pick something that remains plugged in the whole time. Maybe your keyboard, or your USB hub.
2. 🐭 → Watching Nothing… should bring up a list of USB devices. Choose your device.
3. There is no step three.

## Usage

When you dock or undock, you'll get a happy little notification to let you know it's happened. If it hasn't happened right, or you just need to flip it for whatever reason, you can trigger it manually with the 🐭 menu - just pick Scroll Direction to change the scroll direction. You can also use that menu to check in case you just feel like you might be going insane or your mouse is screwing up or something.

> ⚠️ **WARNING** 
>
> There's an unfortunate limitation to the automation that we have to use to accomplish this feat that means that when ScrollFlipper needs to change your scroll settings it has to do so by opening up System Preferences, going to the panel, changing it, and then quitting System Preferences. There's not much that you can do in System Preferences that won't be autosaved, so it's not a big deal, but as a general rule **avoid docking and undocking with System Preferences open**.

[hammerspoon]: http://www.hammerspoon.org