local config = {
	[1] = {
		mapName = 'alptramun',
		num = 1
	},
	[2] = {
		mapName = 'izcandar',
		num = 2
	},
	[3] = {
		mapName = 'malofur',
		num = 3
	},
	[4] = {
		mapName = 'maxxenius',
		num = 4
	},
	[5] = {
		mapName = 'plagueroot',
		num = 5
	}
}

local function dreamcourtshook(message) -- New local function that runs on delay to send webhook message.
	Webhook.send("[Dream Courts Arena] ", message, WEBHOOK_COLOR_ONLINE) --Sends webhook message
end

local dreamArena = true
local dreamcourtsarena = GlobalEvent("dreamcourtsarena")

function dreamcourtsarena.onStartup()
	if dreamArena then
		local randBoss = config[math.random(#config)]
		Spdlog.info(string.format("[Dream Courts Arena] Today dream courts arena boss: %s", randBoss.mapName))
		local message = string.format("Dream Courts Arena Boss today is %s.", randBoss.mapName) -- Declaring the message to send to webhook.
		Game.loadMap('data/world/dream_courts/' .. randBoss.mapName .. '.otbm')
		addEvent(dreamcourtshook, 60000, message) -- Event with 1 minute delay to send webhook message after server starts.
		setGlobalStorageValue(GlobalStorage.DreamCourtsBoss, randBoss.num)
	end
end

dreamcourtsarena:register()
