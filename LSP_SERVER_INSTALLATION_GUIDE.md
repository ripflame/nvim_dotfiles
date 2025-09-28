# 🔧 LSP Server Installation Guide

## Overview

This guide explains how to add new LSP servers to your native LSP + Mason configuration. The
process involves two main steps: adding the server to Mason's auto-install list and configuring it
with native LSP.

---

## 📋 Installation Process

### Step 1: Add Server to Mason Auto-Install

**File:** `/home/ripflame/.nvim-setup/nvim/lua/plugins/mason.lua`

1. Open the Mason configuration file
2. Add your server to the `servers` array:

```lua
local servers = {
  "typescript-language-server",  -- for ts_ls
  "html-lsp",                    -- for html
  "css-lsp",                     -- for cssls
  "json-lsp",                    -- for jsonls
  "python-lsp-server",           -- for pylsp
  "lua-language-server",         -- for lua_ls
  "emmet-ls",                    -- for emmet_ls
  "marksman",                    -- for marksman
  "your-new-server",             -- ADD YOUR SERVER HERE
}
```

### Step 2: Configure Server with Native LSP

**File:** `/home/ripflame/.nvim-setup/nvim/init.lua`

1. Add server configuration after the existing ones (around line 110):

```lua
-- Your New Language Server
vim.lsp.config.your_server_name = {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/your-server-executable", '--stdio' },
  filetypes = { 'your', 'supported', 'filetypes' },
  root_markers = { 'package.json', '.git' },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    -- Server-specific settings (optional)
    YourServer = {
      setting1 = "value1",
      setting2 = "value2",
    }
  }
})
```

2. Add your server to the enable list:

```lua
-- Enable all configured LSP servers
vim.lsp.enable({
  'ts_ls', 'html', 'cssls', 'jsonls', 'pyright', 'lua_ls', 'emmet_ls', 'marksman', 'your_server_name'
})
```

---

## 🎯 Common Language Server Examples

### Go (gopls)

**Mason name:** `gopls` **LSP config name:** `gopls`

```lua
-- In mason.lua servers array:
"gopls",

-- In init.lua:
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  }
})
```

### Rust (rust-analyzer)

**Mason name:** `rust-analyzer` **LSP config name:** `rust_analyzer`

```lua
-- In mason.lua servers array:
"rust-analyzer",

-- In init.lua:
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json' },
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    }
  }
})
```

### C/C++ (clangd)

**Mason name:** `clangd` **LSP config name:** `clangd`

```lua
-- In mason.lua servers array:
"clangd",

-- In init.lua:
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
  capabilities = capabilities,
})
```

### Java (jdtls)

**Mason name:** `jdtls` **LSP config name:** `jdtls`

```lua
-- In mason.lua servers array:
"jdtls",

-- In init.lua:
vim.lsp.config('jdtls', {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  capabilities = capabilities,
})
```

### PHP (intelephense)

**Mason name:** `intelephense` **LSP config name:** `intelephense`

```lua
-- In mason.lua servers array:
"intelephense",

-- In init.lua:
vim.lsp.config('intelephense', {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  capabilities = capabilities,
})
```

---

## 🔍 Finding Server Information

### 1. Mason Registry

Browse available servers:

```vim
:Mason
```

### 2. LSP Server Documentation

- **Server executable name**: Check the server's GitHub/documentation
- **Filetypes**: Usually documented in server README
- **Root markers**: Files that indicate project root (e.g., `package.json`, `.git`)
- **Settings**: Server-specific configuration options

### 3. Common Patterns

| Language   | Mason Name      | LSP Config Name | Executable           | Common Root Markers                  |
| ---------- | --------------- | --------------- | -------------------- | ------------------------------------ |
| **Go**     | `gopls`         | `gopls`         | `gopls`              | `go.mod`, `go.work`                  |
| **Rust**   | `rust-analyzer` | `rust_analyzer` | `rust-analyzer`      | `Cargo.toml`                         |
| **C/C++**  | `clangd`        | `clangd`        | `clangd`             | `compile_commands.json`, `.clangd`   |
| **Java**   | `jdtls`         | `jdtls`         | `jdtls`              | `pom.xml`, `build.gradle`            |
| **PHP**    | `intelephense`  | `intelephense`  | `intelephense`       | `composer.json`                      |
| **Python** | `pyright`       | `pyright`       | `pyright-langserver` | `pyproject.toml`, `requirements.txt` |

---

## 🚀 Installation Workflow

### Method 1: Automatic Installation (Recommended)

1. **Add to configuration files** as shown above
2. **Restart Neovim** - Mason will auto-install the server
3. **Open a file** of the target language to trigger LSP

### Method 2: Manual Installation

1. **Install via Mason UI:**

   ```vim
   :Mason
   ```

   Navigate and press `i` to install

2. **Add configuration** as shown above

3. **Restart Neovim**

---

## ✅ Verification Steps

### 1. Check Server Installation

```vim
:Mason
```

✓ Server should show "installed" status

### 2. Check LSP Status

```vim
:LspInfo
```

✓ Server should be listed as "attached" when in appropriate file

### 3. Test LSP Features

Open a file of the target language and test:

- **Hover documentation**: `K`
- **Go to definition**: `gd`
- **Find references**: `gr`
- **Code actions**: `<leader>ca`
- **Rename**: `<leader>rn`

---

## 🛠️ Troubleshooting

### Server Not Starting

1. **Check Mason installation:**

   ```vim
   :Mason
   ```

2. **Check LSP logs:**

   ```vim
   :LspLog
   ```

3. **Verify executable in PATH:**
   ```vim
   :!which your-server-executable
   ```

### Server Installed But Not Attaching

1. **Check filetypes** in your configuration
2. **Verify root markers** exist in your project
3. **Check LSP Info:**
   ```vim
   :LspInfo
   ```

### Server Settings Not Applied

1. **Check settings format** (varies per server)
2. **Restart LSP client:**
   ```vim
   :LspRestart
   ```

---

## 📚 Additional Resources

- **Mason Registry**: [mason-registry](https://github.com/mason-org/mason-registry)
- **LSP Server Configurations**:
  [nvim-lspconfig server configs](https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations)
  (for reference only)
- **Neovim LSP Documentation**: `:help vim.lsp`

---

## 🔄 Template for New Servers

Use this template when adding any new LSP server:

```lua
-- 1. Add to mason.lua servers array:
"server-mason-name",

-- 2. Add to init.lua:
vim.lsp.config('server_config_name', {
  cmd = { 'server-executable', '--stdio' },
  filetypes = { 'your', 'filetypes' },
  root_markers = { 'project.file', '.git' },
  capabilities = capabilities,
  settings = {
    -- Optional server-specific settings
    ServerName = {
      setting = "value",
    }
  }
})

-- 3. Add to enable list in init.lua:
vim.lsp.enable({
  -- ... existing servers ...,
  'server_config_name'
})
```

---

_📝 This configuration uses native Neovim LSP (vim.lsp.config) with Mason for server management_  
_🚀 No nvim-lspconfig dependency required - future-proof for Neovim 0.12+_
