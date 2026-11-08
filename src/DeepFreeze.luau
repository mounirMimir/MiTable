const Singletons = require("./Singletons")
const Types = require("./Types")

const IsSingleton = Singletons.Is

type Map<K = any, V = any> = Types.Map<K, V>

const function DeepFreeze(t: Map, seen: Map<Map, boolean>): Map
	if IsSingleton(t) or seen[t] then
		return t
	end

	seen[t] = true

	for k, v in t do
		if type(v) == "table" then
			DeepFreeze(v, seen)
		end

		if type(k) == "table" then
			DeepFreeze(k, seen)
		end
	end

	if not table.isfrozen(t) then
		table.freeze(t)
	end

	return t
end

--[[
	Recursively freezes a table and all nested tables in both keys and values.
	Singleton tables are left untouched.
]]
return function<T>(t: T): T
	return DeepFreeze(t, {})
end
