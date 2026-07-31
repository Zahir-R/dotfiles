require("config.lazy")

local home = os.getenv("HOME")
local user = os.getenv("USER")

local nix_paths = {
  home .. "/.nix-profile/share/nvim/site",
  "/etc/profiles/per-user/" .. user .. "/share/nvim/site",
  "/run/current-system/sw/share/nvim/site",
}

for _, path in ipairs(nix_paths) do
  if vim.fn.isdirectory(path) == 1 then
    vim.opt.rtp:append(path)
  end
end
