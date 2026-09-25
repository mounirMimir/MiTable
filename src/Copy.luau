--!native
--!optimize 2

--// Types

const Types = require("./Types")

type table<K = any, V = any> = Types.table<K, V>

-- Condition must return true for the table to be deeply copied else get references
type DeepCopyCondition = (tbl: table) -> boolean

-- All conditions are ANDed together.
type DeepCopyConditions = { DeepCopyCondition }

type DeepCopySettings = {
	PreserveFrozen: boolean,
	ExtraConditions: DeepCopyConditions,
}

type DeepCopyOption = boolean | DeepCopySettings

type CopyDeepConfig = {
	Key: DeepCopyOption?,
	Value: DeepCopyOption?,
	PreserveReferences: boolean?,
}

type CopyConfig = {
	Deep: true | CopyDeepConfig,
}

--// Functions

const function CheckConditions(tbl: table, conditions: DeepCopyConditions): boolean
	for i = 1, #conditions do
		if not conditions[i](tbl) then
			return false
		end
	end

	return true
end

const function DeepCopyAll(tbl: table, preserveFrozen: boolean): table
	local copy: table = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			key = DeepCopyAll(key, preserveFrozen)
		end

		if type(value) == "table" then
			value = DeepCopyAll(value, preserveFrozen)
		end

		copy[key] = value

		--[[copy[if type(key) == "table" then DeepCopyAll(key, preserveFrozen) else key] = if type(value) == "table"
			then DeepCopyAll(value, preserveFrozen)
			else value]]
	end

	if preserveFrozen and table.isfrozen(tbl) then
		return table.freeze(copy)
	end

	return copy
end

const function DeepCopyAllReferenced(tbl: table, preserveFrozen: boolean, seen: { [table]: table }): table
	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	local copy = table.clone(tbl)
	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			key = DeepCopyAllReferenced(key, preserveFrozen, seen)
		end

		if type(value) == "table" then
			value = DeepCopyAllReferenced(value, preserveFrozen, seen)
		end

		copy[key] = value
	end

	if preserveFrozen and table.isfrozen(tbl) then
		copy = table.freeze(copy)
		seen[tbl] = copy
	end

	return copy
end

const function DeepCopyKeys(tbl: table, preserveFrozen: boolean): table
	local copy: table = table.clone(tbl)

	for key, value in tbl do
		if type(key) == "table" then
			key = DeepCopyKeys(key, preserveFrozen)
		end

		copy[key] = value
	end

	if preserveFrozen and table.isfrozen(tbl) then
		return table.freeze(copy)
	end

	return copy
end

const function DeepCopyKeysReferenced(tbl: table, preserveFrozen: boolean, seen: { [table]: table }): table
	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	local copy = table.clone(tbl)
	seen[tbl] = copy

	for key, value in tbl do
		if type(key) == "table" then
			key = DeepCopyKeysReferenced(key, preserveFrozen, seen)
		end

		copy[key] = value
	end

	if preserveFrozen and table.isfrozen(tbl) then
		copy = table.freeze(copy)
		seen[tbl] = copy
	end

	return copy
end

const function DeepCopyValues(tbl: table, preserveFrozen: boolean): table
	local copy: table = table.clone(tbl)

	for key, value in tbl do
		if type(value) == "table" then
			value = DeepCopyValues(value, preserveFrozen)
		end

		copy[key] = value
	end

	if preserveFrozen and table.isfrozen(tbl) then
		return table.freeze(copy)
	end

	return copy
end

const function DeepCopyValuesReferenced(tbl: table, preserveFrozen: boolean, seen: { [table]: table }): table
	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	local copy = table.clone(tbl)
	seen[tbl] = copy

	for key, value in tbl do
		if type(value) == "table" then
			value = DeepCopyValuesReferenced(value, preserveFrozen, seen)
		end

		copy[key] = value
	end

	if preserveFrozen and table.isfrozen(tbl) then
		copy = table.freeze(copy)
		seen[tbl] = copy
	end

	return copy
end

const function DeepCopyConfigured(
	tbl: table,

	keyDeepCopy: boolean,
	keySettings: DeepCopySettings?,

	valueDeepCopy: boolean,
	valueSettings: DeepCopySettings?,

	preserveFrozen: boolean
): table
	local copy: table = table.clone(tbl)

	const keyConditions = if keySettings ~= nil then keySettings.ExtraConditions else nil

	const valueConditions = if valueSettings ~= nil then valueSettings.ExtraConditions else nil

	for key, value in tbl do
		if type(key) == "table" then
			if keyDeepCopy or (keySettings ~= nil and CheckConditions(key, keyConditions :: DeepCopyConditions)) then
				key = DeepCopyConfigured(key, keyDeepCopy, keySettings, valueDeepCopy, valueSettings, preserveFrozen)
			end
		end

		if type(value) == "table" then
			if
				valueDeepCopy
				or (valueSettings ~= nil and CheckConditions(value, valueConditions :: DeepCopyConditions))
			then
				value =
					DeepCopyConfigured(value, keyDeepCopy, keySettings, valueDeepCopy, valueSettings, preserveFrozen)
			end
		end

		copy[key] = value
	end

	if preserveFrozen and table.isfrozen(tbl) then
		return table.freeze(copy)
	end

	return copy
end

const function DeepCopyConfiguredReferenced(
	tbl: table,

	keyDeepCopy: boolean,
	keySettings: DeepCopySettings?,

	valueDeepCopy: boolean,
	valueSettings: DeepCopySettings?,

	preserveFrozen: boolean,

	seen: { [table]: table }
): table
	const existing = seen[tbl]

	if existing ~= nil then
		return existing
	end

	local copy = table.clone(tbl)
	seen[tbl] = copy

	const keyConditions = if keySettings ~= nil then keySettings.ExtraConditions else nil

	const valueConditions = if valueSettings ~= nil then valueSettings.ExtraConditions else nil

	for key, value in tbl do
		if type(key) == "table" then
			if keyDeepCopy or (keySettings ~= nil and CheckConditions(key, keyConditions :: DeepCopyConditions)) then
				key = DeepCopyConfiguredReferenced(
					key,
					keyDeepCopy,
					keySettings,
					valueDeepCopy,
					valueSettings,
					preserveFrozen,
					seen
				)
			end
		end

		if type(value) == "table" then
			if
				valueDeepCopy
				or (valueSettings ~= nil and CheckConditions(value, valueConditions :: DeepCopyConditions))
			then
				value = DeepCopyConfiguredReferenced(
					value,
					keyDeepCopy,
					keySettings,
					valueDeepCopy,
					valueSettings,
					preserveFrozen,
					seen
				)
			end
		end

		copy[key] = value
	end

	if preserveFrozen and table.isfrozen(tbl) then
		copy = table.freeze(copy)
		seen[tbl] = copy
	end

	return copy
end

const function ResolveOption(option: DeepCopyOption?): (boolean, DeepCopySettings?)
	if option == true then
		return true, nil
	end

	if type(option) == "table" then
		return false, option
	end

	return false, nil
end

const function HasNoConditions(settings: DeepCopySettings?): boolean
	return settings == nil or #settings.ExtraConditions == 0
end

--[[
	Deep-copies a table according to the supplied configuration.

	Deep:
		true  -> Deep-copy keys and values.
		false -> Do not deep-copy that side.
		Settings -> Deep-copy that side only when all conditions pass.

	PreserveFrozen:
		Preserves the frozen state of copied tables.

	PreserveReferences:
		Preserves circular and shared table references.
		Disabled by default for better performance.

	ExtraConditions:
		All conditions must pass for a table to be copied.
		If a condition fails, the original reference is kept.

	When Key is enabled:
		Table keys are also recursively copied.
]]
return function<T>(tb: T, config: CopyConfig?): T
	if config == nil then
		return table.clone(tb)
	end

	const deep = config.Deep

	if deep == true then
		return DeepCopyAll(tb, false)
	end

	const keyOption = deep.Key
	const valueOption = deep.Value
	const preserveReferences = deep.PreserveReferences == true

	const keyDeepCopy, keySettings = ResolveOption(keyOption)
	const valueDeepCopy, valueSettings = ResolveOption(valueOption)

	if not keyDeepCopy and keySettings == nil and not valueDeepCopy and valueSettings == nil then
		return table.clone(tb)
	end

	const preserveFrozen = (keySettings ~= nil and keySettings.PreserveFrozen)
		or (valueSettings ~= nil and valueSettings.PreserveFrozen)

	if HasNoConditions(keySettings) and HasNoConditions(valueSettings) then
		if keyDeepCopy and valueDeepCopy then
			if preserveReferences then
				return DeepCopyAllReferenced(tb, preserveFrozen, {})
			end

			return DeepCopyAll(tb, preserveFrozen)
		end

		if keyDeepCopy then
			if preserveReferences then
				return DeepCopyKeysReferenced(tb, preserveFrozen, {})
			end

			return DeepCopyKeys(tb, preserveFrozen)
		end

		if valueDeepCopy then
			if preserveReferences then
				return DeepCopyValuesReferenced(tb, preserveFrozen, {})
			end

			return DeepCopyValues(tb, preserveFrozen)
		end
	end

	if preserveReferences then
		return DeepCopyConfiguredReferenced(
			tb,
			keyDeepCopy,
			keySettings,
			valueDeepCopy,
			valueSettings,
			preserveFrozen,
			{}
		)
	end

	return DeepCopyConfigured(tb, keyDeepCopy, keySettings, valueDeepCopy, valueSettings, preserveFrozen)
end
