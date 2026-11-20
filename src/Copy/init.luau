--!native
--!optimize 2

--- Types ---
const Types = require("./Types")

type Map<K = any, V = any> = Types.Map<K, V>

--[[
	Must return true for the table to be deeply copied, else the reference is kept.
	Combine checks (and / or / not) inside the one function.
]]
type DeepCopyCondition = (tbl: Map) -> boolean

type DeepCopyOption = boolean | DeepCopyCondition

type CopyDeepConfig = {
	Key: DeepCopyOption?,
	Value: DeepCopyOption?,
}

--- Every generated variant is called with the same four arguments.
type Variant = (Map, DeepCopyCondition, DeepCopyCondition, Map?) -> any

type CopyConfig = {
	Deep: true | CopyDeepConfig,
	PreserveFrozen: boolean?,
	PreserveReferences: boolean?,
	Array: boolean?,
}

const Singletons = require("./Singletons")
const CopyVariants = require("@self/CopyVariants")

--- Constants ---

const Variants = CopyVariants.Variants

const NONE = CopyVariants.Mode.None
const ALL = CopyVariants.Mode.All
const COND = CopyVariants.Mode.Cond

const STRIDE_FROZEN = CopyVariants.Stride.Frozen
const STRIDE_REFS = CopyVariants.Stride.Refs
const STRIDE_KEY = CopyVariants.Stride.Key
const STRIDE_VALUE = CopyVariants.Stride.Value
const STRIDE_ARRAY = CopyVariants.Stride.Array

const VALID_CONFIG_FIELDS = {
	Deep = true,
	PreserveFrozen = true,
	PreserveReferences = true,
	Array = true,
}

const VALID_DEEP_FIELDS = {
	Key = true,
	Value = true,
}

--- Passed for a side that does not use a condition; never called.
const function Unused(_tbl: Map): boolean
	return true
end

--- Functions ---

const IsSingleton = Singletons.Is

--- Returns a problem description for a bad Key / Value option, else nil.
const function CheckOption(option: any, name: string): string?
	if option == nil then
		return nil
	end

	const kind = type(option)

	if kind == "boolean" or kind == "function" then
		return nil
	end

	if kind == "table" and option.ExtraConditions ~= nil then
		return `Deep.{name}.ExtraConditions was removed: pass one function that does all the checks (and / or / not)`
	end

	return `Deep.{name} must be a boolean or a function, got {typeof(option)}`
end

--[[
	Returns a problem description for a bad config, else nil.
	The cheap type checks always run. The scan for unknown fields (typos, oldconfig shapes) 
	loops over the config, so only Compile asks for it (strict).
]]
const function Validate(config: any, strict: boolean): string?
	if type(config) ~= "table" then
		return `config must be a table or nil, got {typeof(config)}`
	end

	const deep = config.Deep

	if deep == nil then
		return "config.Deep is required: true, or a table with Key and / or Value"
	end

	if deep ~= true and type(deep) ~= "table" then
		return `config.Deep must be true or a table, got {typeof(deep)} (use Copy(tb) for a shallow copy)`
	end

	const preserveFrozen = config.PreserveFrozen

	if preserveFrozen ~= nil and type(preserveFrozen) ~= "boolean" then
		return `config.PreserveFrozen must be a boolean, got {typeof(preserveFrozen)}`
	end

	const preserveReferences = config.PreserveReferences

	if preserveReferences ~= nil and type(preserveReferences) ~= "boolean" then
		return `config.PreserveReferences must be a boolean, got {typeof(preserveReferences)}`
	end

	const array = config.Array

	if array ~= nil and type(array) ~= "boolean" then
		return `config.Array must be a boolean, got {typeof(array)}`
	end

	if deep ~= true then
		if deep.PreserveReferences ~= nil or deep.PreserveFrozen ~= nil then
			return "PreserveFrozen and PreserveReferences are not part of Deep anymore: put them directly in the config"
		end

		const keyProblem = CheckOption(deep.Key, "Key")

		if keyProblem ~= nil then
			return keyProblem
		end

		const valueProblem = CheckOption(deep.Value, "Value")

		if valueProblem ~= nil then
			return valueProblem
		end

		if array == true and deep.Key ~= nil and deep.Key ~= false then
			return "Array = true cannot be combined with Deep.Key"
		end
	end

	if strict then
		for field in config do
			if VALID_CONFIG_FIELDS[field] == nil then
				return `unknown config field '{tostring(field)}' (valid: Deep, PreserveFrozen, PreserveReferences, Array)`
			end
		end

		if deep ~= true then
			for field in deep do
				if VALID_DEEP_FIELDS[field] == nil then
					return `unknown field 'Deep.{tostring(field)}' (valid: Key, Value)`
				end
			end
		end
	end

	return nil
end

--- Turns a Key / Value option into a mode and the condition it uses.
const function ResolveOption(option: DeepCopyOption?): (number, DeepCopyCondition)
	if option == true then
		return ALL, Unused
	end

	if type(option) == "function" then
		return COND, option
	end

	return NONE, Unused
end

--[[
	Reads the config once and picks the specialized variant for it.
	Returns nil as the variant when the result is a plain table.clone.
]]
const function Resolve(config: CopyConfig, strict: boolean): (Variant?, DeepCopyCondition, DeepCopyCondition, boolean)
	const problem = Validate(config, strict)

	if problem ~= nil then
		error("MiTable.Copy: " .. problem, 3)
	end

	const deep = config.Deep
	const array = config.Array == true

	local keyMode = NONE
	local valueMode = NONE
	local keyCondition = Unused
	local valueCondition = Unused

	if deep == true then
		keyMode = if array then NONE else ALL
		valueMode = ALL
	else
		if array and deep.Key ~= nil and deep.Key ~= false then
			error("MiTable.Copy: Array = true cannot be combined with Deep.Key")
		end

		keyMode, keyCondition = ResolveOption(deep.Key)
		valueMode, valueCondition = ResolveOption(deep.Value)
	end

	if keyMode == NONE and valueMode == NONE then
		return nil, Unused, Unused, false
	end

	const preserveFrozen = config.PreserveFrozen == true
	const preserveReferences = config.PreserveReferences == true

	local slot = 1 + keyMode * STRIDE_KEY + valueMode * STRIDE_VALUE

	if array then
		slot += STRIDE_ARRAY
	end

	if preserveReferences then
		slot += STRIDE_REFS
	end

	if preserveFrozen then
		slot += STRIDE_FROZEN
	end

	const variant: Variant? = Variants[slot]

	if variant == nil then
		error(`MiTable.Copy: no variant for slot {slot}`)
	end

	return variant, keyCondition, valueCondition, preserveReferences
end

const function Copy<T>(tb: T, config: CopyConfig?): T
	if type(tb) ~= "table" then
		error(`MiTable.Copy: expected a table, got {typeof(tb)}`, 2)
	end

	if IsSingleton(tb) then
		return tb :: any
	end

	if config == nil then
		return table.clone(tb)
	end

	const variant, keyCondition, valueCondition, preserveReferences = Resolve(config, false)

	if variant == nil then
		return table.clone(tb)
	end

	return variant(tb, keyCondition, valueCondition, if preserveReferences then {} else nil)
end

--[[
	Does the config work once and returns a function that copies with it.
	Use this when the same configuration is used many times.
]]
const function Compile<T>(config: CopyConfig): (T) -> T
	const variant, keyCondition, valueCondition, preserveReferences = Resolve(config, true)

	if variant == nil then
		return function(tb: T): T
			if IsSingleton(tb) then
				return tb
			end

			return table.clone(tb)
		end
	end

	if preserveReferences then
		return function(tb: T): T
			return variant(tb, keyCondition, valueCondition, {})
		end
	end

	return function(tb: T): T
		return variant(tb, keyCondition, valueCondition)
	end
end

--[[
	Deep-copies a table according to the supplied configuration.

	Deep:
		true     -> Deep-copy keys and values.
		false    -> Do not deep-copy that side.
		function -> Deep-copy that side only when the function returns true for
		            the table. Do all checks inside it (and / or / not).

	PreserveFrozen:
		Freezes every copy whose original was frozen.

	PreserveReferences:
		Preserves circular and shared table references.

	Array:
		Promises that every copied table is a pure array (1..#t, no holes).
		Copies values only with a numeric loop. Deep.Key must not be set.
		The promise covers the whole tree: nested tables are walked as arrays too.

	Singleton tables are always kept as their original references..
]]
return {
	Copy = Copy,
	Compile = Compile,
}
