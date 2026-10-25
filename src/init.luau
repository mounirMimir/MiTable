--!native
--!optimize 2

const SwapRemove = require("@self/SwapRemove")

const MiTable = {}

MiTable.Copy = require("@self/Copy")
MiTable.Compare = require("@self/Compare")
MiTable.Singletons = require("@self/Singletons")
MiTable.SwapRemove = SwapRemove.SwapRemove
MiTable.SwapRemoveFirstValue = SwapRemove.SwapRemoveFirstValue

return MiTable
