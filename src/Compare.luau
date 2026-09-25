--!native

--!optimize 2

--// Types

const Types = require("./Types")

type table<K = any, V = any> = Types.table<K, V>

type CompareIgnore = { [any]: boolean }

type CompareIgnoreAtDepth = { [number]: CompareIgnore }

type CompareOptions = {
	Ignore: CompareIgnore?,
	IgnoreAtDepth: CompareIgnoreAtDepth?,
}

--// Functions

const function DeepCompare(a: any, b: any, seenA: table<table, table>, seenB: table<table, table>): boolean
	if a == b then
		return true
	end

	const typeA = type(a)

	if typeA ~= type(b) then
		return false
	end

	if typeA ~= "table" then
		return false
	end

	const mappedB = seenA[a]

	if mappedB ~= nil then
		return mappedB == b
	end

	const mappedA = seenB[b]

	if mappedA ~= nil then
		return mappedA == a
	end

	seenA[a] = b
	seenB[b] = a

	local count = 0

	for _ in pairs(b) do
		count += 1
	end

	for key, value in pairs(a) do
		count -= 1

		if count < 0 then
			return false
		end

		if b[key] == nil then
			return false
		end

		if not DeepCompare(value, b[key], seenA, seenB) then
			return false
		end
	end

	return count == 0
end

const function DeepCompareIgnore(
	a: any,
	b: any,
	ignore: CompareIgnore,
	seenA: table<table, table>,
	seenB: table<table, table>
): boolean
	if a == b then
		return true
	end

	const typeA = type(a)

	if typeA ~= type(b) then
		return false
	end

	if typeA ~= "table" then
		return false
	end

	const mappedB = seenA[a]

	if mappedB ~= nil then
		return mappedB == b
	end

	const mappedA = seenB[b]

	if mappedA ~= nil then
		return mappedA == a
	end

	seenA[a] = b
	seenB[b] = a

	local count = 0

	for key in pairs(b) do
		if ignore[key] ~= true then
			count += 1
		end
	end

	for key, value in pairs(a) do
		if ignore[key] ~= true then
			count -= 1

			if count < 0 then
				return false
			end

			if b[key] == nil then
				return false
			end

			if not DeepCompareIgnore(value, b[key], ignore, seenA, seenB) then
				return false
			end
		end
	end

	return count == 0
end

const function DeepCompareIgnoreAtDepth(
	a: any,
	b: any,
	ignoreAtDepth: CompareIgnoreAtDepth,
	depth: number,
	seenA: table<table, table>,
	seenB: table<table, table>
): boolean
	if a == b then
		return true
	end

	const typeA = type(a)

	if typeA ~= type(b) then
		return false
	end

	if typeA ~= "table" then
		return false
	end

	const mappedB = seenA[a]

	if mappedB ~= nil then
		return mappedB == b
	end

	const mappedA = seenB[b]

	if mappedA ~= nil then
		return mappedA == a
	end

	seenA[a] = b
	seenB[b] = a

	const ignored = ignoreAtDepth[depth]

	local count = 0

	if ignored == nil then
		for _ in pairs(b) do
			count += 1
		end

		for key, value in pairs(a) do
			count -= 1

			if count < 0 then
				return false
			end

			if b[key] == nil then
				return false
			end

			if not DeepCompareIgnoreAtDepth(value, b[key], ignoreAtDepth, depth + 1, seenA, seenB) then
				return false
			end
		end
	else
		for key in pairs(b) do
			if ignored[key] ~= true then
				count += 1
			end
		end

		for key, value in pairs(a) do
			if ignored[key] ~= true then
				count -= 1

				if count < 0 then
					return false
				end

				if b[key] == nil then
					return false
				end

				if not DeepCompareIgnoreAtDepth(value, b[key], ignoreAtDepth, depth + 1, seenA, seenB) then
					return false
				end
			end
		end
	end

	return count == 0
end

const function DeepCompareIgnoreBoth(
	a: any,
	b: any,
	ignore: CompareIgnore,
	ignoreAtDepth: CompareIgnoreAtDepth,
	depth: number,
	seenA: table<table, table>,
	seenB: table<table, table>
): boolean
	if a == b then
		return true
	end

	const typeA = type(a)

	if typeA ~= type(b) then
		return false
	end

	if typeA ~= "table" then
		return false
	end

	const mappedB = seenA[a]

	if mappedB ~= nil then
		return mappedB == b
	end

	const mappedA = seenB[b]

	if mappedA ~= nil then
		return mappedA == a
	end

	seenA[a] = b
	seenB[b] = a

	const ignoredAtDepth = ignoreAtDepth[depth]

	local count = 0

	for key in pairs(b) do
		if ignore[key] ~= true and (ignoredAtDepth == nil or ignoredAtDepth[key] ~= true) then
			count += 1
		end
	end

	for key, value in pairs(a) do
		if ignore[key] ~= true and (ignoredAtDepth == nil or ignoredAtDepth[key] ~= true) then
			count -= 1

			if count < 0 then
				return false
			end

			if b[key] == nil then
				return false
			end

			if not DeepCompareIgnoreBoth(value, b[key], ignore, ignoreAtDepth, depth + 1, seenA, seenB) then
				return false
			end
		end
	end

	return count == 0
end

--[[
	Deeply compares two tables by structure.

	Ignore:
		Keys ignored at every depth.

	IgnoreAtDepth:
		Keys ignored only at specified depths.

	Depth starts at 1 for keys inside the root table.
]]
return function(a: table, b: table, options: CompareOptions?): boolean
	if options == nil then
		return DeepCompare(a, b, {}, {})
	end

	const ignore = options.Ignore
	const ignoreAtDepth = options.IgnoreAtDepth

	if ignore == nil then
		if ignoreAtDepth == nil then
			return DeepCompare(a, b, {}, {})
		end

		return DeepCompareIgnoreAtDepth(a, b, ignoreAtDepth, 1, {}, {})
	end

	if ignoreAtDepth == nil then
		return DeepCompareIgnore(a, b, ignore, {}, {})
	end

	return DeepCompareIgnoreBoth(a, b, ignore, ignoreAtDepth, 1, {}, {})
end
