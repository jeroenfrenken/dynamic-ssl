local pgmoon = require("pgmoon")

local pg = pgmoon.new({
    host = os.getenv('DB_HOST'),
    port = os.getenv('DB_PORT'),
    user = os.getenv('DB_USER'),
    password = os.getenv('DB_PASS'),
    database = os.getenv('DB_DATABASE')
})

assert(pg:connect())

local domain = pg:query("SELECT * FROM domains WHERE domain = " .. pg:escape_literal(ngx.var.host))

if domain[1] then
    if domain[1]['ssl_verified'] then
        ngx.redirect("https://" .. ngx.var.host .. ngx.var.uri)
    end
end

pg:keepalive()
