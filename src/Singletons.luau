const Types = require("./Types")

type Map<K = any, V = any> = Types.Map<K, V>

const marked: Map<Map, boolean> = {}

const function MarkDeep(tbl: Map)
	if marked[tbl] then
		return
	end

	marked[tbl] = true

	for key, value in tbl do
		if type(key) == "table" then
			MarkDeep(key)
		end

		if type(value) == "table" then
			MarkDeep(value)
		end
	end
end

const Singletons = {}

function Singletons.Mark(tbl: Map): ()
	marked[tbl] = true
end

function Singletons.Unmark(tbl: Map): ()
	marked[tbl] = nil
end

function Singletons.Is(tbl: Map): boolean
	return marked[tbl] == true
end

Singletons.MarkDeep = MarkDeep

return Singletons
