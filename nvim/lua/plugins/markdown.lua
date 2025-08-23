return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  config = function()
    local peek_config = {
      filetype = { 'markdown', 'conf' }
    }
    
    -- WSL2-specific configuration for browser access
    if vim.fn.has('wsl') == 1 then
      -- Try to use Windows Chrome from WSL2
      local chrome_path = '/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
      if vim.fn.executable(chrome_path) == 1 then
        peek_config.app = { chrome_path, '--new-window' }
      else
        -- Fallback: try Edge
        local edge_path = '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
        if vim.fn.executable(edge_path) == 1 then
          peek_config.app = { edge_path, '--new-window' }
        else
          vim.notify("peek.nvim: No Windows browser found. Install Chrome or Edge on Windows.", vim.log.levels.WARN)
        end
      end
    end
    
    require("peek").setup(peek_config)
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}