local mdb = require "resty.libmariadb"
local ctx = mdb.mysql_init()
local res, err = mdb.mysql_real_connect2(ctx, "127.0.0.1",
    "root", "pass", "ispyb", 0, nil, 0)
if err ~= nil then
    ngx.log(ngx.ERR, "mysql_real_connect2 failed: ", err)
    return
end

ok, err = mdb.mysql_query(ctx, "SELECT * FROM BLSampleType;")
if not ok then
    ngx.log(ngx.ERR, "mysql_query error: ", err)
    return
end

local result, err = mdb.mysql_store_result(ctx)
if not result then
    ngx.log(ngx.ERR, "mysql_store_result error: ", err)
    return
end

local num_fields = mdb.mysql_num_fields(result)
ngx.say("num fields: ", num_fields)

while(true)
do
    local row = mdb.mysql_fetch_row(ctx, result)
    if row == nil then
        break
    end

    for i = 0, num_fields - 1
    do
        local v = mdb.mysql_get_row_val_by_idx(row, i)
        ngx.say(v)
    end
end

mdb.mysql_free_result(result)
mdb.mysql_close(ctx)