function Player:sendDamageWindow(config)
    local function buttonCallback(button, choice)
    -- Modal window functionallity
        if button.text == "Confirm" then
            self:setStorageValue(10009, choice.id)
        end
    end
   
-- Modal window design
    local window = ModalWindow {
        title = config.titleMsg, -- Title of the modal window
        message = config.mainMsg, -- The message to be displayed on the modal window
    }
 
    -- Add buttons to the window (Note: if you change the names of these you must change the functions in the modal window functionallity!)
    window:addButton("Confirm", buttonCallback)
    window:addButton("Cancel")
 
    -- Set what button is pressed when the player presses enter or escape
    window:setDefaultEnterButton("Confirm")
    window:setDefaultEscapeButton("Cancel")
 
    -- Add choices from the action script
    for i = 1, #config do
    local o = config[i].element
        window:addChoice(o)
    end
 
    -- Send the window to player
    window:sendToPlayer(self)
end