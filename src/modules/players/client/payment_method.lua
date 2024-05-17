slyyCore.events:new("payment_method:request", function(transaction, action, ...)
    RageUI.CloseAll()
    slyyCore.openRUI({
        main = {
            title = _("PAYMENT_METHOD_TITLE"),
            desc = _("PAYMENT_METHOD_DESC")
        },
        submenus = {},
        actions = {
            ["menu"] = function(submenus)
                RageUI.Separator(_("PAYMENT_METHOD_TRANSAC", transaction.label))
                RageUI.Separator(_("PAYMENT_METHOD_TRANSAC_AMOUNT", slyyCore.utils.groupDigits(transaction.amount)))
                RageUI.Button(_("PAYMENT_METHOD_PAY_WITH", _("CASH"):lower()), nil, _("MENU_ACTION"), true, {
                    onSelected = function()
                        slyyCore.events:server("payment_method:pay", "money", transaction, action, ...)
                    end
                })
                RageUI.Button(_("PAYMENT_METHOD_PAY_WITH", _("BANK"):lower(), nil, _("MENU_ACTION"), true, {
                    onSelected = function()
                        slyyCore.events:server("payment_method:pay", "bank", transaction, action, ...)
                    end
                })
            end
        },
        panels = {},
        closed = function()
            
        end
    })
end)