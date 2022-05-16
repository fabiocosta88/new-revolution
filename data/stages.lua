-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 50,
		multiplier = 50
	}, {
		minlevel = 51,
		maxlevel = 70,
		multiplier = 35
	}, {
		minlevel = 71,
		maxlevel = 100,
		multiplier = 25
	}, {
		minlevel = 101,
		maxlevel = 150,
		multiplier = 15
	}, {
		minlevel = 151,
		maxlevel = 200,
		multiplier = 10
	},
	{
		minlevel = 201,
		maxlevel = 300,
		multiplier = 8
	},
	{
		minlevel = 301,
		maxlevel = 400,
		multiplier = 6
	},
	{
		minlevel = 401,
		maxlevel = 500,
		multiplier = 4
	},
	{
		minlevel = 500,
		multiplier = 3
	}
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 60,
		multiplier = 15
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 10
	}, {
		minlevel = 81,
		maxlevel = 100,
		multiplier = 6
	}, {
		minlevel = 101,
		maxlevel = 125,
		multiplier = 4
	}, {
		minlevel = 126,
		multiplier = 1.5
	}
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 60,
		multiplier = 10
	}, {
		minlevel = 61,
		maxlevel = 80,
		multiplier = 7
	}, {
		minlevel = 81,
		maxlevel = 100,
		multiplier = 5
	}, {
		minlevel = 101,
		maxlevel = 110,
		multiplier = 4
	}, {
		minlevel = 111,
		maxlevel = 125,
		multiplier = 3
	}, {
		minlevel = 126,
		multiplier = 1.5
	}
}
