SMODS.Atlas({
	key = "modicon",
	path = "showdown_icon.png",
	px = 36,
	py = 36,
}):register()

if (SMODS.Mods["Bunco"] or {}).can_load then
	sendTraceMessage("Bunco is loaded!", "Showdown")
end