local TextReader = {}


function TextReader.parserFile(filePath, isIndex)

    local paserHanler = require("app.common.FileParser")
    return paserHanler:parserFile(filePath,isIndex,"\t")

end


return TextReader