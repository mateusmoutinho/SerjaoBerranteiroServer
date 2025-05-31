local serjao = require("serjao_berranteiro/serjao_berranteiro")

local function whatever_name()

  return {
    name="mateus",
    age=28
  }

end

serjao.server(3000, 5000, whatever_name)