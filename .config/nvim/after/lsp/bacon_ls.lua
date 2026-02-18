return {
  enabled = vim.g.lazyvim_rust_diagnostics == "bacon-ls",
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 1000,
    runBaconInBackground = true,
  },
}
