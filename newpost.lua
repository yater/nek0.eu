#! /usr/bin/env lua

date = io.popen("date --rfc-3339=date"):read()
title = "null"
author = nil


function input()
	print("Enter post title:")
	title = io.read()

	print("Enter author name:")
	author = io.read()
end

function confirmation()
	print("Is the following correct?")
	print("title:",title)
	print("author:",author)
	print("y/n")
end

function main()
	repeat
		input()
		confirmation()
	until io.read() == "y"
	local postname = "./posts/" .. date .. "-" .. title:gsub(" ", "-") .. ".md"
	local metatab ="---\ntitle: " .. title .. "\nauthor: " .. author .. "\ntags: \ndescription: \n---"
	if os.execute("touch " .. postname) then
		os.execute("echo '" .. metatab .. "' >> ".. postname)
		os.execute("vim " .. postname)
	else
		print("some error occured. exiting")
		os.exit(1)
	end
end

main()
