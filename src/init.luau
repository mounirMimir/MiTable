--!native
--!optimize 2

const SwapRemove = require("@self/SwapRemove")
const Copy = require("@self/Copy")
const Compare = require("@self/Compare")

const MiTable = {}

MiTable.Copy = Copy.Copy
MiTable.CompileCopy = Copy.Compile
MiTable.Compare = Compare.Compare
MiTable.CompileCompare = Compare.Compile
MiTable.Singletons = require("@self/Singletons")
MiTable.SwapRemove = SwapRemove.SwapRemove
MiTable.SwapRemoveFirstValue = SwapRemove.SwapRemoveFirstValue
MiTable.DeepFreeze = require("@self/DeepFreeze")

return MiTable
