local serjao = require("release/serjao_berranteiro/serjao_berranteiro")

---@param rq Request
local function main_server(rq)


  return serjao.html(serjao.body(serjao.h1("Hello Word"))), 500
  

end

serjao.server(3000, 3003, main_server)