local mysql = require "resty.mysql";
            local db, err = mysql:new()
            if not db then
                ngx.say("failed to instantiate mysql: ", err)
                return
            end
             
            db:set_timeout(1000)
             
            local ok, err, errcode, sqlstate = db:connect{
                host = "127.0.0.1",
                port = 3306,
                database = "",
                user = "root",
                password = "pass",
                charset = "utf8",
                --ssl = "false",

 
            }
 
            if not ok then
                ngx.say("failed to connect: ", err, ": ", errcode, " ", sq)
                return
            end
 
            result, err, errcode, sqlstate = db:query("SELECT * from BLSampleType;")
            if not result then
                ngx.say("MySQL error: ", err, ". ", "Result: ", result)
                    return
            end
            
            
            ngx.say("connected to mysql. ", "Result: ", result)
 
            --db:close()