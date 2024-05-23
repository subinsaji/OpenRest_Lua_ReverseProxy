local mysql = require "resty.mysql";
local cjson = require "cjson"
local db, err = mysql:new()
if not db then
    ngx.say("failed to instantiate mysql: ", err)
    return
end

db:set_timeout(1000)

local ok, err, errcode, sqlstate = db:connect{
    host = "127.0.0.1",
    port = 3306,
    database = "information_schema",
    user = "root",
    password = "pass",
    charset = "utf8",


}

if not ok then
    ngx.say("failed to connect: ", err, ": ", errcode, " ", sq)
    return
end

result, err, errcode, sqlstate = db:query("SELECT 1;")
if not result then
    ngx.say("MySQL error: ", err, ". ", "Result: ", result, ", SQL State: ", sqlstate)
        return
end


ngx.say("connected to mysql. ", "SQL State: ", sqlstate )


ngx.say("result: ", cjson.encode(result))


db:close()
