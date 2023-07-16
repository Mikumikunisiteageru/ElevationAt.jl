# test/runtests.jl

using Aqua
using ElevationAt
using Test

Aqua.test_unbound_args(ElevationAt)
Aqua.test_undefined_exports(ElevationAt)
Aqua.test_piracy(ElevationAt)
Aqua.test_project_extras(ElevationAt)
Aqua.test_stale_deps(ElevationAt)
Aqua.test_deps_compat(ElevationAt)
Aqua.test_project_toml_formatting(ElevationAt)

@testset "elevat" begin
	@test elevat(115.909492, 40.228119) == 1190
end
