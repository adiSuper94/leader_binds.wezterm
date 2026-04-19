# Wezterm Leader Bindings

Configure leader key bindings that align with Wezterm's default keybindings.

## Default Bindings

| Keys | Action |
|------|--------|
| `LEADER + <Arrow>` | Navigate panes |
| `LEADER \| + "` | Split vertically |
| `LEADER \| + %` | Split horizontally |
| `LEADER + Tab` | Next tab |
| `LEADER + SHIFT + Tab` | Previous tab |
| `LEADER + 1-8` | Switch to tab 1-8 |
| `LEADER + 9` | Switch to last tab |
| `LEADER + {` / `}` | Previous / Next tab |
| `LEADER + r` | Reload configuration |
| `LEADER + t` | New tab |
| `LEADER + w` | Close pane |
| `LEADER + z` | Toggle pane zoom |
| `LEADER + v` | Open vertical split (optional)|
| `LEADER + s` | Open horizontal split (optional)|
| `LEADER + h/j/k/l` | Navigate panes (optional)|

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
    vim = false,  -- Enable vim-style `h/j/k/l` pane navigation
  },
  split = {
    vim = false   -- Enable vim-style splits with `v` and `s`
  }
}
```



