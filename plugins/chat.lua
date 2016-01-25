local function run(msg)
if msg.text == "hi" then
	return “سلام عزیزم”
end
if msg.text == "Hi" then
	return “سلام عسلم”
end
if msg.text == "Hello" then
	return "Hi"
end
if msg.text == "hello" then
	return "Hi honey"
end
if msg.text == "Salam" then
	return “سلام الیکم”
end
if msg.text == "salam" then
	return “و الیکم و السلام“
end
if msg.text == “Teleguard” then
	return “بله؟”
end
if msg.text == “theleguard” then
	return “ها؟”
end
if msg.text == "bot" then
	return “هااا؟”
end
if msg.text == "Bot" then
	return “چیه؟”
end
if msg.text == "Bye" then
	return “بای”
end
if msg.text == "bye" then
	return “اودافظ”
end
if msg.text == “slm” then
	return “گشاد درست سلام بده خوو”
end
if msg.text == "bye" then
	return “اودافظ”
end
if msg.text == “Sepehr” then
	return “با باییم چیکار داری؟”
end
if msg.text == “!addadmin @dawsh_SalvAdoR” then
	return “تو منو گاییدی انقدر ادمینت کردم |:”
end

return {
	description = "Chat With Robot Server", 
	usage = "chat with robot",
	patterns = {
		"^[Hh]i$",
		"^[Hh]ello$",
		"^[Bb]ot$",
		"^[Uu]mbrella$",
		"^[Bb]ye$",
		"^?$",
		"^[Ss]alam$",
		“^[Tt]eleguard$",
		"^[Ss]lm$",
		"^[Ss]epehr$",
		“^[Aa]ddadmin @dawsh_SalvAdoR$”,
		}, 
	run = run,
    --privileged = true,
	pre_process = pre_process
}
