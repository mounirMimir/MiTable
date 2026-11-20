--!native
--!optimize 2

--[[
	GENERATED FILE - DO NOT EDIT BY HAND.

	Every function below is one specialized variant of Copy. Variants only ever
	recurse into themselves, so the configuration is fixed for the whole copy.

	slot = 1 + frozen*1 + refs*2 + key*4 + value*12 + array*36
]]

const Types = require("../Types")
const Singletons = require("../Singletons")

const IsSingleton = Singletons.Is

type Map<K = any, V = any> = Types.Map<K, V>

type Condition = (tbl: Map) -> boolean

-- slot 5: frozen=no, refs=no, key=all, value=none, array=no
const function Copy_F0_R0_K1_V0_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F0_R0_K1_V0_A0(key, kf, vf)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	return copy
end

-- slot 6: frozen=preserve, refs=no, key=all, value=none, array=no
const function Copy_F1_R0_K1_V0_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F1_R0_K1_V0_A0(key, kf, vf)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 7: frozen=no, refs=preserve, key=all, value=none, array=no
const function Copy_F0_R1_K1_V0_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F0_R1_K1_V0_A0(key, kf, vf, seen)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	return copy
end

-- slot 8: frozen=preserve, refs=preserve, key=all, value=none, array=no
const function Copy_F1_R1_K1_V0_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F1_R1_K1_V0_A0(key, kf, vf, seen)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 9: frozen=no, refs=no, key=condition, value=none, array=no
const function Copy_F0_R0_K2_V0_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F0_R0_K2_V0_A0(key, kf, vf)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	return copy
end

-- slot 10: frozen=preserve, refs=no, key=condition, value=none, array=no
const function Copy_F1_R0_K2_V0_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F1_R0_K2_V0_A0(key, kf, vf)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 11: frozen=no, refs=preserve, key=condition, value=none, array=no
const function Copy_F0_R1_K2_V0_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F0_R1_K2_V0_A0(key, kf, vf, seen)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	return copy
end

-- slot 12: frozen=preserve, refs=preserve, key=condition, value=none, array=no
const function Copy_F1_R1_K2_V0_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F1_R1_K2_V0_A0(key, kf, vf, seen)

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = value
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 13: frozen=no, refs=no, key=none, value=all, array=no
const function Copy_F0_R0_K0_V1_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(value) == "table" then
			const newValue = Copy_F0_R0_K0_V1_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 14: frozen=preserve, refs=no, key=none, value=all, array=no
const function Copy_F1_R0_K0_V1_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(value) == "table" then
			const newValue = Copy_F1_R0_K0_V1_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 15: frozen=no, refs=preserve, key=none, value=all, array=no
const function Copy_F0_R1_K0_V1_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(value) == "table" then
			const newValue = Copy_F0_R1_K0_V1_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 16: frozen=preserve, refs=preserve, key=none, value=all, array=no
const function Copy_F1_R1_K0_V1_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(value) == "table" then
			const newValue = Copy_F1_R1_K0_V1_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 17: frozen=no, refs=no, key=all, value=all, array=no
const function Copy_F0_R0_K1_V1_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F0_R0_K1_V1_A0(key, kf, vf)
			const newValue = if type(value) == "table" then Copy_F0_R0_K1_V1_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F0_R0_K1_V1_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 18: frozen=preserve, refs=no, key=all, value=all, array=no
const function Copy_F1_R0_K1_V1_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F1_R0_K1_V1_A0(key, kf, vf)
			const newValue = if type(value) == "table" then Copy_F1_R0_K1_V1_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F1_R0_K1_V1_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 19: frozen=no, refs=preserve, key=all, value=all, array=no
const function Copy_F0_R1_K1_V1_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F0_R1_K1_V1_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" then Copy_F0_R1_K1_V1_A0(value, kf, vf, seen) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F0_R1_K1_V1_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 20: frozen=preserve, refs=preserve, key=all, value=all, array=no
const function Copy_F1_R1_K1_V1_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F1_R1_K1_V1_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" then Copy_F1_R1_K1_V1_A0(value, kf, vf, seen) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F1_R1_K1_V1_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 21: frozen=no, refs=no, key=condition, value=all, array=no
const function Copy_F0_R0_K2_V1_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F0_R0_K2_V1_A0(key, kf, vf)
			const newValue = if type(value) == "table" then Copy_F0_R0_K2_V1_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F0_R0_K2_V1_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 22: frozen=preserve, refs=no, key=condition, value=all, array=no
const function Copy_F1_R0_K2_V1_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F1_R0_K2_V1_A0(key, kf, vf)
			const newValue = if type(value) == "table" then Copy_F1_R0_K2_V1_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F1_R0_K2_V1_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 23: frozen=no, refs=preserve, key=condition, value=all, array=no
const function Copy_F0_R1_K2_V1_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F0_R1_K2_V1_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" then Copy_F0_R1_K2_V1_A0(value, kf, vf, seen) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F0_R1_K2_V1_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 24: frozen=preserve, refs=preserve, key=condition, value=all, array=no
const function Copy_F1_R1_K2_V1_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F1_R1_K2_V1_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" then Copy_F1_R1_K2_V1_A0(value, kf, vf, seen) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" then
			const newValue = Copy_F1_R1_K2_V1_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 25: frozen=no, refs=no, key=none, value=condition, array=no
const function Copy_F0_R0_K0_V2_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R0_K0_V2_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 26: frozen=preserve, refs=no, key=none, value=condition, array=no
const function Copy_F1_R0_K0_V2_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R0_K0_V2_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 27: frozen=no, refs=preserve, key=none, value=condition, array=no
const function Copy_F0_R1_K0_V2_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R1_K0_V2_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 28: frozen=preserve, refs=preserve, key=none, value=condition, array=no
const function Copy_F1_R1_K0_V2_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R1_K0_V2_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 29: frozen=no, refs=no, key=all, value=condition, array=no
const function Copy_F0_R0_K1_V2_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F0_R0_K1_V2_A0(key, kf, vf)
			const newValue = if type(value) == "table" and vf(value) then Copy_F0_R0_K1_V2_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R0_K1_V2_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 30: frozen=preserve, refs=no, key=all, value=condition, array=no
const function Copy_F1_R0_K1_V2_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F1_R0_K1_V2_A0(key, kf, vf)
			const newValue = if type(value) == "table" and vf(value) then Copy_F1_R0_K1_V2_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R0_K1_V2_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 31: frozen=no, refs=preserve, key=all, value=condition, array=no
const function Copy_F0_R1_K1_V2_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F0_R1_K1_V2_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" and vf(value)
				then Copy_F0_R1_K1_V2_A0(value, kf, vf, seen)
				else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R1_K1_V2_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 32: frozen=preserve, refs=preserve, key=all, value=condition, array=no
const function Copy_F1_R1_K1_V2_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			const newKey = Copy_F1_R1_K1_V2_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" and vf(value)
				then Copy_F1_R1_K1_V2_A0(value, kf, vf, seen)
				else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R1_K1_V2_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 33: frozen=no, refs=no, key=condition, value=condition, array=no
const function Copy_F0_R0_K2_V2_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F0_R0_K2_V2_A0(key, kf, vf)
			const newValue = if type(value) == "table" and vf(value) then Copy_F0_R0_K2_V2_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R0_K2_V2_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 34: frozen=preserve, refs=no, key=condition, value=condition, array=no
const function Copy_F1_R0_K2_V2_A0(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F1_R0_K2_V2_A0(key, kf, vf)
			const newValue = if type(value) == "table" and vf(value) then Copy_F1_R0_K2_V2_A0(value, kf, vf) else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R0_K2_V2_A0(value, kf, vf)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 35: frozen=no, refs=preserve, key=condition, value=condition, array=no
const function Copy_F0_R1_K2_V2_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F0_R1_K2_V2_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" and vf(value)
				then Copy_F0_R1_K2_V2_A0(value, kf, vf, seen)
				else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R1_K2_V2_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	return copy
end

-- slot 36: frozen=preserve, refs=preserve, key=condition, value=condition, array=no
const function Copy_F1_R1_K2_V2_A0(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" and kf(key) then
			const newKey = Copy_F1_R1_K2_V2_A0(key, kf, vf, seen)
			const newValue = if type(value) == "table" and vf(value)
				then Copy_F1_R1_K2_V2_A0(value, kf, vf, seen)
				else value

			if newKey ~= key then
				copy[key] = nil
				copy[newKey] = newValue
			elseif newValue ~= value then
				copy[key] = newValue
			end
		elseif type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R1_K2_V2_A0(value, kf, vf, seen)

			if newValue ~= value then
				copy[key] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 49: frozen=no, refs=no, key=none, value=all, array=yes
const function Copy_F0_R0_K0_V1_A1(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" then
			const newValue = Copy_F0_R0_K0_V1_A1(value, kf, vf)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	return copy
end

-- slot 50: frozen=preserve, refs=no, key=none, value=all, array=yes
const function Copy_F1_R0_K0_V1_A1(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" then
			const newValue = Copy_F1_R0_K0_V1_A1(value, kf, vf)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 51: frozen=no, refs=preserve, key=none, value=all, array=yes
const function Copy_F0_R1_K0_V1_A1(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" then
			const newValue = Copy_F0_R1_K0_V1_A1(value, kf, vf, seen)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	return copy
end

-- slot 52: frozen=preserve, refs=preserve, key=none, value=all, array=yes
const function Copy_F1_R1_K0_V1_A1(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" then
			const newValue = Copy_F1_R1_K0_V1_A1(value, kf, vf, seen)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 61: frozen=no, refs=no, key=none, value=condition, array=yes
const function Copy_F0_R0_K0_V2_A1(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R0_K0_V2_A1(value, kf, vf)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	return copy
end

-- slot 62: frozen=preserve, refs=no, key=none, value=condition, array=yes
const function Copy_F1_R0_K0_V2_A1(tbl: Map, kf: Condition, vf: Condition): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const copy = table.clone(tbl)

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R0_K0_V2_A1(value, kf, vf)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

-- slot 63: frozen=no, refs=preserve, key=none, value=condition, array=yes
const function Copy_F0_R1_K0_V2_A1(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" and vf(value) then
			const newValue = Copy_F0_R1_K0_V2_A1(value, kf, vf, seen)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	return copy
end

-- slot 64: frozen=preserve, refs=preserve, key=none, value=condition, array=yes
const function Copy_F1_R1_K0_V2_A1(tbl: Map, kf: Condition, vf: Condition, seen: Map<Map, Map>): Map
	if IsSingleton(tbl) then
		return tbl
	end

	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	const copy = table.clone(tbl)

	seen[tbl] = copy

	for i = 1, #tbl do
		const value = tbl[i]

		if type(value) == "table" and vf(value) then
			const newValue = Copy_F1_R1_K0_V2_A1(value, kf, vf, seen)

			if newValue ~= value then
				copy[i] = newValue
			end
		end
	end

	if table.isfrozen(tbl) then
		table.freeze(copy)
	end

	return copy
end

const Variants: { [number]: any } = {}

Variants[5] = Copy_F0_R0_K1_V0_A0
Variants[6] = Copy_F1_R0_K1_V0_A0
Variants[7] = Copy_F0_R1_K1_V0_A0
Variants[8] = Copy_F1_R1_K1_V0_A0
Variants[9] = Copy_F0_R0_K2_V0_A0
Variants[10] = Copy_F1_R0_K2_V0_A0
Variants[11] = Copy_F0_R1_K2_V0_A0
Variants[12] = Copy_F1_R1_K2_V0_A0
Variants[13] = Copy_F0_R0_K0_V1_A0
Variants[14] = Copy_F1_R0_K0_V1_A0
Variants[15] = Copy_F0_R1_K0_V1_A0
Variants[16] = Copy_F1_R1_K0_V1_A0
Variants[17] = Copy_F0_R0_K1_V1_A0
Variants[18] = Copy_F1_R0_K1_V1_A0
Variants[19] = Copy_F0_R1_K1_V1_A0
Variants[20] = Copy_F1_R1_K1_V1_A0
Variants[21] = Copy_F0_R0_K2_V1_A0
Variants[22] = Copy_F1_R0_K2_V1_A0
Variants[23] = Copy_F0_R1_K2_V1_A0
Variants[24] = Copy_F1_R1_K2_V1_A0
Variants[25] = Copy_F0_R0_K0_V2_A0
Variants[26] = Copy_F1_R0_K0_V2_A0
Variants[27] = Copy_F0_R1_K0_V2_A0
Variants[28] = Copy_F1_R1_K0_V2_A0
Variants[29] = Copy_F0_R0_K1_V2_A0
Variants[30] = Copy_F1_R0_K1_V2_A0
Variants[31] = Copy_F0_R1_K1_V2_A0
Variants[32] = Copy_F1_R1_K1_V2_A0
Variants[33] = Copy_F0_R0_K2_V2_A0
Variants[34] = Copy_F1_R0_K2_V2_A0
Variants[35] = Copy_F0_R1_K2_V2_A0
Variants[36] = Copy_F1_R1_K2_V2_A0
Variants[49] = Copy_F0_R0_K0_V1_A1
Variants[50] = Copy_F1_R0_K0_V1_A1
Variants[51] = Copy_F0_R1_K0_V1_A1
Variants[52] = Copy_F1_R1_K0_V1_A1
Variants[61] = Copy_F0_R0_K0_V2_A1
Variants[62] = Copy_F1_R0_K0_V2_A1
Variants[63] = Copy_F0_R1_K0_V2_A1
Variants[64] = Copy_F1_R1_K0_V2_A1

return {
	Variants = Variants,

	Mode = {
		None = 0,
		All = 1,
		Cond = 2,
	},

	Stride = {
		Frozen = 1,
		Refs = 2,
		Key = 4,
		Value = 12,
		Array = 36,
	},
}
