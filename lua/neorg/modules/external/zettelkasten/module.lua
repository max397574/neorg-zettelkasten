require("neorg.modules.base")
require("neorg.modules")

local module = neorg.modules.create("external.zettelkasten")
local log = require("neorg.external.log")

module.setup = function()
    return {
        success = true,
        requires = {
            "core.norg.dirman",
            "core.keybinds",
            "core.neorgcmd",
            "core.mode",
        },
    }
end

module.private = {
    workspace_path = "",
    ---Creates a new Zettel
    ---@param mode string Where to open backlinks: split, float
    zettel_backlinks = function(mode)
        if mode == "split" then
            log.info("Opened Backlinks in split")
        elseif mode == "float" then
            log.info("Opened Backlinks in float")
        end
    end,
    new_zettel = function()
        local workspace = module.config.public.workspace
        module.required["core.norg.dirman"].create_file("my zettel.norg", workspace)
    end,
    explore_zettel = function() end,
}

module.config.public = {
    -- which workspace to use for the zettelkasten
    workspace = nil,
}

module.load = function()
    local workspace = module.config.public.workspace
    module.private.workspace_path = module.required["core.norg.dirman"].get_workspace(workspace)

    module.required["core.neorgcmd"].add_commands_from_table({
        definitions = {
            zettel = {
                new = {},
                explore = {},
                backlinks = {},
            },
        },
        data = {
            zettel = {
                min_args = 1,
                max_args = 2,
                subcommands = {
                    new = { args = 0, name = "zettel.new" },
                    explore = { args = 0, name = "zettel.explore" },
                    backlinks = { args = 1, name = "zettel.backlinks" },
                },
            },
        },
    })
end

module.on_event = function(event)
    if vim.tbl_contains({ "core.keybinds", "core.neorgcmd" }, event.split_type[1]) then
        if event.split_type[2] == "zettel.new" then
            module.private.new_zettel()
        elseif event.split_type[2] == "zettel.explore" then
            module.private.explore_zettel()
        elseif event.split_type[2] == "zettel.backlinks" then
            module.private.zettel_backlinks(event.content[1])
        end
    end
end

module.events.subscribed = {
    ["core.neorgcmd"] = {
        ["zettel.new"] = true,
        ["zettel.explore"] = true,
        ["zettel.backlinks"] = true,
    },
}

return module
