#!/usr/bin/env lua

files = io.popen("ls *.md"):lines()


function main()
	for file in files do
		lines = io.lines(file)
		header = {}
		for i=1, 6 do
			header[i]=lines()
		end
		newfile = file:gsub(".md", ".adoc")
		file2 = io.open(newfile, "r")
		content = file2:read("*a")
		file2:close()
		head = table.concat(header, "\n")
		full = head .. "\n" .. content
		file2 = io.open(newfile, "w")
		file2:write(full)
		file2:flush()
		file2:close()
		print(newfile, " done!")
	end
end

main()
