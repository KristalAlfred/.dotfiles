local function get_plugin_files()
  local output = vim.fn.systemlist("find ~/.config/nvim/lua/plugins -maxdepth 1 -name '*.lua'")
  local plugins = {}
  for _, filename in ipairs(output) do
    local module_name = filename:match(".*/(.*).lua") -- Extract using pattern matching
    table.insert(plugins, require('plugins.' .. module_name))
  end
  return plugins
end

require('lazy').setup(get_plugin_files())
