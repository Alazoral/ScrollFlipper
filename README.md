# ScrollFlipper

A [Hammerspoon][hammerspoon] Spoon that flips your scroll direction to 'normal' while a USB device of your choice is plugged in, and 'natural' otherwise.

## Why

Look, natural scrolling is fantastic. Direct manipulation. You're touching a surface and moving it around. Phones do it. Tablets do it. Laptops do it. 

But mice should **not** do it. You are not touching a surface, you are cranking a wheel. When you crank a wheel up, if it doesn't make the thing go up, it is monsterous.

So what happens if you have a MacBook, which you use both docked and undocked, with a mouse. Well, don't worry, Apple's mouse is a touch surface. And that's the only mouse you'd care to use on it, right? So no need for normal scrolling just for mice, right?

Seriously, though, Apple makes incredible hardware and software, but they have never, ever made a good mouse. Ever. If you're like me, the moment I touch one of those things my hand starts cramping immediately. No, if you're like me you have an actually good mouse, that you use for maybe a PC as well, for PC games. But Apple provides zero recourse for having the scroll settings different for trackpads and mice. Sure there's a trackpad settings pane and a mouse settings pane, each with their own, differently labelled scroll direction checkbox, but actually its the same damned checkbox.

But that's okay, there are still some utilities you can run to switch it for you... unless you have a really very good mouse that is really good because it can be used wired AND wirelessly. So it appears to be two separate devices. So nothing will work properly with it. So you're stuck every time you dock going into System Preferences, finding the stupid box and clicking it. Without realising it, subconsiously, leaving your desk and going out into the warm summer air and experiencing the Sun and life is a little bit harder. And you're so exhausted from the monotony of it all that it's the worse the next day. You resent that vestigial trackpad sitting over there, *mocking* you. "You should have paid a quarter of the price for an iMac or a Mac Mini", it whispers, "what a sucker. What a loser." You had dreams, ambitions, plans, to sit under a big tree or go to the beach and make sometime important, truly great, life defining, to draw inspiration from the world around you and explode like a supernova onto some scene that doesn't even exist yet, that your very greatness will bring into being like a star igniting for the first time. But no, that is impossible for you. You can't control your life's direction because you are too busy avoiding managing your scroll direction.

Enter ScrollFlipper. This is the best software that I've ever made, and I've made some *corkers*. It honestly makes me happy every time it activates. It's a pure ray of sunshine. Maybe one day it will be Sherlocked into "just making the checkboxes work how they appear they should work", but for now, let's get started.

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