local CsvReader = {}


function CsvReader.parserFile(filePath, isIndex)
    
    local paserHanler = require("app.common.FileParser")
    return paserHanler:parserFile(filePath,isIndex,",")
    
end


return CsvReader