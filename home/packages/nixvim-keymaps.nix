{ ... }:

{
  programs.nixvim.keymaps = [
      # Quick file tree toggle on <leader>e
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<cr>";
        options.desc = "Toggle file tree";
      }
      # File operations
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua require('fzf-lua').files()<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>lua require('fzf-lua').oldfiles()<cr>";
        options.desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>w<cr>";
        options.desc = "Save file";
      }
      {
        mode = "n";
        key = "<leader>fW";
        action = "<cmd>wa<cr>";
        options.desc = "Save all files";
      }
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>enew<cr>";
        options.desc = "New file";
      }

      # Buffer operations
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>lua require('fzf-lua').buffers()<cr>";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<leader>bn";
        action = "<cmd>bnext<cr>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>bprevious<cr>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>%bdelete|edit#|bdelete#<cr>";
        options.desc = "Delete all buffers except current";
      }

      # File tree (nvim-tree)
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>NvimTreeToggle<cr>";
        options.desc = "Toggle file tree";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>NvimTreeFocus<cr>";
        options.desc = "Focus file tree";
      }
      {
        mode = "n";
        key = "<leader>tr";
        action = "<cmd>NvimTreeRefresh<cr>";
        options.desc = "Refresh file tree";
      }

      # Search operations
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>lua require('fzf-lua').live_grep()<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>sw";
        action = "<cmd>lua require('fzf-lua').grep_cword()<cr>";
        options.desc = "Search word under cursor";
      }
      {
        mode = "n";
        key = "<leader>sb";
        action = "<cmd>lua require('fzf-lua').lgrep_curbuf()<cr>";
        options.desc = "Search in current buffer";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>lua require('fzf-lua').search_history()<cr>";
        options.desc = "Search history";
      }
      {
        mode = "n";
        key = "<leader>sc";
        action = "<cmd>lua require('fzf-lua').commands()<cr>";
        options.desc = "Search commands";
      }

      # LSP operations (moved from <leader>e)
      {
        mode = "n";
        key = "<leader>le";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options.desc = "Open diagnostic float";
      }
      {
        mode = "n";
        key = "<leader>lq";
        action = "<cmd>lua vim.diagnostic.setloclist()<cr>";
        options.desc = "Set diagnostic loclist";
      }
      {
        mode = "n";
        key = "<leader>lf";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options.desc = "Format buffer";
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>lua vim.lsp.buf.rename()<cr>";
        options.desc = "Rename symbol";
      }
      {
        mode = "n";
        key = "<leader>la";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options.desc = "Code actions";
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>lua require('fzf-lua').lsp_definitions()<cr>";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "<leader>lD";
        action = "<cmd>lua require('fzf-lua').lsp_declarations()<cr>";
        options.desc = "Go to declaration";
      }
      {
        mode = "n";
        key = "<leader>li";
        action = "<cmd>lua require('fzf-lua').lsp_implementations()<cr>";
        options.desc = "Go to implementation";
      }
      {
        mode = "n";
        key = "<leader>lt";
        action = "<cmd>lua require('fzf-lua').lsp_typedefs()<cr>";
        options.desc = "Go to type definition";
      }
      {
        mode = "n";
        key = "<leader>lR";
        action = "<cmd>lua require('fzf-lua').lsp_references()<cr>";
        options.desc = "Find references";
      }
      {
        mode = "n";
        key = "<leader>ls";
        action = "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>";
        options.desc = "Document symbols";
      }
      {
        mode = "n";
        key = "<leader>lS";
        action = "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<cr>";
        options.desc = "Workspace symbols";
      }

      # Git operations
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>lua require('fzf-lua').git_status()<cr>";
        options.desc = "Git status";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>lua require('fzf-lua').git_commits()<cr>";
        options.desc = "Git commits";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>lua require('fzf-lua').git_branches()<cr>";
        options.desc = "Git branches";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>lua require('fzf-lua').git_files()<cr>";
        options.desc = "Git files";
      }
      {
        mode = "n";
        key = "<leader>gh";
        action = "<cmd>Gitsigns preview_hunk<cr>";
        options.desc = "Preview hunk";
      }
      {
        mode = "n";
        key = "<leader>gH";
        action = "<cmd>Gitsigns preview_hunk_inline<cr>";
        options.desc = "Preview hunk inline";
      }
      {
        mode = "n";
        key = "<leader>gr";
        action = "<cmd>Gitsigns reset_hunk<cr>";
        options.desc = "Reset hunk";
      }
      {
        mode = "n";
        key = "<leader>gR";
        action = "<cmd>Gitsigns reset_buffer<cr>";
        options.desc = "Reset buffer";
      }
      {
        mode = "n";
        key = "<leader>gS";
        action = "<cmd>Gitsigns stage_hunk<cr>";
        options.desc = "Stage hunk";
      }
      {
        mode = "n";
        key = "<leader>gu";
        action = "<cmd>Gitsigns undo_stage_hunk<cr>";
        options.desc = "Undo stage hunk";
      }

      # UI toggles
      {
        mode = "n";
        key = "<leader>uh";
        action = "<cmd>set hlsearch!<cr>";
        options.desc = "Toggle highlight search";
      }
      {
        mode = "n";
        key = "<leader>un";
        action = "<cmd>set number!<cr>";
        options.desc = "Toggle line numbers";
      }
      {
        mode = "n";
        key = "<leader>ur";
        action = "<cmd>set relativenumber!<cr>";
        options.desc = "Toggle relative numbers";
      }
      {
        mode = "n";
        key = "<leader>uw";
        action = "<cmd>set wrap!<cr>";
        options.desc = "Toggle word wrap";
      }
      {
        mode = "n";
        key = "<leader>us";
        action = "<cmd>set spell!<cr>";
        options.desc = "Toggle spell check";
      }

      # Window operations
      {
        mode = "n";
        key = "<leader>wv";
        action = "<cmd>vsplit<cr>";
        options.desc = "Vertical split";
      }
      {
        mode = "n";
        key = "<leader>ws";
        action = "<cmd>split<cr>";
        options.desc = "Horizontal split";
      }
      {
        mode = "n";
        key = "<leader>wc";
        action = "<cmd>close<cr>";
        options.desc = "Close window";
      }
      {
        mode = "n";
        key = "<leader>wo";
        action = "<cmd>only<cr>";
        options.desc = "Close other windows";
      }
      {
        mode = "n";
        key = "<leader>wh";
        action = "<C-w>h";
        options.desc = "Move to left window";
      }
      {
        mode = "n";
        key = "<leader>wj";
        action = "<C-w>j";
        options.desc = "Move to bottom window";
      }
      {
        mode = "n";
        key = "<leader>wk";
        action = "<C-w>k";
        options.desc = "Move to top window";
      }
      {
        mode = "n";
        key = "<leader>wl";
        action = "<C-w>l";
        options.desc = "Move to right window";
      }
      {
        mode = "n";
        key = "<leader>w=";
        action = "<C-w>=";
        options.desc = "Equalize windows";
      }

      # Tab operations
      {
        mode = "n";
        key = "<leader><tab>n";
        action = "<cmd>tabnew<cr>";
        options.desc = "New tab";
      }
      {
        mode = "n";
        key = "<leader><tab>c";
        action = "<cmd>tabclose<cr>";
        options.desc = "Close tab";
      }
      {
        mode = "n";
        key = "<leader><tab>o";
        action = "<cmd>tabonly<cr>";
        options.desc = "Close other tabs";
      }
      {
        mode = "n";
        key = "<leader><tab>l";
        action = "<cmd>tabnext<cr>";
        options.desc = "Next tab";
      }
      {
        mode = "n";
        key = "<leader><tab>h";
        action = "<cmd>tabprevious<cr>";
        options.desc = "Previous tab";
      }

      # Session operations
      {
        mode = "n";
        key = "<leader>qs";
        action = "<cmd>mksession! Session.vim<cr>";
        options.desc = "Save session";
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = "<cmd>source Session.vim<cr>";
        options.desc = "Load session";
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options.desc = "Quit all";
      }
      {
        mode = "n";
        key = "<leader>qQ";
        action = "<cmd>qa!<cr>";
        options.desc = "Force quit all";
      }

      # Quick actions
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>x<cr>";
        options.desc = "Save and quit";
      }
      {
        mode = "n";
        key = "<leader>X";
        action = "<cmd>xa<cr>";
        options.desc = "Save all and quit";
      }

      # Help and documentation
      {
        mode = "n";
        key = "<leader>hh";
        action = "<cmd>lua require('fzf-lua').help_tags()<cr>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<leader>hm";
        action = "<cmd>lua require('fzf-lua').man_pages()<cr>";
        options.desc = "Man pages";
      }
      {
        mode = "n";
        key = "<leader>hk";
        action = "<cmd>lua require('fzf-lua').keymaps()<cr>";
        options.desc = "Show keymaps";
      }
      {
        mode = "n";
        key = "<leader>hc";
        action = "<cmd>lua require('fzf-lua').commands()<cr>";
        options.desc = "Show commands";
      }

      # Terminal operations
      {
        mode = "n";
        key = "<leader>Tt";
        action = "<cmd>terminal<cr>";
        options.desc = "Open terminal";
      }
      {
        mode = "n";
        key = "<leader>Tv";
        action = "<cmd>vsplit | terminal<cr>";
        options.desc = "Terminal vertical split";
      }
      {
        mode = "n";
        key = "<leader>Ts";
        action = "<cmd>split | terminal<cr>";
        options.desc = "Terminal horizontal split";
      }

      # Text operations
      {
        mode = "n";
        key = "<leader>tc";
        action = "<cmd>lua require('fzf-lua').colorschemes()<cr>";
        options.desc = "Change colorscheme";
      }
      {
        mode = "v";
        key = "<leader>ts";
        action = ":sort<cr>";
        options.desc = "Sort selected lines";
      }
      {
        mode = "n";
        key = "<leader>tr";
        action = ":%s//g<left><left>";
        options.desc = "Replace in file";
      }

      # Diagnostics
      {
        mode = "n";
        key = "<leader>dd";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options.desc = "Open diagnostic float";
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua vim.diagnostic.setloclist()<cr>";
        options.desc = "Set diagnostic loclist";
      }
      {
        mode = "n";
        key = "<leader>dn";
        action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
        options.desc = "Next diagnostic";
      }
      {
        mode = "n";
        key = "<leader>dp";
        action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
        options.desc = "Previous diagnostic";
      }

      # Navigation
      {
        mode = "n";
        key = "<leader>j";
        action = "<cmd>lua require('fzf-lua').jumps()<cr>";
        options.desc = "Jump list";
      }
      {
        mode = "n";
        key = "<leader>m";
        action = "<cmd>lua require('fzf-lua').marks()<cr>";
        options.desc = "Marks";
      }

      # Code folding
      {
        mode = "n";
        key = "<leader>za";
        action = "za";
        options.desc = "Toggle fold";
      }
      {
        mode = "n";
        key = "<leader>zR";
        action = "zR";
        options.desc = "Open all folds";
      }
      {
        mode = "n";
        key = "<leader>zM";
        action = "zM";
        options.desc = "Close all folds";
      }

      # Comments
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>";
        options.desc = "Toggle comment line";
      }
      {
        mode = "v";
        key = "<leader>/";
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
        options.desc = "Toggle comment selection";
      }

      # Dashboard
      {
        mode = "n";
        key = "<leader>d";
        action = "<cmd>Dashboard<cr>";
        options.desc = "Open dashboard";
      }

      # Easy escape from insert mode
      {
        mode = "i";
        key = "jk";
        action = "<Esc>";
        options.desc = "Exit insert mode";
      }

      # Better movement in insert mode
      {
        mode = "i";
        key = "<C-h>";
        action = "<Left>";
        options.desc = "Move left";
      }
      {
        mode = "i";
        key = "<C-j>";
        action = "<Down>";
        options.desc = "Move down";
      }
      {
        mode = "i";
        key = "<C-k>";
        action = "<Up>";
        options.desc = "Move up";
      }
      {
        mode = "i";
        key = "<C-l>";
        action = "<Right>";
        options.desc = "Move right";
      }

      # Better window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move to left window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move to bottom window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move to top window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move to right window";
      }

      # Resize windows
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase window height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease window height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease window width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase window width";
      }

      # Indentation in visual mode
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Indent left and reselect";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Indent right and reselect";
      }

      # Move selected lines
      {
        mode = "v";
        key = "J";
        action = ":move '>+1<cr>gv-gv";
        options.desc = "Move selection down";
      }
      {
        mode = "v";
        key = "K";
        action = ":move '<-2<cr>gv-gv";
        options.desc = "Move selection up";
      }

      # Better paste (don't overwrite register)
      {
        mode = "v";
        key = "p";
        action = "\"_dP";
        options.desc = "Paste without overwriting register";
      }

      # Clear search highlighting
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<cr>";
        options.desc = "Clear search highlighting";
      }

      # Quick save
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<cr>";
        options.desc = "Save file";
      }
      {
        mode = "i";
        key = "<C-s>";
        action = "<Esc><cmd>w<cr>";
        options.desc = "Save file";
      }
    ];
}
