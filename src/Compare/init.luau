--!native
--!optimize 2

--- Types ---
const Types = require("./Types")

type Map<K = any, V = any> = Types.Map<K, V>

type CompareIgnore = { [any]: boolean }

type CompareIgnoreAtDepth = { [number]: CompareIgnore }

type CompareOptions = {
	Ignore: CompareIgnore?,
	IgnoreAtDepth: CompareIgnoreAtDepth?,
	AssumeAcyclic: boolean?,
	Array: boolean?,
}

-- Every generated entry is called with the same four arguments.
type Variant = (any, any, any, any) -> boolean

--- Variants ---
const CompareVariants = require("@self/CompareVariants")

-- Constants

const Variants = CompareVariants.Variants

const NONE = CompareVariants.IgnoreMode.None
const KEYS = CompareVariants.IgnoreMode.Keys
const DEPTH = CompareVariants.IgnoreMode.Depth
const BOTH = CompareVariants.IgnoreMode.Both

const STRIDE_CYCLES = CompareVariants.Stride.Cycles
const STRIDE_IGNORE = CompareVariants.Stride.Ignore
const STRIDE_ARRAY = CompareVariants.Stride.Array

--- No options: nothing ignored, cycles tracked, not an array.
const DefaultVariant: Variant = Variants[1 + STRIDE_CYCLES]

const VALID_FIELDS = {
	Ignore = true,
	IgnoreAtDepth = true,
	AssumeAcyclic = true,
	Array = true,
}

--- Functions ---

--- Returns a problem description for a bad Ignore set, else nil.
const function CheckIgnoreSet(set: any, name: string): string?
	for key, value in set do
		if type(value) ~= "boolean" then
			return `{name} must map keys to booleans, like {"{"} id = true {"}"}: key '{tostring(key)}' has a {typeof(
				value
			)} value`
		end
	end

	return nil
end

--[[ 
	Returns a problem description for bad options, else nil.
	The cheap type checks always run. Scanning the contents of the ignore sets
	and looking for unknown fields loops over them, so only Compile asks for it
	(strict).
]]
const function Validate(options: any, strict: boolean): string?
	if type(options) ~= "table" then
		return `options must be a table or nil, got {typeof(options)}`
	end

	const ignore = options.Ignore

	if ignore ~= nil then
		if type(ignore) ~= "table" then
			return `options.Ignore must be a table like {"{"} key = true {"}"}, got {typeof(ignore)}`
		end

		-- Cheap catch for the classic mistake { "id", "name" } instead of { id = true }.
		const first = ignore[1]

		if first ~= nil and type(first) ~= "boolean" then
			return `options.Ignore looks like a list: it must map keys to booleans, like {"{"} id = true {"}"}`
		end
	end

	const ignoreAtDepth = options.IgnoreAtDepth

	if ignoreAtDepth ~= nil and type(ignoreAtDepth) ~= "table" then
		return `options.IgnoreAtDepth must be a table like {"{"} [1] = {"{"} key = true {"}"} {"}"}, got {typeof(
			ignoreAtDepth
		)}`
	end

	const assumeAcyclic = options.AssumeAcyclic

	if assumeAcyclic ~= nil and type(assumeAcyclic) ~= "boolean" then
		return `options.AssumeAcyclic must be a boolean, got {typeof(assumeAcyclic)}`
	end

	const array = options.Array

	if array ~= nil and type(array) ~= "boolean" then
		return `options.Array must be a boolean, got {typeof(array)}`
	end

	if array == true then
		if (ignore ~= nil and next(ignore) ~= nil) or (ignoreAtDepth ~= nil and next(ignoreAtDepth) ~= nil) then
			return "Array = true cannot be combined with Ignore or IgnoreAtDepth"
		end
	end

	if strict then
		for field in options do
			if VALID_FIELDS[field] == nil then
				return `unknown option '{tostring(field)}' (valid: Ignore, IgnoreAtDepth, AssumeAcyclic, Array)`
			end
		end

		if ignore ~= nil then
			const problem = CheckIgnoreSet(ignore, "options.Ignore")

			if problem ~= nil then
				return problem
			end
		end

		if ignoreAtDepth ~= nil then
			for depth, set in ignoreAtDepth do
				if type(depth) ~= "number" then
					return `options.IgnoreAtDepth keys must be depth numbers (starting at 1), got a {typeof(depth)} key`
				end

				if type(set) ~= "table" then
					return `options.IgnoreAtDepth[{depth}] must be a table like {"{"} key = true {"}"}, got {typeof(set)}`
				end

				const problem = CheckIgnoreSet(set, `options.IgnoreAtDepth[{depth}]`)

				if problem ~= nil then
					return problem
				end
			end
		end
	end

	return nil
end

--[[ 
	Validates the options, reads them once and picks the specialized variant.
	Returns the sets to pass along (nil for the ones the variant does not use)
	and whether the variant needs them at all.
]]
const function Resolve(options: CompareOptions, strict: boolean): (Variant, any, any, boolean)
	const problem = Validate(options, strict)

	if problem ~= nil then
		-- Level 3 points at the caller of Compare / Compile.
		error("MiTable.Compare: " .. problem, 3)
	end

	const ignore = options.Ignore
	const ignoreAtDepth = options.IgnoreAtDepth

	-- Empty sets ignore nothing, so they take the fast path.
	const hasIgnore = ignore ~= nil and next(ignore) ~= nil
	const hasDepth = ignoreAtDepth ~= nil and next(ignoreAtDepth) ~= nil

	local mode = NONE

	if hasIgnore then
		mode = if hasDepth then BOTH else KEYS
	elseif hasDepth then
		mode = DEPTH
	end

	local slot = 1 + mode * STRIDE_IGNORE

	if options.AssumeAcyclic ~= true then
		slot += STRIDE_CYCLES
	end

	if options.Array == true then
		slot += STRIDE_ARRAY
	end

	const variant: Variant? = Variants[slot]

	if variant == nil then
		error(`MiTable.Compare: no variant for slot {slot}, regenerate CompareVariants with tools/gen_compare.py`)
	end

	return variant, if hasIgnore then ignore else nil, if hasDepth then ignoreAtDepth else nil, mode ~= NONE
end

const function Compare(a: Map, b: Map, options: CompareOptions?): boolean
	if options == nil then
		return DefaultVariant(a, b, nil, nil)
	end

	const variant, ignore, ignoreAtDepth = Resolve(options, false)

	return variant(a, b, ignore, ignoreAtDepth)
end

--[[
	Does the options work once and returns a function that compares with them.
	Use this when the same options are used many times.
	Also rejects unknown options and ignore sets that are not key -> boolean maps.
]]
const function Compile(options: CompareOptions): (Map, Map) -> boolean
	const variant, ignore, ignoreAtDepth, usesIgnore = Resolve(options, true)

	if not usesIgnore then
		-- the variant ignores its last two arguments, so it can be used as is
		return variant
	end

	return function(a: Map, b: Map): boolean
		return variant(a, b, ignore, ignoreAtDepth)
	end
end

--[[
	Deeply compares two tables by structure.

	Ignore:
		Keys ignored at every depth, as { key = true }.

	IgnoreAtDepth:
		Keys ignored only at specified depths, as { [depth] = { key = true } }.
		Depth starts at 1 for keys inside the root table.

	AssumeAcyclic:
		Promises that neither table contains a cycle. Skips all cycle and
		shared-reference bookkeeping, which is faster. A cycle then errors with
		a stack overflow. The tables are compared as trees: a table that is
		shared in one input and duplicated in the other still compares equal.
		Without this option, shared structure has to match too.

	Array:
		Promises that every compared table is a pure array (1..#t, no holes).
		Compares the length and the values by index. Cannot be combined with
		Ignore or IgnoreAtDepth. Named fields are not compared.

	Singleton tables are never equal to a different table.
]]
return {
	Compare = Compare,
	Compile = Compile,
}
