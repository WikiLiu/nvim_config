return {
    'OscarCreator/rsync.nvim',
    dev = false,
    build = 'make',
     event = "VimEnter",
    dependencies = {
        { 'nvim-lua/plenary.nvim' }
    },

    config = function()
        require('rsync').setup({
            fugitive_sync = false,
            sync_on_save = true,
            reload_file_after_sync = true,
            project_config_path = ".vscode/rsync.toml",
            on_exit = nil,
            on_stderr = nil,
        })
    end,
    cmd = {"RsyncUp", "RsyncUpFile","RsyncDown","RsyncDownFile","RsyncConfig"},
}