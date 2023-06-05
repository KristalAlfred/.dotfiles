return {
    {
        'altermo/ultimate-autopair.nvim',
        event={'InsertEnter','CmdlineEnter'},
        branch='v0.6',
        config=function ()
            require('ultimate-autopair').setup({
                --Config goes here
                balance=true,
            })
        end,
    }
}
