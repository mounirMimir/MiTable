--!native
--!optimize 2

type table<K = any, V = any> = { [K]: V }

type DeepCopyCondition = (tbl: table) -> boolean
type DeepCopyConditions = { DeepCopyCondition }

type DeepCopySettings = {
	PreserveFrozen: boolean?,
	ExtraConditions: DeepCopyConditions?,
}

type CopyConfig = {
	Deep: {
		Key: DeepCopySettings?,
		Value: DeepCopySettings?,
	}?,
}

const MiTable = {}

--[[
	Checks whether a table satisfies all conditions.
]]
const function CheckConditions(tbl: table, conditions: DeepCopyConditions): boolean
	for i = 1, #conditions do
		if not conditions[i](tbl) then
			return false
		end
	end

	return true
end

--[[
	Recursively copies a table.
]]
const function DeepCopy(
	tbl: table,
	keySettings: DeepCopySettings?,
	valueSettings: DeepCopySettings?,
	seen: { [table]: table }
): table
	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	local copy = {}
	seen[tbl] = copy

	const keyConditions = keySettings and keySettings.ExtraConditions
	const valueConditions = valueSettings and valueSettings.ExtraConditions

	for key, value in tbl do
		if type(key) == "table" and keySettings ~= nil then
			if keyConditions == nil or CheckConditions(key, keyConditions) then
				key = DeepCopy(key, keySettings, valueSettings, seen)
			end
		end

		if type(value) == "table" and valueSettings ~= nil then
			if valueConditions == nil or CheckConditions(value, valueConditions) then
				value = DeepCopy(value, keySettings, valueSettings, seen)
			end
		end

		copy[key] = value
	end

	if table.isfrozen(tbl) then
		const preserveFrozen = (keySettings ~= nil and keySettings.PreserveFrozen == true)
			or (valueSettings ~= nil and valueSettings.PreserveFrozen == true)

		if preserveFrozen then
			copy = table.freeze(copy)
			seen[tbl] = copy
		end
	end

	return copy
end

function MiTable.Copy<T>(tb: T, config: CopyConfig?): T
	if config == nil or config.Deep == nil then
		return table.clone(tb)
	end

	const deep = config.Deep
	const keySettings = deep.Key
	const valueSettings = deep.Value

	if keySettings == nil and valueSettings == nil then
		return table.clone(tb)
	end

	return DeepCopy(tb, keySettings, valueSettings, {})
end

return MiTable
