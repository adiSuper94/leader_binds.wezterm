local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

---@alias navivagtion_opts { vim: boolean }
---@alias split_opts { vim: boolean? }
---@alias resize_opts { vim: boolean?, pane_resize: number? }
---@alias Opts { split: split_opts?, navigation: navivagtion_opts?, resize: resize_opts? }

---@type Opts
local default_opts = {
  split = { vim = false },
  navigation = { vim = false },
  resize = { vim = false, pane_resize = 5 },
}
local function merge(mod, base)
  for k, v in pairs(base) do
    if type(v) == "table" and type(mod[k]) == "table" then
      merge(mod[k], v)
    elseif mod[k] == nil then
      mod[k] = v
    end
  end
end

---@param config unknown
---@param opts Opts
function M.apply_to_config(config, opts)
  merge(opts or {}, default_opts)
  local resize = opts.resize.pane_resize
  local keys = {
    -- SHIFT | ALT | CTRL
    -- Splitting Panes
    { key = "%",          mods = "LEADER | SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "\"",         mods = "LEADER | SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    -- Resizing Panes
    { key = "LeftArrow",  mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Left", resize }) },
    { key = "DownArrow",  mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Down", resize }) },
    { key = "UpArrow",    mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Up", resize }) },
    { key = "RightArrow", mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Right", resize }) },


    -- SHIFT | CTRL
    -- Navigating Panes
    { key = "LeftArrow",  mods = "LEADER",         action = act.ActivatePaneDirection("Left") },
    { key = "DownArrow",  mods = "LEADER",         action = act.ActivatePaneDirection("Down") },
    { key = "UpArrow",    mods = "LEADER",         action = act.ActivatePaneDirection("Up") },
    { key = "RightArrow", mods = "LEADER",         action = act.ActivatePaneDirection("Right") },

    -- Navigating Tabs
    { key = "Tab",        mods = "LEADER",         action = act.ActivateTabRelative(1) },
    { key = "Tab",        mods = "LEADER | SHIFT", action = act.ActivateTabRelative(-1) },
    { key = "9",          mods = "LEADER",         action = act.ActivateTab(-1) },
    { key = "{",          mods = "LEADER",         action = act.ActivateTabRelative(-1) },
    { key = "}",          mods = "LEADER",         action = act.ActivateTabRelative(1) },

    { key = "r",          mods = "LEADER",         action = act.ReloadConfiguration },
    { key = "t",          mods = "LEADER",         action = act.SpawnTab("CurrentPaneDomain") },
    { key = "w",          mods = "LEADER",         action = act.CloseCurrentPane({ confirm = true }) },
    { key = "z",          mods = "LEADER",         action = act.TogglePaneZoomState },

  }

  for i = 1, 8 do
    table.insert(keys, {
      key = tostring(i),
      mods = "LEADER",
      action = act.ActivateTab(i - 1),
    })
  end
  if opts.navigation.vim then
    table.insert(keys, { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") })
    table.insert(keys, { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") })
    table.insert(keys, { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") })
    table.insert(keys, { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") })
  end

  if opts.split.vim then
    table.insert(keys,
      { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) })
    table.insert(keys,
      { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) })
  end

  if opts.resize.vim then
    table.insert(keys, { key = "h", mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Left", resize }) })
    table.insert(keys, { key = "j", mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Down", resize }) })
    table.insert(keys, { key = "k", mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Up", resize }) })
    table.insert(keys, { key = "l", mods = "LEADER | SHIFT", action = act.AdjustPaneSize({ "Right", resize }) })
  end

  if not config.keys then
    config.keys = {}
  end
  for _, key in ipairs(keys) do
    table.insert(config.keys, key)
  end
end

return M
