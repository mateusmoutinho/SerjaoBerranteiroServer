local serjao = require("serjao_berranteiro/serjao_berranteiro")

local function whatever_name()

  return serjao.send_text("Hello Word", 200)

end

serjao.server(3000, 5000, whatever_name)