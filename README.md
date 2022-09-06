# silicon.nvim

Render beautiful image of your code in neovim using [silicon](https://github.com/Aloxaf/silicon).

## Installation

### Requirements

- nvim `v0.7`
- cargo

#### Packer

```lua
use {'krivahtoo/silicon.nvim', run = './install.sh'}
```

#### Vim-Plug

```vim
Plug 'krivahtoo/silicon.nvim', { 'do': './install.sh' }
```

## Usage

```lua
require('silicon').setup({
  font = 'FantasqueSansMono Nerd Font=16',
  theme = 'Monokai Extended',
})
```

Command:

```bash
Silicon [file]
```


The `setup` function accepts the following table:

```lua
{
  -- The following key is required if you want to save image to file instead of clipboard
  output = string
  -- The following keys are all optional
  -- with default values
  font = 'Hack=20',
  theme = 'Dracula',
  background = '#eff',
  shadow = {
    blur_radius = 0.0,
    offset_x = 0,
    offset_y = 0,
    color = '#555'
  },
  pad_horiz = 100,
  pad_vert = 80,
  line_number = false,
  line_pad = 2,
  line_offset = 1,
  tab_width = 4,
  round_corner = true,
  window_controls = true,
}
```

