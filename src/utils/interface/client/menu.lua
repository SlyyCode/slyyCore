local function allMenusClosed(menu, submenus)
    if not RageUI.Visible(menu) then
        for _, submenu in pairs(submenus) do
            if RageUI.Visible(submenu) then
                return false
            end
        end
        return true
    end
    return false
end

slyyCore.openRUI = function(data, checkCoords)
    local menu = RageUI.CreateMenu(data.main.title, data.main.desc)
    local submenus = {}

    for k,v in pairs(data.submenus) do 
        submenus[k] = RageUI.CreateSubMenu(menu, v.title, v.desc)
    end
    RageUI.Visible(menu, not RageUI.Visible(menu))
    slyyCore.inMenu = true

    while menu do
        if checkCoords ~= nil and #(GetEntityCoords(slyyCore.pPed) - checkCoords.coords) > checkCoords.dist and slyyCore.inMenu then 
            slyyCore.utils.notification(_("TOO_FAR_AWAY"))
            RageUI.CloseAll()
        end
        Wait(1)
        
        RageUI.IsVisible(menu, function()
            data.actions["menu"](submenus)
        end, function()
        end)

        if #submenus > 0 then
            for k,v in pairs(submenus) do 
                RageUI.IsVisible(v, function()
                    data.actions[k](submenus)
                end, function()
                end)
            end
        end

        if allMenusClosed(menu, submenus) then 
            for k, submenu in pairs(submenus) do
                submenus[k] = RMenu:DeleteType("menu", true)
            end
            menu = RMenu:DeleteType("menu", true)

            slyyCore.inMenu = false
            data.closed()
        end
    end
end