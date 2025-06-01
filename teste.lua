local serjao = require("release/serjao_berranteiro/serjao_berranteiro")


local num = 0

---@param request Request
local function teste(request)

   if request.route == "/increment" then
        num = num +1
   	    return serjao.send_html(serjao.h1("o valor do numero é ",tostring(num),{id="num"}))

   end
  local html = serjao.fragment("<!DOCTYPE html>",

          serjao.html(
                  serjao.head(
                          serjao.title("Hello Word"),
                          serjao.script({src="https://unpkg.com/htmx.org@1.9.12"})
                  ),

                  serjao.body(
                          serjao.h1("o valor do numero é ",tostring(num),{id="num"}),
                          "<br>",
                          serjao.button("increment",{
                                ["hx-trigger"]="click",
                                ["hx-post"]="/increment",
                                ["hx-target"]="#num",
                                ["hx-swap"]="innerHTML"
                          })
                  )
          )
  )
    return serjao.send_html(html.render())
end

serjao.desktop("google-chrome", teste,600)