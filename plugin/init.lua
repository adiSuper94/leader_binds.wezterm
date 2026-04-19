local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

---@param config unknown
---@param opts { vim_binds: boolean?, pane_navigation: boolean? }
function M.apply_to_config(config, opts)
  local keys = {
    -- Navigating Panes
    { key = "LeftArrow",  mods = "LEADER",         action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "LEADER",         action = act.ActivatePaneDirection("Down") },
    { key = "UpArrow",    mods = "LEADER",         action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow",  mods = "LEADER",         action = act.ActivatePaneDirection("Right") },

    -- Splitting Panes
    { key = "%",          mods = "LEADER | SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "\"",         mods = "LEADER | SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

  }
  if opts and opts.vim_binds then
    table.insert(keys, { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") })
    table.insert(keys, { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") })
    table.insert(keys, { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") })
    table.insert(keys, { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") })
  end

  if opts and opts.pane_navigation then
    for i = 1, 9 do
      table.insert(keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1),
      })
      table.insert(keys, {
        key = tostring(0),
        mods = "LEADER",
        action = act.ActivateTab(9),
      })
    end
  end

  if not config.keys then
    config.keys = {}
  end
  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end

  if not config.key_tables then
    config.key_tables = {}
  end
end

return M
