Robot = {}
Robot.__index = Robot

local function advance(robot)
	if robot.heading == "north" then
		robot.y = robot.y + 1
	elseif robot.heading == "east" then
		robot.x = robot.x + 1
	elseif robot.heading == "south" then
		robot.y = robot.y - 1
	elseif robot.heading == "west" then
		robot.x = robot.x - 1
	end
end

local function rotate_right(robot)
	local right_direction = {
		north = "east",
		east = "south",
		south = "west",
		west = "north",
	}

	robot.heading = right_direction[robot.heading]
end

local function rotate_left(robot)
	for _ = 1, 3 do
		rotate_right(robot)
	end
end

local function handle_command(robot, command)
	if command == "A" then
		advance(robot)
	elseif command == "R" then
		rotate_right(robot)
	elseif command == "L" then
		rotate_left(robot)
	else
		error("Unrecognised command")
	end
end

function Robot:move(command_string)
	for command in string.gmatch(command_string, ".") do
		handle_command(self, command)
	end
end

return function(config)
	local robot = {
		x = config.x,
		y = config.y,
		heading = config.heading,
	}
	setmetatable(robot, Robot)

	return robot
end
