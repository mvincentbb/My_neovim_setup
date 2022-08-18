*nvim-tree.lua* A File Explorer For Neovim Written In Lua

Author: Yazdani Kiyan <yazdani.kiyan@protonmail.com>

==============================================================================
CONTENTS                                                           *nvim-tree*

  1. Introduction                             |nvim-tree-introduction|
  2. Quickstart                               |nvim-tree-quickstart|
  3. Commands                                 |nvim-tree-commands|
  4. Setup/Configuration                      |nvim-tree-setup|
  4.1 Vinegar Style                           |nvim-tree-vinegar|
  5. Api                                      |nvim-tree-api|
  6. Mappings                                 |nvim-tree-mappings|
  7. Highlight Groups                         |nvim-tree-highlight|
  8. Events                                   |nvim-tree-events|
  9. Bookmarks                                |nvim-tree-bookmarks|

==============================================================================
 1. INTRODUCTION                                      *nvim-tree-introduction*

Features

    - Automatic updates
    - File type icons
    - Git integration
    - Diagnostics integration: LSP and COC
    - (Live) filtering
    - Cut, copy, paste, rename, delete, create
    - Highly customisable

File Icons

    https://github.com/kyazdani42/nvim-web-devicons is optional and used to display file icons. It requires a patched font: https://www.nerdfonts.com

     should look like an open folder.

    To disable the display of icons see |renderer.icons.show|

Colours

    Syntax highlighting uses g:terminal_color_ from colorschemes, falls back to
    ugly colors otherwise.

Git Integration

    Icon indicates when a file is:
    - ✗  unstaged or folder is dirty
    - ✓  staged
    - ★  new file
    - ✓ ✗ partially staged
    - ✓ ★ new file staged
    - ✓ ★ ✗ new file staged and has unstaged modifications
    - ═  merging
    - ➜  renamed

Requirements

    This file explorer requires `neovim >= 0.7.0`

==============================================================================
 2. QUICK START                                         *nvim-tree-quickstart*

Setup should be run in a lua file or in a |lua-heredoc| if using in a vim file.

    -- examples for your init.lua

    -- empty setup using defaults
    require("nvim-tree").setup()

    -- OR setup with some options
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        adaptive_size = true,
        mappings = {
          list = {
            { key = "u", action = "dir_up" },
          },
        },
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
<
==============================================================================
 3. COMMANDS                                              *nvim-tree-commands*

|:NvimTreeOpen|

    opens the tree. Takes an optional path argument.

|:NvimTreeClose|

    closes the tree

|:NvimTreeToggle|

    open or close the tree. Takes an optional path argument.

|:NvimTreeFocus|

    open the tree if it is closed, and then focus on the tree

|:NvimTreeRefresh|

    refresh the tree

|:NvimTreeFindFile|

    The command will change the cursor in the tree for the current bufname.

    It will also open the leafs of the tree leading to the file in the buffer
    (if you opened a file with something else than the NvimTree, like `fzf` or
    `:split`)

|:NvimTreeFindFileToggle|

    close the tree or change the cursor in the tree for the current bufname,
    similar to combination of |:NvimTreeToggle| and |:NvimTreeFindFile|. Takes an
    optional path argument.

|:NvimTreeClipboard|

    Print clipboard content for both cut and copy

|:NvimTreeResize|

    Resize the NvimTree window to the given size. Example: `:NvimTreeResize 50`
    resizes the window to the width of 50. If the size starts with "+" or "-" it
    adds or removes the given value to the current window width.
    Example `:NvimTreeResize -20` removes the value 20 from the current width. And
    `:NvimTreeResize +20` adds the value 20 to the current width.

|:NvimTreeCollapse|

    Collapses the nvim-tree recursively.

|:NvimTreeCollapseKeepBuffers|

    Collapses the nvim-tree recursively, but keep the directories open, which are
    used in an open buffer.


==============================================================================
 4. SETUP                                                    *nvim-tree-setup*

You must run setup() function to initialise nvim-tree.

setup() function takes one optional argument: configuration table. If omitted
nvim-tree will be initialised with default configuration.

Subsequent calls to setup will replace the previous configuration.
>
    require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      ignore_buffer_on_setup = false,
      open_on_setup = false,
      open_on_setup_file = false,
      open_on_tab = false,
      ignore_buf_on_tab_change = {},
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = "disable", -- function(bufnr). If nil, will use the deprecated mapping strategy
      remove_keymaps = false, -- boolean (disable totally or not) or list of key (lhs)
      view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        -- @deprecated
        mappings = {
          custom_only = false,
          list = {
            -- user mappings go here
          },
        },
        float = {
          enable = false,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      ignore_ft_on_setup = {},
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        debounce_delay = 50,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    } -- END_DEFAULT_OPTS
<

Here is a list of the options available in the setup call:

*nvim-tree.disable_netrw*
Completely disable netrw
  Type: `boolean`, Default: `false`

*nvim-tree.hijack_netrw*
Hijack netrw windows (overridden if |disable_netrw| is `true`)
  Type: `boolean`, Default: `true`

*nvim-tree.open_on_setup*
Will automatically open the tree when running setup if startup buffer is
a directory, is empty or is unnamed. nvim-tree window will be focused.
  Type: `boolean`, Default: `false`

*nvim-tree.open_on_setup_file*
Will automatically open the tree when running setup if startup buffer is a file.
File window will be focused.
File will be found if update_focused_file is enabled.
  Type: `boolean`, Default: `false`

*nvim-tree.ignore_buffer_on_setup*
Will ignore the buffer, when deciding to open the tree on setup.
  Type: `boolean`, Default: `false`

*nvim-tree.ignore_ft_on_setup*
List of filetypes that will prevent `open_on_setup` to open.
You can use this option if you don't want the tree to open
in some scenarios (eg using vim startify).
  Type: {string}, Default: `{}`

*nvim-tree.ignore_buf_on_tab_change*
List of filetypes or buffer names that will prevent `open_on_tab` to open.
  Type: {string}, Default: `{}`

*nvim-tree.auto_reload_on_write*
Reloads the explorer every time a buffer is written to.
  Type: `boolean`, Default: `true`

*nvim-tree.create_in_closed_folder*
Creating a file when the cursor is on a closed folder will set the
path to be inside the closed folder, otherwise the parent folder.
  Type: `boolean`, Default: `false`

*nvim-tree.open_on_tab*
Opens the tree automatically when switching tabpage or opening a new tabpage
if the tree was previously open.
  Type: `boolean`, Default: `false`

*nvim-tree.sort_by*
Changes how files within the same directory are sorted.
Can be one of 'name', 'case_sensitive', 'modification_time' or 'extension'.
  Type: `string`, Default: `"name"`

*nvim-tree.hijack_unnamed_buffer_when_opening*
Opens in place of the unnamed buffer if it's empty.
  Type: `boolean`, Default: `false`

*nvim-tree.hijack_cursor*
Keeps the cursor on the first letter of the filename when moving in the tree.
  Type: `boolean`, Default: `false`

*nvim-tree.root_dirs*
Preferred root directories.
Only relevant when `update_focused_file.update_root` is `true`
  Type: `{string}`, Default: `{}`

*nvim-tree.prefer_startup_root*
Prefer startup root directory when updating root directory of the tree.
Only relevant when `update_focused_file.update_root` is `true`
  Type: `boolean`, Default: `false`

*nvim-tree.sync_root_with_cwd*  (previously `update_cwd`)
Changes the tree root directory on `DirChanged` and refreshes the tree.
  Type: `boolean`, Default: `false`

*nvim-tree.reload_on_bufenter*
Automatically reloads the tree on `BufEnter` nvim-tree.
  Type: `boolean`, Default: `false`

*nvim-tree.respect_buf_cwd*
Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
  Type: `boolean`, Default: `false`

*nvim-tree.hijack_directories*  (previously `update_to_buf_dir`)
hijacks new directory buffers when they are opened (`:e dir`).

    *nvim-tree.hijack_directories.enable*
    Enable the feature.
    Disable this option if you use vim-dirvish or dirbuf.nvim.
    If `hijack_netrw` and `disable_netrw` are `false`, this feature will be disabled.
      Type: `boolean`, Default: `true`

    *nvim-tree.hijack_directories.auto_open*
    Opens the tree if the tree was previously closed.
      Type: `boolean`, Default: `true`

*nvim-tree.update_focused_file*
Update the focused file on `BufEnter`, un-collapses the folders recursively
until it finds the file.

    *nvim-tree.update_focused_file.enable*
    Enable this feature.
      Type: `boolean`, Default: `false`

    *nvim-tree.update_focused_file.update_root*  (previously `update_focused_file.update_cwd`)
    Update the root directory of the tree if the file is not under current
    root directory. It prefers vim's cwd and `root_dirs`.
    Otherwise it falls back to the folder containing the file.
    Only relevant when `update_focused_file.enable` is `true`
      Type: `boolean`, Default: `false`

    *nvim-tree.update_focused_file.ignore_list*
    List of buffer names and filetypes that will not update the root dir
    of the tree if the file isn't found under the current root directory.
    Only relevant when `update_focused_file.update_root` and
    `update_focused_file.enable` are `true`.
      Type: {string}, Default: `{}`

*nvim-tree.system_open*
Configuration options for the system open command.

    *nvim-tree.system_open.cmd*
    The command to run, leaving empty should work but useful if you want to
    override the default command with another one.
      Type: `string`, Default: `""`

    *nvim-tree.system_open.args*
    The command arguments as a list.
      Type: {string}, Default: `{}`

*nvim-tree.diagnostics*
Show LSP and COC diagnostics in the signcolumn

    *nvim-tree.diagnostics.enable*
    Enable/disable the feature.
      Type: `boolean`, Default: `false`

    *nvim-tree.diagnostics.debounce_delay*
    Idle milliseconds between diagnostic event and update.
      Type: `number`, Default: `50` (ms)

    *nvim-tree.diagnostics.show_on_dirs*
    Show diagnostic icons on parent directories.
      Type: `boolean`, Default: `false`

    *nvim-tree.diagnostics.icons*
    Icons for diagnostic severity.
      Type: `table`, Default: `{ hint = "", info = "", warning = "", error = "" }`

    `NOTE`: it will use the default diagnostic color groups to highlight the signs.
    If you wish to customize, you can override these groups:
    - `NvimTreeLspDiagnosticsError`
    - `NvimTreeLspDiagnosticsWarning`
    - `NvimTreeLspDiagnosticsInformation`
    - `NvimTreeLspDiagnosticsHint`

*nvim-tree.git*
Git integration with icons and colors.

    *nvim-tree.git.enable*
    Enable / disable the feature.
      Type: `boolean`, Default: `true`

    *nvim-tree.git.ignore*
    Ignore files based on `.gitignore`. Requires |git.enable| `= true`
    Toggle via the `toggle_git_ignored` action, default mapping `I`.
      Type: `boolean`, Default: `true`

    *nvim-tree.git.show_on_dirs*
    Show status icons of children when directory itself has no status icon.
      Type: `boolean`, Default: `true`

    *nvim-tree.git.timeout*
    Kills the git process after some time if it takes too long.
      Type: `number`, Default: `400` (ms)

  You will still need to set |renderer.icons.show.git| `= true` or
  |renderer.highlight_git| `= true` to be able to see things in the
  tree. This will be changed in the future versions.

  The configurable timeout will kill the current process and so disable the
  git integration for the project that takes too long.
  The git integration is blocking, so if your timeout is too long (like not in
  milliseconds but a few seconds), it will not render anything until the git
  process returned the data.

*nvim-tree.filesystem_watchers*
Will use file system watcher (libuv fs_event) to watch the filesystem for
changes.
Using this will disable BufEnter / BufWritePost events in nvim-tree which
were used to update the whole tree. With this feature, the tree will be
updated only for the appropriate folder change, resulting in better
performance.

    *nvim-tree.filesystem_watchers.enable*
    Enable / disable the feature.
      Type: `boolean`, Default: `true`

    *nvim-tree.filesystem_watchers.debounce_delay*
    Idle milliseconds between filesystem change and action.
      Type: `number`, Default: `50` (ms)

*nvim-tree.on_attach*
Function ran when creating the nvim-tree buffer.
This can be used to attach keybindings to the tree buffer.
When on_attach is "disabled", it will use the older mapping strategy, otherwise it
will use the newer one.
>
    on_attach = function(bufnr)
        local inject_node = require("nvim-tree.utils").inject_node

        vim.keymap.set("n", "<leader>n", inject_node(function(node)
            if node then
                print(node.absolute_path)
            end
        end), { buffer = bufnr, noremap = true })

        vim.bo[bufnr].path = "/tmp"
    end
<
    Type: `function(bufnr)`, Default: `"disable"`

*nvim-tree.remove_keymaps*
This can be used to remove the default mappings in the tree.
- Remove specific keys by passing a `string` table of keys
    eg. {"<C-o>", "<CR>", "o", "<Tab>"}
- Remove all default mappings by passing `true`
- Ignore by passing `false`
    Type: `bool` or `{string}`, Default: `false`

*nvim-tree.view*
Window / buffer setup.

    *nvim-tree.view.adaptive_size*
    Resize the window on each draw based on the longest line.
    Only works when |nvim-tree.view.side| is `left` or `right`.
      Type: `boolean`, Default: `false`

    *nvim-tree.view.centralize_selection*
    When entering nvim-tree, reposition the view so that the current node is
    initially centralized, see |zz|.
      Type: `boolean`, Default: `false`

    *nvim-tree.view.hide_root_folder*
    Hide the path of the current working directory on top of the tree.
      Type: `boolean`, Default: `false`

    *nvim-tree.view.width*
    Width of the window, can be a `%` string, a number representing columns or
    a function.
    Only works with `side` is `left` or `right`.
      Type: `string | number | function`, Default: `30`

    *nvim-tree.view.height*
    Height of the window, can be `%` string or a number representing rows or a
    function.
    Only works with  `side` is `top` or `bottom`
      Type: `string | number | function`, Default: `30`

    *nvim-tree.view.side*
    Side of the tree, can be `"left"`, `"right"`, `"bottom"`, `"top"`.
    Note that bottom/top are not working correctly yet.
      Type: `string`, Default: `"left"`

    *nvim-tree.view.preserve_window_proportions*
    Preserves window proportions when opening a file.
    If `false`, the height and width of windows other than nvim-tree will be equalized.
      Type: `boolean`, Default: `false`

    *nvim-tree.view.number*
    Print the line number in front of each line.
      Type: `boolean`, Default: `false`

    *nvim-tree.view.relativenumber*
    Show the line number relative to the line with the cursor in front of each line.
    If the option `view.number` is also `true`, the number on the cursor line
    will be the line number instead of `0`.
      Type: `boolean`, Default: `false`

    *nvim-tree.view.signcolumn*
    Show diagnostic sign column. Value can be `"yes"`, `"auto"`, `"no"`.
      Type: `string`, Default: `"yes"`

    *nvim-tree.view.mappings*
    Configuration options for |nvim-tree-mappings|

        *nvim-tree.view.mappings.custom_only*
        Will use only the provided user mappings and not the default otherwise,
        extends the default mappings with the provided user mappings.
          Type: `boolean`, Default: `false`

        *nvim-tree.view.mappings.list*
        A list of keymaps that will extend or override the default keymaps.
          Type: `table`
          Default: see |nvim-tree-default-mappings|

    *nvim-tree.view.float*
    Configuration options for floating window

        *nvim-tree.view.float.enable*
        Display nvim-tree window as float (enforces |nvim-tree.actions.open_file.quit_on_open| if set).
          Type: `boolean`, Default: `false`

        *nvim-tree.view.float.open_win_config*
        Floating window config. See |nvim_open_win| for more details.
          Type: `table`, Default:
            `{`
              `relative = "editor",`
              `border = "rounded",`
              `width = 30,`
              `height = 30,`
              `row = 1,`
              `col = 1,`
            `}`

*nvim-tree.renderer*
UI rendering setup

    *nvim-tree.renderer.add_trailing*
    Appends a trailing slash to folder names.
      Type: `boolean`, Default: `false`

    *nvim-tree.renderer.group_empty*
    Compact folders that only contain a single folder into one node in the file tree.
      Type: `boolean`, Default: `false`

    *nvim-tree.renderer.full_name*
    Display node whose name length is wider than the width of nvim-tree window in floating window.
      Type: `boolean`, Default: `false`

    *nvim-tree.renderer.highlight_git*
    Enable file highlight for git attributes using `NvimTreeGit*` highlight groups.
    This can be used with or without the icons.
      Type: `boolean`, Default: `false`

    *nvim-tree.renderer.highlight_opened_files*
    Highlight icons and/or names for opened files.
    Value can be `"none"`, `"icon"`, `"name"` or `"all"`.
      Type: `string`, Default: `"none"`

    *nvim-tree.renderer.root_folder_modifier*
    In what format to show root folder. See `:help filename-modifiers` for
    available options.
      Type: `string`, Default: `":~"`

    *nvim-tree.renderer.indent_markers*
    Configuration options for tree indent markers.

        *nvim-tree.renderer.indent_markers.enable*
        Display indent markers when folders are open
          Type: `boolean`, Default: `false`

        *nvim-tree.renderer.indent_markers.inline_arrows*
        Display folder arrows in the same column as indent marker
        when using |renderer.icons.show.folder_arrow|
          Type: `boolean`, Default: `true`

        *nvim-tree.renderer.indent_markers.icons*
        Icons shown before the file/directory.
          Type: `table`, Default: `{ corner = "└", edge = "│", item = "│", none = " ", }`

    *nvim-tree.renderer.icons*
    Configuration options for icons.

        *nvim-tree.renderer.icons.webdev_colors*
        Use the webdev icon colors, otherwise `NvimTreeFileIcon`.
          Type: `boolean`, Default: `true`

        *nvim-tree.renderer.icons.git_placement*
        Place where the git icons will be rendered.
        Can be `"after"` or `"before"` filename (after the file/folders icons)
        or `"signcolumn"` (requires |nvim-tree.view.signcolumn| enabled).
        Note that the diagnostic signs will take precedence over the git signs.
          Type: `string`, Default: `before`

        *nvim-tree.renderer.icons.padding*
        Inserted between icon and filename.
        Use with caution, it could break rendering if you set an empty string depending on your font.
          Type: `string`, Default: `" "`

        *nvim-tree.renderer.icons.symlink_arrow*
        Used as a separator between symlinks' source and target.
          Type: `string`, Default: `" ➛ "`

        *nvim-tree.renderer.icons.show*
        Configuration options for showing icon types.

            *nvim-tree.renderer.icons.show.file*
            Show an icon before the file name. `nvim-web-devicons` will be used if available.
              Type: `boolean`, Default: `true`

            *nvim-tree.renderer.icons.show.folder*
            Show an icon before the folder name.
              Type: `boolean`, Default: `true`

            *nvim-tree.renderer.icons.show.folder_arrow*
            Show a small arrow before the folder node. Arrow will be a part of the
            node when using |renderer.indent_markers|.
              Type: `boolean`, Default: `true`

            *nvim-tree.renderer.icons.show.git*
            Show a git status icon, see |renderer.icons.git_placement|
            Requires |git.enable| `= true`
              Type: `boolean`, Default: `true`

        *nvim-tree.renderer.icons.glyphs*
        Configuration options for icon glyphs.

            *nvim-tree.renderer.icons.glyphs.default*
            Glyph for files. Will be overridden by `nvim-web-devicons` if available.
              Type: `string`, Default: `""`

            *nvim-tree.renderer.icons.glyphs.symlink*
            Glyph for symlinks to files.
              Type: `string`, Default: `""`

            *nvim-tree.renderer.icons.glyphs.folder*
            Glyphs for directories.
              Type: `table`, Default:
                `{`
                  `arrow_closed = "",`
                  `arrow_open = "",`
                  `default = "",`
                  `open = "",`
                  `empty = "",`
                  `empty_open = "",`
                  `symlink = "",`
                  `symlink_open = "",`
                `}`

            *nvim-tree.renderer.icons.glyphs.git*
            Glyphs for git status.
              Type: `table`, Default:
                `{`
                  `unstaged = "✗",`
                  `staged = "✓",`
                  `unmerged = "",`
                  `renamed = "➜",`
                  `untracked = "★",`
                  `deleted = "",`
                  `ignored = "◌",`
                `}`

    *nvim-tree.renderer.special_files*
    A list of filenames that gets highlighted with `NvimTreeSpecialFile`.
      Type: `table`, Default: `{ "Cargo.toml", "Makefile", "README.md", "readme.md", }`

    *nvim-tree.renderer.symlink_destination*
    Whether to show the destination of the symlink.
      Type: `boolean`, Default: `true`

*nvim-tree.filters*
Filtering options.

    *nvim-tree.filters.dotfiles*
    Do not show dotfiles: files starting with a `.`
    Toggle via the `toggle_dotfiles` action, default mapping `H`.
      Type: `boolean`, Default: `false`

    *nvim-tree.filters.custom*
    Custom list of vim regex for file/directory names that will not be shown.
    Backslashes must be escaped e.g. "^\\.git". See |string-match|.
    Toggle via the `toggle_custom` action, default mapping `U`.
      Type: {string}, Default: `{}`

    *nvim-tree.filters.exclude*
    List of directories or files to exclude from filtering: always show them.
    Overrides `git.ignore`, `filters.dotfiles` and `filters.custom`.
      Type: {string}, Default: `{}`

*nvim-tree.trash*
Configuration options for trashing.

    *nvim-tree.trash.cmd*
    The command used to trash items (must be installed on your system).
    The default is shipped with glib2 which is a common linux package.
      Type: `string`, Default: `"gio trash"`

    *nvim-tree.trash.require_confirm*
    Show a prompt before trashing takes place.
      Type: `boolean`, Default: `true`

*nvim-tree.actions*
Configuration for various actions.

    *nvim-tree.actions.change_dir*
    vim |current-directory| behaviour.

        *nvim-tree.actions.change_dir.enable*
        Change the working directory when changing directories in the tree.
          Type: `boolean`, Default: `true`

        *nvim-tree.actions.change_dir.global*
        Use `:cd` instead of `:lcd` when changing directories.
        Consider that this might cause issues with the |nvim-tree.sync_root_with_cwd| option.
          Type: `boolean`, Default: `false`

        *nvim-tree.actions.change_dir.restrict_above_cwd*
        Restrict changing to a directory above the global current working directory.
          Type: `boolean`, Default: `false`

    *nvim-tree.actions.expand_all*
    Configuration for expand_all behaviour.

        *nvim-tree.actions.expand_all.max_folder_discovery*
        Limit the number of folders being explored when expanding every folders.
        Avoids hanging neovim when running this action on very large folders.
          Type: `number`, Default: `300`

        *nvim-tree.actions.expand_all.exclude*
        A list of directories that should not be expanded automatically.
        E.g `{ ".git", "target", "build" }` etc.
          Type: `table`, Default: `{}`

    *nvim-tree.actions.file_popup*
    Configuration for file_popup behaviour.

        *nvim-tree.actions.file_popup.open_win_config*
        Floating window config for file_popup. See |nvim_open_win| for more details.
        You shouldn't define `"width"` and `"height"` values here. They will be
        overridden to fit the file_popup content.
          Type: `table`, Default:
            `{`
              `col = 1,`
              `row = 1,`
              `relative = "cursor",`
              `border = "shadow",`
              `style = "minimal",`
            `}`

    *nvim-tree.actions.open_file*
    Configuration options for opening a file from nvim-tree.

        *nvim-tree.actions.open_file.quit_on_open*
        Closes the explorer when opening a file.
        It will also disable preventing a buffer overriding the tree.
          Type: `boolean`, Default: `false`

        *nvim-tree.actions.open_file.resize_window*  (previously `view.auto_resize`)
        Resizes the tree when opening a file.
          Type: `boolean`, Default: `true`

        *nvim-tree.actions.open_file.window_picker*
        Window picker configuration.

            *nvim-tree.actions.open_file.window_picker.enable*
            Enable the feature. If the feature is not enabled, files will open in window
            from which you last opened the tree.
              Type: `boolean`, Default: `true`

            *nvim-tree.actions.open_file.window_picker.chars*
            A string of chars used as identifiers by the window picker.
              Type: `string`, Default: `"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"`

            *nvim-tree.actions.open_file.window_picker.exclude*
            Table of buffer option names mapped to a list of option values that indicates
            to the picker that the buffer's window should not be selectable.
              Type: `table`
              Default:
                `{`
                  `filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },`
                  `buftype  = { "nofile", "terminal", "help", }`
                `}`

    *nvim-tree.actions.remove_file.close_window*
    Close any window displaying a file when removing the file from the tree.
      Type: `boolean`, Default: `true`

    *nvim-tree.actions.use_system_clipboard*
    A boolean value that toggle the use of system clipboard when copy/paste
    function are invoked. When enabled, copied text will be stored in registers
    '+' (system), otherwise, it will be stored in '1' and '"'.
      Type: `boolean`, Default: `true`

*nvim-tree.live_filter*
Configurations for the live_filtering feature.
The live filter allows you to filter the tree nodes dynamically, based on
regex matching (see |vim.regex|).
This feature is bound to the `f` key by default.
The filter can be cleared with the `F` key by default.

    *nvim-tree.live_filter.prefix*
    Prefix of the filter displayed in the buffer.
      Type: `string`, Default: `"[FILTER]: "`

    *nvim-tree.live_filter.always_show_folders*
    Whether to filter folders or not.
      Type: `boolean`, Default: `true`

*nvim-tree.log*
Configuration for diagnostic logging.

    *nvim-tree.log.enable*
    Enable logging to a file `$XDG_CACHE_HOME/nvim/nvim-tree.log`
      Type: `boolean`, Default: `false`

    *nvim-tree.log.truncate*
    Remove existing log file at startup.
      Type: `boolean`, Default: `false`

    *nvim-tree.log.types*
    Specify which information to log.

        *nvim-tree.log.types.all*
        Everything.
          Type: `boolean`, Default: `false`

        *nvim-tree.log.types.profile*
        Timing of some operations.
          Type: `boolean`, Default: `false`

        *nvim-tree.log.types.config*
        Options and mappings, at startup.
          Type: `boolean`, Default: `false`

        *nvim-tree.log.types.copy_paste*
        File copy and paste actions.
          Type: `boolean`, Default: `false`

        *nvim-tree.log.types.dev*
        Used for local development only. Not useful for users.
          Type: `boolean`, Default: `false`

        *nvim-tree.log.types.diagnostics*
        LSP and COC processing, verbose.
          Type: `boolean`, Default: `false`

        *nvim-tree.log.types.git*
        Git processing, verbose.
          Type: `boolean`, Default: `false`

        *nvim-tree.log.types.watcher*
        |nvim-tree.filesystem_watchers| processing, verbose.
          Type: `boolean`, Default: `false`

==============================================================================
 4.1 VINEGAR STYLE                                         *nvim-tree-vinegar*

|nvim_tree_vinegar|                                    *nvim_tree_vinegar*

nvim-tree can behave like vinegar. To allow this, you will need to configure
it in a specific way:

- Use `require"nvim-tree".open_replacing_current_buffer()` instead of the
default open command.
You can easily implement a toggle using this too:
>
    local function toggle_replace()
      local view = require"nvim-tree.view"
      if view.is_visible() then
        view.close()
      else
        require"nvim-tree".open_replacing_current_buffer()
      end
    end
<
- Use the `edit_in_place` action to edit files. It's bound to `<C-e>` by
default, vinegar uses `<CR>`. You can override this with:
>
    require"nvim-tree".setup {
      view = {
        mappings = {
          list = {
            { key = "<CR>", action = "edit_in_place" }
          }
        }
      }
    }
<
Going up a dir is bound to `-` by default in nvim-tree which is identical to
vinegar, no change is needed here.

You'll also need to set |nvim-tree.hijack_netrw| to `true` during setup.
A good functionality to enable is |nvim-tree.hijack_directories|.

==============================================================================
 5. API                                                   *nvim-tree-api*

Nvim-tree's public API can be used to access features.
>
    local nt_api = require("nvim-tree.api")

    nt_api.tree.toggle()
<
This module exposes stable functionalities, it is advised to use this in order
to avoid breaking configurations due to internal breaking changes.

The api is separated in multiple modules, which can be accessed with
`require("nvim-tree.api").moduleName.functionality`.

Functions that needs a tree node parameter are exposed with an abstraction
that injects the node from the cursor position in the tree when calling
the function. It will use the node you pass as an argument in priority if it
exists.

- api.tree:                                             *nvim-tree.api.tree*
    - open `(path?: string)`
    - close
    - toggle `(find_file?: bool, no_focus?: bool, path?: string)`
    - focus
    - reload
    - change_root `(path: string)`
    - change_root_to_node
    - change_root_to_parent
    - get_node_under_cursor
    - find_file `(filename: string)`
    - search_node
    - collapse_all `(keep_buffers?: bool)`
    - expand_all
    - toggle_gitignore_filter
    - toggle_custom_filter
    - toggle_hidden_filter
    - toggle_help

- api.fs:                                               *nvim-tree.api.fs*
    - create
    - remove
    - trash
    - rename
    - rename_sub
    - cut
    - paste
    - print_clipboard
    - copy.node
    - copy.absolute_path
    - copy.filename
    - copy.relative_path

- api.node:                                             *nvim-tree.api.node*
    - open.edit
    - open.replace_tree_buffer
    - open.no_window_picker
    - open.vertical
    - open.horizontal
    - open.tab
    - open.preview
    - show_info_popup
    - run.cmd
    - run.system
    - navigate.sibling.next
    - navigate.sibling.prev
    - navigate.sibling.first
    - navigate.sibling.last
    - navigate.parent
    - navigate.parent_close
    - navigate.git.next
    - navigate.git.prev
    - navigate.diagnostics.next
    - navigate.diagnostics.prev

- api.git:                                              *nvim-tree.api.git*
    - reload

- api.events:                                           *nvim-tree.api.events*
    - subscribe `(eventType: Event, callback: function(...args))`
    - Event (enum type, please see |nvim_tree_events_kind|)

- api.live_filter:                                      *nvim-tree.api.live_filter*
    - start
    - clear

- api.marks:                                            *nvim-tree.api.marks*
    - get
    - list
    - toggle
    - bulk.move
    - navigate.next
    - navigate.prev
    - navigate.select

==============================================================================
 6. MAPPINGS                                              *nvim-tree-mappings*

Setting your own mapping in the configuration will soon be deprecated, see |nvim-tree.on_attach| for experimental replacement.

The `list` option in `view.mappings.list` is a table of

- `key` can be either a string or a table of string (lhs)
- `action` is the name of the action, set to `""` to remove default action
- `action_cb` is the function that will be called, it receives the node as a parameter. Optional for default actions
- `mode` is normal by default
>
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback

  local function print_node_path(node) {
    print(node.absolute_path)
  }

  local list = {
    { key = {"<CR>", "o" }, action = "edit", mode = "n"},
    { key = "p", action = "print_path", action_cb = print_node_path },
    { key = "s", cb = tree_cb("vsplit") }, --tree_cb and the cb property are deprecated
    { key = "<2-RightMouse>", action = "" }, -- will remove default cd action
  }
<
Mouse support defined in |KeyBindings|

DEFAULT MAPPINGS                                     *nvim-tree-default-mappings*

`<CR>`            edit                open a file or folder; root will cd to the above directory
`o`
`<2-LeftMouse>`
`<C-e>`           edit_in_place       edit the file in place, effectively replacing the tree explorer
`O`               edit_no_picker      same as (edit) with no window picker
`<C-]>`           cd                  cd in the directory under the cursor
`<2-RightMouse>`
`<C-v>`           vsplit              open the file in a vertical split
`<C-x>`           split               open the file in a horizontal split
`<C-t>`           tabnew              open the file in a new tab
`<`               prev_sibling        navigate to the previous sibling of current file/directory
`>`               next_sibling        navigate to the next sibling of current file/directory
`P`               parent_node         move cursor to the parent directory
`<BS>`            close_node          close current opened directory or parent
`<Tab>`           preview             open the file as a preview (keeps the cursor in the tree)
`K`               first_sibling       navigate to the first sibling of current file/directory
`J`               last_sibling        navigate to the last sibling of current file/directory
`I`               toggle_git_ignored  toggle visibility of files/folders hidden via |git.ignore| option
`H`               toggle_dotfiles     toggle visibility of dotfiles via |filters.dotfiles| option
`U`               toggle_custom       toggle visibility of files/folders hidden via |filters.custom| option
`R`               refresh             refresh the tree
`a`               create              add a file; leaving a trailing `/` will add a directory
`d`               remove              delete a file (will prompt for confirmation)
`D`               trash               trash a file via |trash| option
`r`               rename              rename a file
`<C-r>`           full_rename         rename a file and omit the filename on input
`x`               cut                 add/remove file/directory to cut clipboard
`c`               copy                add/remove file/directory to copy clipboard
`p`               paste               paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation
`y`               copy_name           copy name to system clipboard
`Y`               copy_path           copy relative path to system clipboard
`gy`              copy_absolute_path  copy absolute path to system clipboard
`[e`              prev_diag_item      go to next diagnostic item
`[c`              prev_git_item       go to next git item
`]e`              next_diag_item      go to prev diagnostic item
`]c`              next_git_item       go to prev git item
`-`               dir_up              navigate up to the parent directory of the current file/directory
`s`               system_open         open a file with default system application or a folder with default file manager, using |system_open| option
`f`               live_filter         live filter nodes dynamically based on regex matching.
`F`               clear_live_filter   clear live filter
`q`               close               close tree window
`W`               collapse_all        collapse the whole tree
`E`               expand_all          expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder
`S`               search_node         prompt the user to enter a path and then expands the tree to match the path
`.`               run_file_command    enter vim command mode with the file the cursor is on
`<C-k>`           toggle_file_info    toggle a popup with file infos about the file under the cursor
`g?`              toggle_help         toggle help
`m`               toggle_mark         Toggle node in bookmarks
`bmv`             bulk_move           Move all bookmarked nodes into specified location

>
  view.mappings.list = { -- BEGIN_DEFAULT_MAPPINGS
    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
    { key = "<C-e>",                          action = "edit_in_place" },
    { key = "O",                              action = "edit_no_picker" },
    { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
    { key = "<C-v>",                          action = "vsplit" },
    { key = "<C-x>",                          action = "split" },
    { key = "<C-t>",                          action = "tabnew" },
    { key = "<",                              action = "prev_sibling" },
    { key = ">",                              action = "next_sibling" },
    { key = "P",                              action = "parent_node" },
    { key = "<BS>",                           action = "close_node" },
    { key = "<Tab>",                          action = "preview" },
    { key = "K",                              action = "first_sibling" },
    { key = "J",                              action = "last_sibling" },
    { key = "I",                              action = "toggle_git_ignored" },
    { key = "H",                              action = "toggle_dotfiles" },
    { key = "U",                              action = "toggle_custom" },
    { key = "R",                              action = "refresh" },
    { key = "a",                              action = "create" },
    { key = "d",                              action = "remove" },
    { key = "D",                              action = "trash" },
    { key = "r",                              action = "rename" },
    { key = "<C-r>",                          action = "full_rename" },
    { key = "x",                              action = "cut" },
    { key = "c",                              action = "copy" },
    { key = "p",                              action = "paste" },
    { key = "y",                              action = "copy_name" },
    { key = "Y",                              action = "copy_path" },
    { key = "gy",                             action = "copy_absolute_path" },
    { key = "[e",                             action = "prev_diag_item" },
    { key = "[c",                             action = "prev_git_item" },
    { key = "]e",                             action = "next_diag_item" },
    { key = "]c",                             action = "next_git_item" },
    { key = "-",                              action = "dir_up" },
    { key = "s",                              action = "system_open" },
    { key = "f",                              action = "live_filter" },
    { key = "F",                              action = "clear_live_filter" },
    { key = "q",                              action = "close" },
    { key = "W",                              action = "collapse_all" },
    { key = "E",                              action = "expand_all" },
    { key = "S",                              action = "search_node" },
    { key = ".",                              action = "run_file_command" },
    { key = "<C-k>",                          action = "toggle_file_info" },
    { key = "g?",                             action = "toggle_help" },
    { key = "m",                              action = "toggle_mark" },
    { key = "bmv",                            action = "bulk_move" },
  } -- END_DEFAULT_MAPPINGS
<

==============================================================================
 7. HIGHLIGHT GROUPS                                     *nvim-tree-highlight*

All the following highlight groups can be configured by hand. Aside from
`NvimTreeWindowPicker`, it is not advised to colorize the background of these
groups.

Example (in your `init.vim`):
>
    highlight NvimTreeSymlink guifg=blue gui=bold,underline
<
You should have 'termguicolors' enabled, otherwise, colors will not be
applied.

Default linked group follows name.

NvimTreeSymlink
NvimTreeFolderName          (Directory)
NvimTreeRootFolder
NvimTreeFolderIcon
NvimTreeFileIcon
NvimTreeEmptyFolderName     (Directory)
NvimTreeOpenedFolderName    (Directory)
NvimTreeExecFile
NvimTreeOpenedFile
NvimTreeSpecialFile
NvimTreeImageFile
NvimTreeIndentMarker

NvimTreeLspDiagnosticsError         (DiagnosticError)
NvimTreeLspDiagnosticsWarning       (DiagnosticWarn)
NvimTreeLspDiagnosticsInformation   (DiagnosticInfo)
NvimTreeLspDiagnosticsHint          (DiagnosticHint)

NvimTreeGitDirty
NvimTreeGitStaged
NvimTreeGitMerge
NvimTreeGitRenamed
NvimTreeGitNew
NvimTreeGitDeleted
NvimTreeGitIgnored      (Comment)

NvimTreeWindowPicker

There are also links to normal bindings to style the tree itself.

NvimTreeNormal
NvimTreeEndOfBuffer     (NonText)
NvimTreeCursorLine      (CursorLine)
NvimTreeVertSplit       (VertSplit)     [deprecated, use NvimTreeWinSeparator]
NvimTreeWinSeparator    (VertSplit)
NvimTreeCursorColumn    (CursorColumn)

There are also links for file highlight with git properties, linked to their
Git equivalent:

NvimTreeFileDirty       (NvimTreeGitDirty)
NvimTreeFileStaged      (NvimTreeGitStaged)
NvimTreeFileMerge       (NvimTreeGitMerge)
NvimTreeFileRenamed     (NvimTreeGitRenamed)
NvimTreeFileNew         (NvimTreeGitNew)
NvimTreeFileDeleted     (NvimTreeGitDeleted)
NvimTreeFileIgnored     (NvimTreeGitIgnored)

There are 2 highlight groups for the live filter feature

NvimTreeLiveFilterPrefix
NvimTreeLiveFilterValue

Color of the bookmark icon

NvimTreeBookmark


==============================================================================
 8. EVENTS                                                  *nvim-tree-events*

|nvim_tree_events|

nvim-tree will dispatch events whenever an action is made. These events can be
subscribed to through handler functions. This allows for even further
customization of nvim-tree.

A handler for an event is just a function which receives one argument, the
payload of the event. The payload is different for each event type. Refer
to |nvim_tree_registering_handlers| for more information.

|nvim_tree_registering_handlers|

Handlers are registered by calling the `events.subscribe` function available in the
`require("nvim-tree.api")` module.

For example, registering a handler for when a node is renamed is done like this:
>
    local api = require('nvim-tree.api')

    api.events.subscribe(Event.NodeRenamed, function(data)
        print("Node renamed from " .. data.old_name .. " to " ..  data.new_name)
    end)
<

|nvim_tree_events_kind|

You can access the event enum with:
>
    local Event = require('nvim-tree.api').events.Event
<
Here is the list of available variant of this enum:

- Event.Ready
                When NvimTree has been initialized
                • Note: Handler takes no parameter.

- Event.TreeOpen
                • Note: Handler takes no parameter.

- Event.TreeClose
                • Note: Handler takes no parameter.

- Event.Resize - When NvimTree is resized.
                handler parameters: ~
                    size:        `number` size of the view in columns.

- Event.NodeRenamed
                • Note: A node can either be a file or a directory.
                handler parameters: ~
                  {old_name}     `{string}` Absolute path to the old node location.
                  {new_name}     `{string}` Absolute path to the new node location.

- Event.FileCreated
                handler parameters: ~
                  {fname}        `{string}` Absolute path to the created file

- Event.FileRemoved
                handler parameters: ~
                  {fname}        `{string}` Absolute path to the removed file.

- Event.FolderCreated
                handler parameters: ~
                  {folder_name}  `{string}` Absolute path to the created folder.

- Event.FolderRemoved
                handler parameters: ~
                  {folder_name}  `{string}` Absolute path to the removed folder.

==============================================================================
 9. BOOKMARKS                                      *nvim-tree-bookmarks*

You can toggle marks on files/folders with
`require("nvim-tree.api").marks.toggle(node)` which is bound to `m` by
default.

To get the list of marked paths, you can call
`require("nvim-tree.api").marks.list()`. This will return `{node}`.

*nvim-tree.bookmarks.navigation*

Navigation for marks is not bound by default in nvim-tree because we don't
want to focus the tree view each time we wish to switch to another mark.

This requires binding bookmark navigation yourself.

-- in your lua configuration
vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)

 vim:tw=78:ts=4:sw=4:et:ft=help:norl: