local pgmoon = require("pgmoon")
local ssl = require "ngx.ssl"
ssl.clear_certs()

local pg = pgmoon.new({
    host = os.getenv('DB_HOST'),
    port = os.getenv('DB_PORT'),
    user = os.getenv('DB_USER'),
    password = os.getenv('DB_PASS'),
    database = os.getenv('DB_DATABASE')
})

assert(pg:connect())

local common_name = ssl.server_name()
local domain = pg:query("SELECT * FROM domains WHERE domain = " .. pg:escape_literal(common_name))

local cert_chain = domain[1]['certificate']
local pem_pkey = domain[1]['private_key']

pg:keepalive()

local der_cert_chain = ssl.cert_pem_to_der(cert_chain)
ssl.set_der_cert(der_cert_chain)

local der_pkey = ssl.priv_key_pem_to_der(pem_pkey)
ssl.set_der_priv_key(der_pkey)
