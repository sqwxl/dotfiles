# Type 'd' to move up to repo root
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

