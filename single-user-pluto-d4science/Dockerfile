# Base image from jupyter stacks
FROM quay.io/jupyter/julia-notebook:2024-05-06

# Julia Updates and packages installations
# See https://support.d4science.org/issues/22065
RUN julia --eval 'using Pkg; Pkg.pin("IJulia")' \
    && julia --eval "using Pkg; Pkg.update()" \
    && julia --eval 'using Pkg; Pkg.add(["Images","VideoIO"])' \
    && julia --eval 'using Pkg; Pkg.add(name="DIVAnd", version="2.7.9")' \
    && julia --eval 'using Pkg; Pkg.add(["JSON", "PyCall", "PyPlot", "Glob", "DataStructures", "NCDatasets"])'
