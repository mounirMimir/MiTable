--!native
--!optimize 2

--[[
	GENERATED FILE - DO NOT EDIT BY HAND.

	Every function below is one specialized variant of Compare. Workers only
	ever recurse into themselves, so the configuration is fixed for the whole
	comparison. Each worker is only called with two DIFFERENT tables.

	slot = 1 + cycles*1 + ignore*2 + array*8
]]

const Types = require("../Types")
const Singletons = require("../Singletons")


const IsSingleton = Singletons.Is

type Map<K = any, V = any> = Types.Map<K, V>

type Ignore = { [any]: boolean }
type IgnoreAtDepth = { [number]: Ignore }

-- slot 1: cycles=assumed none, ignore=none, array=no
const function Compare_C0_I0_A0(a: Map, b: Map): boolean
	if IsSingleton(a) or IsSingleton(b) then
		return false
	end

	local count = 0

	for _ in pairs(b) do
		count += 1
	end

	for key, value in pairs(a) do
		count -= 1

		if count < 0 then
			return false
		end

		const other = b[key]

		if value ~= other then
			if type(value) ~= "table" or type(other) ~= "table" or not Compare_C0_I0_A0(value, other) then
				return false
			end
		end
	end

	return count == 0
end

const function Entry_C0_I0_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C0_I0_A0(a, b)
end

-- slot 2: cycles=tracked, ignore=none, array=no
const function Compare_C1_I0_A0(a: Map, b: Map, seenA: Map<Map, Map>, seenB: Map<Map, Map>): boolean
	if IsSingleton(a) or IsSingleton(b) then
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

		const other = b[key]

		if value ~= other then
			if type(value) ~= "table" or type(other) ~= "table" or not Compare_C1_I0_A0(value, other, seenA, seenB) then
				return false
			end
		end
	end

	return count == 0
end

const function Entry_C1_I0_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C1_I0_A0(a, b, {}, {})
end

-- slot 3: cycles=assumed none, ignore=keys, array=no
const function Compare_C0_I1_A0(a: Map, b: Map, ignore: Ignore): boolean
	if IsSingleton(a) or IsSingleton(b) then
		return false
	end

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

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C0_I1_A0(value, other, ignore) then
					return false
				end
			end
		end
	end

	return count == 0
end

const function Entry_C0_I1_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C0_I1_A0(a, b, ignore)
end

-- slot 4: cycles=tracked, ignore=keys, array=no
const function Compare_C1_I1_A0(a: Map, b: Map, ignore: Ignore, seenA: Map<Map, Map>, seenB: Map<Map, Map>): boolean
	if IsSingleton(a) or IsSingleton(b) then
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

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C1_I1_A0(value, other, ignore, seenA, seenB) then
					return false
				end
			end
		end
	end

	return count == 0
end

const function Entry_C1_I1_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C1_I1_A0(a, b, ignore, {}, {})
end

-- slot 5: cycles=assumed none, ignore=keys at depth, array=no
const function Compare_C0_I2_A0(a: Map, b: Map, ignoreAtDepth: IgnoreAtDepth, depth: number): boolean
	if IsSingleton(a) or IsSingleton(b) then
		return false
	end

	const ignored = ignoreAtDepth[depth]

	if ignored == nil then
		local count = 0

		for _ in pairs(b) do
			count += 1
		end

		for key, value in pairs(a) do
			count -= 1

			if count < 0 then
				return false
			end

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C0_I2_A0(value, other, ignoreAtDepth, depth + 1) then
					return false
				end
			end
		end

		return count == 0
	end

	local count = 0

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

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C0_I2_A0(value, other, ignoreAtDepth, depth + 1) then
					return false
				end
			end
		end
	end

	return count == 0
end

const function Entry_C0_I2_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C0_I2_A0(a, b, ignoreAtDepth, 1)
end

-- slot 6: cycles=tracked, ignore=keys at depth, array=no
const function Compare_C1_I2_A0(a: Map, b: Map, ignoreAtDepth: IgnoreAtDepth, depth: number, seenA: Map<Map, Map>, seenB: Map<Map, Map>): boolean
	if IsSingleton(a) or IsSingleton(b) then
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

	if ignored == nil then
		local count = 0

		for _ in pairs(b) do
			count += 1
		end

		for key, value in pairs(a) do
			count -= 1

			if count < 0 then
				return false
			end

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C1_I2_A0(value, other, ignoreAtDepth, depth + 1, seenA, seenB) then
					return false
				end
			end
		end

		return count == 0
	end

	local count = 0

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

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C1_I2_A0(value, other, ignoreAtDepth, depth + 1, seenA, seenB) then
					return false
				end
			end
		end
	end

	return count == 0
end

const function Entry_C1_I2_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C1_I2_A0(a, b, ignoreAtDepth, 1, {}, {})
end

-- slot 7: cycles=assumed none, ignore=keys + keys at depth, array=no
const function Compare_C0_I3_A0(a: Map, b: Map, ignore: Ignore, ignoreAtDepth: IgnoreAtDepth, depth: number): boolean
	if IsSingleton(a) or IsSingleton(b) then
		return false
	end

	const ignored = ignoreAtDepth[depth]

	if ignored == nil then
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

				const other = b[key]

				if value ~= other then
					if type(value) ~= "table" or type(other) ~= "table" or not Compare_C0_I3_A0(value, other, ignore, ignoreAtDepth, depth + 1) then
						return false
					end
				end
			end
		end

		return count == 0
	end

	local count = 0

	for key in pairs(b) do
		if ignore[key] ~= true and ignored[key] ~= true then
			count += 1
		end
	end

	for key, value in pairs(a) do
		if ignore[key] ~= true and ignored[key] ~= true then
			count -= 1

			if count < 0 then
				return false
			end

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C0_I3_A0(value, other, ignore, ignoreAtDepth, depth + 1) then
					return false
				end
			end
		end
	end

	return count == 0
end

const function Entry_C0_I3_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C0_I3_A0(a, b, ignore, ignoreAtDepth, 1)
end

-- slot 8: cycles=tracked, ignore=keys + keys at depth, array=no
const function Compare_C1_I3_A0(a: Map, b: Map, ignore: Ignore, ignoreAtDepth: IgnoreAtDepth, depth: number, seenA: Map<Map, Map>, seenB: Map<Map, Map>): boolean
	if IsSingleton(a) or IsSingleton(b) then
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

	if ignored == nil then
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

				const other = b[key]

				if value ~= other then
					if type(value) ~= "table" or type(other) ~= "table" or not Compare_C1_I3_A0(value, other, ignore, ignoreAtDepth, depth + 1, seenA, seenB) then
						return false
					end
				end
			end
		end

		return count == 0
	end

	local count = 0

	for key in pairs(b) do
		if ignore[key] ~= true and ignored[key] ~= true then
			count += 1
		end
	end

	for key, value in pairs(a) do
		if ignore[key] ~= true and ignored[key] ~= true then
			count -= 1

			if count < 0 then
				return false
			end

			const other = b[key]

			if value ~= other then
				if type(value) ~= "table" or type(other) ~= "table" or not Compare_C1_I3_A0(value, other, ignore, ignoreAtDepth, depth + 1, seenA, seenB) then
					return false
				end
			end
		end
	end

	return count == 0
end

const function Entry_C1_I3_A0(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C1_I3_A0(a, b, ignore, ignoreAtDepth, 1, {}, {})
end

-- slot 9: cycles=assumed none, ignore=none, array=yes
const function Compare_C0_I0_A1(a: Map, b: Map): boolean
	if IsSingleton(a) or IsSingleton(b) then
		return false
	end

	const length = #a

	if length ~= #b then
		return false
	end

	for i = 1, length do
		const value = a[i]
		const other = b[i]

		if value ~= other then
			if type(value) ~= "table" or type(other) ~= "table" or not Compare_C0_I0_A1(value, other) then
				return false
			end
		end
	end

	return true
end

const function Entry_C0_I0_A1(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C0_I0_A1(a, b)
end

-- slot 10: cycles=tracked, ignore=none, array=yes
const function Compare_C1_I0_A1(a: Map, b: Map, seenA: Map<Map, Map>, seenB: Map<Map, Map>): boolean
	if IsSingleton(a) or IsSingleton(b) then
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

	const length = #a

	if length ~= #b then
		return false
	end

	for i = 1, length do
		const value = a[i]
		const other = b[i]

		if value ~= other then
			if type(value) ~= "table" or type(other) ~= "table" or not Compare_C1_I0_A1(value, other, seenA, seenB) then
				return false
			end
		end
	end

	return true
end

const function Entry_C1_I0_A1(a: any, b: any, ignore: any, ignoreAtDepth: any): boolean
	if a == b then
		return true
	end

	if type(a) ~= "table" or type(b) ~= "table" then
		return false
	end

	return Compare_C1_I0_A1(a, b, {}, {})
end

const Variants: { [number]: any } = {}

Variants[1] = Entry_C0_I0_A0
Variants[2] = Entry_C1_I0_A0
Variants[3] = Entry_C0_I1_A0
Variants[4] = Entry_C1_I1_A0
Variants[5] = Entry_C0_I2_A0
Variants[6] = Entry_C1_I2_A0
Variants[7] = Entry_C0_I3_A0
Variants[8] = Entry_C1_I3_A0
Variants[9] = Entry_C0_I0_A1
Variants[10] = Entry_C1_I0_A1

return {
	Variants = Variants,

	IgnoreMode = {
		None = 0,
		Keys = 1,
		Depth = 2,
		Both = 3,
	},

	Stride = {
		Cycles = 1,
		Ignore = 2,
		Array = 8,
	},
}
