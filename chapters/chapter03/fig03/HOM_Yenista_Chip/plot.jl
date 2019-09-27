using Plots, Plots.PlotMeasures, DelimitedFiles, Statistics

curr_sweep_file = open("external_mod_curr_sweep\\coins_array.csv")

curr_sweep = readdlm(curr_sweep_file, ',')

data0 = curr_sweep[2,1:10:end] ./ mean(curr_sweep[2,1:10])

curr = 12:0.1:34

plot(curr,
    data0,
    yaxis = ("Normalised Coincidences", (0,1.5), 0:0.5:1),
    xaxis = ("Current (mA)", (12,34)),
    st = :scatter,
    leg = false,
    markercolor = light_purple,
    markerstrokecolor = RdYlPu33,
    markersize = 5,
    markerstrokewidth = 1
    )

yen_sweep_file = open("external_mod_wavelength_sweep\\coins_array.csv")
