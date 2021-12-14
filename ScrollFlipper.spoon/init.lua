--- === ScrollFlipper ===
---
--- changes your scroll direction based on the presence or absence of hardware
---
--- Download: [https://github.com/alazoral/ScrollFlipper](https://github.com/alazoral/ScrollFlipper)

local obj={}
obj.__index = obj

-- Metadata
obj.name = "ScrollFlipper"
obj.version = "0.1"
obj.author = "Leon Spencer"
obj.homepage = "https://github.com/alazoral/ScrollFlipper"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- ScrollFlipper.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('ScrollFlipper')

--- ScrollFlipper.kill_list
--- Variable
--- The setting name to store and recall the device name
obj.hardwareTriggerSetting = 'hardware-trigger-name'

--- ScrollFlipper:currySelf()
--- Method
--- A convenience method for wrapping callbacks with self
function obj:currySelf(fn)
    return function(...)
        return fn(self, ...)
    end
end

function obj:setNaturalScrolling(shouldBeNatural)
    local isNatural = hs.mouse.scrollDirection() == "natural"
    if (shouldBeNatural ~= isNatural) then
        hs.osascript.javascript([[
            Application("System Preferences").panes["Trackpad"].reveal()        
            Application("System Events").processes["System Preferences"].windows[0].tabGroups[0].checkboxes[0].click()
        ]])

        hs.notify.show("Scroll direction", "Your scroll direction is now " .. hs.mouse.scrollDirection(), "Enjoy your scrolling experience!")
    end
    hs.osascript.javascript("Application('System Preferences').quit()")
end

function obj:isDevice(device)
    self.logger:d("Testing " .. device["productName"] .. " is " .. self.usbTriggerDeviceName)
    if (not self.usbTriggerDeviceName) then return false end
    self.logger:d("Device matched")
    return device["productName"] == self.usbTriggerDeviceName
end

function obj:usbDeviceCallback( data )
    if (self:isDevice(data)) then
        self:setNaturalScrolling(data["eventType"] == "removed")
    end
end


function obj:setUpScrolling()
    self:setNaturalScrolling(not hs.fnutils.some(hs.usb.attachedDevices(), self:currySelf(self.isDevice)))
end


function obj:setTrigger(result)
    self.logger:d("Setting trigger to " .. hs.inspect.inspect(result))
    if (not result) then
        self.usbTriggerDeviceName = "Nothing"
        hs.settings.set(self.hardwareTriggerSetting, "Nothing")
        return
    end
    self.logger:d("Setting setting " .. self.hardwareTriggerSetting .. " to " .. result.text)
    hs.settings.set(self.hardwareTriggerSetting, result.text)
    self.usbTriggerDeviceName = result.text
    self:setUpScrolling()
end

function obj:resetTrigger()
    self.chooser = hs.chooser.new(self:currySelf(self.setTrigger))
    self.chooser:choices(hs.fnutils.imap(hs.usb.attachedDevices(), function (device)
        if not device.productName then
            return nil
        else
            return {
                ["text"] = device.productName,
                ["subText"] = device.vendorName or ""
            }
        end    
    end))

    self.chooser:placeholderText("Scroll normally with device")
    self.chooser:show()
end

function obj:drawTableMenu()
    local isNatural = hs.mouse.scrollDirection() == "natural"
    local dirTitle = (isNatural and "Natural") or "Regular"
    
    return {
        {
            title = "Scroll direction: " .. dirTitle,
            fn = function () self:setNaturalScrolling(not isNatural) end
        },
        {
            title = '-'
        },
        {
            title = "Watching " .. (self.usbTriggerDeviceName or "Nothing") .. "…",
            fn = self:currySelf(self.resetTrigger)
        }
    }
end

function obj:setUpMenu()
    self.menu = hs.menubar.new()
    self.menu:setTitle("🐭")
    self.drawTableMenuCallback = self:currySelf(self.drawTableMenu)
    self.menu:setMenu(self.drawTableMenuCallback)
end

function obj:init()
    self.usbTriggerDeviceName = hs.settings.get(self.hardwareTriggerSetting)
    if (not self.usbTriggerDeviceName) then
        resetTrigger()
    end
    self:setUpMenu()
end

function obj:start()
    self:stop()
    self.usbWatcher = hs.usb.watcher.new(self:currySelf(self.usbDeviceCallback))
    self.usbWatcher:start()
end

function obj:stop()
    if (self.usbWatcher) then
        self.usbWatcher:stop()
        self.usbWatcher = nil
    end
end

return obj