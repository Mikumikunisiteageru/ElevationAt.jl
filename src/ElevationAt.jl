# ElevationAt.jl

module ElevationAt

using GeoArrays
using Printf
using ZipFile

export elevat

function demtile(long, lat)
	x = @sprintf("E%03d", floor(long))
	y = @sprintf("N%02d", floor(lat))
	path = joinpath(ENV["DEM_PATH"], y, "ASTGTMV003_$y$x")
	dem_path = joinpath(path, "ASTGTMV003_$(y)$(x)_dem.tif")
	@assert isfile("$path.zip")
	if ! isfile(dem_path)
		r = ZipFile.Reader("$path.zip")
		ispath(path) || mkdir(path)
		for f = r.files
			file_path = joinpath(path, f.name)
			isfile(file_path) && continue
			open(file_path, "w") do fout
				write(fout, read(f))
			end
		end
	end
	return dem_path
end

function elevat(long, lat)
	dem_path = demtile(long, lat)
	dem = GeoArrays.read(dem_path)
	i = indices(dem, [long, lat])
	if isa(i, CartesianIndex)
		return dem[i]
	else
		return dem[i...]
	end
end

end # module ElevationAt
