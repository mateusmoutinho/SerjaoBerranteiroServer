local serjao = require("release/serjao_berranteiro/serjao_berranteiro")

local function whatever_name()

  return {
    teste = {"aaa","aaa",{valor=30,valor3=34}  },
    name="mateus",
    age=28
  }

end

serjao.server(3000, 5000, whatever_name)