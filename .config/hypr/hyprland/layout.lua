hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

hl.config({
    master = {
        allow_small_split = true,
        new_status = "slave",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})
