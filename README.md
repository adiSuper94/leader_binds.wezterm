# Wezterm Leader Bindings

Configure leader key bindings that align with Wezterm's default keybindings.

## Default Bindings

| Keys | Action |
|------|--------|
| `LEADER + <Arrow>` | Navigate panes |
| `LEADER \| SHIFT + "`|  Split vertically |
| `LEADER \| SHIFT + %`|  Split horizontally |

## Configuration

```lua
local wezterm = require("wezterm")
local leader_binds = require("https://gitlab.com/adiSuper94/leader_binds.wezterm")

local config = wezterm.config_builder()
leader_binds.apply_to_config(config, {}) -- You can omit the empty table if you don't want to override any default bindings
return config
```

## Default Options

```lua
{
  navigation = {
    vim = false,           -- Enable vim-style `h/j/k/l` pane navigation
  },
  split = {
    vim = false -- Enable vim-style splits with `v` and `s`
  },
  resize = {
    vim = false,    -- Enable vim-style resize with `H/J/K/L`
    pane_resize = 5 -- Number of cells to resize
  },
}
```



