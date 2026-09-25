export type table<K = any, V = any> = { [K]: V }

export type function DeepKeys(ty: type)
	if not ty:is("table") then
		return types.never
	end

	local keys = {}

	for key, property in ty:properties() do
		table.insert(keys, key)

		local value = property.read

		if value ~= nil then
			local nested = DeepKeys(value)

			if nested ~= types.never then
				if nested:is("union") then
					for _, component in nested:components() do
						table.insert(keys, component)
					end
				else
					table.insert(keys, nested)
				end
			end
		end
	end

	if #keys == 0 then
		return types.never
	end

	if #keys == 1 then
		return keys[1]
	end

	return types.unionof(table.unpack(keys))
end

return nil
