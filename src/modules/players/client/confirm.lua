slyyCore.events:new("confirm", function(action, cb)    
    slyyCore.closeRUI()
    slyyCore.openRUI({
        main = {
            title = _("CONFIRM_ACTION_TITLE"),
            desc = _("CONFIRM_ACTION_DESC")
        },
        notClosable = {"main"},
        submenus = {},
        actions = {
            ["menu"] = function(submenus)
                RageUI.Separator(_("CONFIRM_ACTION_SEPARATOR", action))
                RageUI.Button(_("YES"), nil, {RightLabel = _("MENU_ACTION")}, true, {
                    onSelected = function()
                        cb()
                        RageUI.CloseAll()
                    end
                })
                RageUI.Button(_("NO"), nil, {RightLabel = _("MENU_ACTION")}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                    end
                })
            end
        },
        panels = {},
        closed = function()
            
        end
    })
end)
