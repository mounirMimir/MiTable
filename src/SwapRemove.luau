--!optimize 2
--!native
const function SwapRemove<V>(t: { V }, index: number): V?
	const n = #t
	const element = t[index]

	t[index] = t[n]
	t[n] = nil

	return element
end

const function SwapRemoveFirstValue<V>(t: { V }, val: V): number?
	local index: number? = table.find(t, val)
	if index then
		SwapRemove(t, index)
	end
	return index
end

return {
	SwapRemove = SwapRemove,
	SwapRemoveFirstValue = SwapRemoveFirstValue,
}
