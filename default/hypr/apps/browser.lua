-- Browser tags and styling.
o.window("[cC]hromium", { tag = "+chromium-based-browser" })
o.window({ tag = "chromium-based-browser" }, { tag = "-default-opacity", tile = true, opacity = "1.0 0.97" })

-- Video apps: remove chromium browser tag so they don't get opacity applied.
o.window("(chrome-youtube.com__-Default|chrome-app.zoom.us__wc_home-Default)", { tag = "-chromium-based-browser" })
o.window("(chrome-youtube.com__-Default|chrome-app.zoom.us__wc_home-Default)", { tag = "-default-opacity" })

-- Hide screen sharing notification windows.
o.window({ title = ".*is sharing.*" }, { workspace = "special silent" })
