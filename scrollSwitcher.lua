logger = hs.logger.new('usb')
hardwareTriggerSetting = 'hardware-trigger-name'

function setMirroring(shouldMirror)
    -- local big = hs.screen.primaryScreen()
    -- local little = big:next()
    -- little:setPrimary()
end

function getScrollDirection()
    -- used to be hs.mouse.scrollDirection() but that isn't working for me right now
    if (hs.settings.get("com.apple.swipescrolldirection")) then
        return "natural"
    else
        return "normal"
    end
end

function setNaturalScrolling(shouldBeNatural)
    local isNatural = getScrollDirection() == "natural"
    if (shouldBeNatural ~= isNatural) then
        hs.osascript.javascript([[
            Application("System Preferences").panes["Trackpad"].reveal()        
            Application("System Events").processes["System Preferences"].windows[0].tabGroups[0].checkboxes[0].click()
        ]])

        hs.notify.show("Scroll direction", "Your scroll direction is now " .. getScrollDirection(), "Enjoy your scrolling experience!")
    end
    hs.osascript.javascript("Application('System Preferences').quit()")
end

function isDevice(device)
    print("Testing " .. device["productName"] .. " is " .. usbTriggerDeviceName)
    if (not usbTriggerDeviceName) then return false end
    print("Device matched")
    return device["productName"] == usbTriggerDeviceName
end

function usbDeviceCallback( data )
    if (isDevice(data)) then
        setNaturalScrolling(data["eventType"] == "removed")
    end
    setMirroring(true)
end


function setUpScrolling()
    setNaturalScrolling(not hs.fnutils.some(hs.usb.attachedDevices(), isDevice))
end


function setTrigger(result)
    if (not result) then
        usbTriggerDeviceName = "Nothing"
        hs.settings.set(hardwareTriggerSetting, "Nothing")
        return
    end
    hs.settings.set(hardwareTriggerSetting, result.text)
    usbTriggerDeviceName = result.text
    setUpScrolling()
end

function resetTrigger()
    chooser = hs.chooser.new(setTrigger)
    chooser:choices(hs.fnutils.imap(hs.usb.attachedDevices(), function (device)
        if not device.productName then
            return nil
        else
            return {
                ["text"] = device.productName,
                ["subText"] = device.vendorName or ""
            }
        end    
    end))

    chooser:placeholderText("Scroll normally with device")
    chooser:show()
end

function drawTableMenu()
    local isNatural = getScrollDirection() == "natural"
    local dirTitle = (isNatural and "Natural") or "Regular"
    
    return {
        {
            title = "Scroll direction: " .. dirTitle,
            fn = function () setNaturalScrolling(not isNatural) end
        },
        {
            title = '-'
        },
        {
            title = "Watching " .. (usbTriggerDeviceName or "Nothing") .. "…",
            fn = resetTrigger
        }
    }
end

function setUpMenu()
    menu = hs.menubar.new()
    menu:setTitle("🐭")
    menu:setMenu(drawTableMenu)
end

function init()
    usbTriggerDeviceName = hs.settings.get(hardwareTriggerSetting)
    if (not usbTriggerDeviceName) then
        resetTrigger()
    end
    setUpMenu()
    usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
    usbWatcher:start()
end

init()
