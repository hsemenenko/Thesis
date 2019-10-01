using Plots, Plots.PlotMeasures, DelimitedFiles, Statistics

curr_sweep_file = open("external_mod_curr_sweep\\coins_array.csv")

curr_sweep = readdlm(curr_sweep_file, ',')

data0 = curr_sweep[2,1:10:end] ./ mean(curr_sweep[2,1:10])

curr = 12:0.1:34

p1 = plot(curr,
    data0,
    yaxis = ("Normalised Coincidences", (0,1.5), 0:0.5:1),
    xaxis = ("Current (mA)", (12,34), 12:4:34),
    st = :scatter,
    leg = false,
    markercolor = light_purple,
    markerstrokecolor = RdYlPu33,
    markersize = 5,
    markerstrokewidth = 1
    )

yen_sweep_file = open("external_mod_wavelength_sweep\\coins.csv")

yen_sweep = readdlm(yen_sweep_file,',')

data1 = yen_sweep./420

p2 = plot(-92:1:208,
    data1[1:1:end],
    yaxis = ("Normalised Coincidences", (0,1.5), 0:0.5:1),
    xaxis = ("Relative Wavelength (pm)", (-75,75)),
    st = :scatter,
    leg = false,
    markercolor = light_purple,
    markerstrokecolor = RdYlPu33,
    markersize = 5,
    markerstrokewidth = 1
    )

total0_file = open("external_mod_wavelength_sweep\\total_det_0.csv")
total1_file = open("external_mod_wavelength_sweep\\total_det_1.csv")

total0 = readdlm(total0_file,',')
total1 = readdlm(total1_file,',')

p3 = plot(-92:2:208,
    [total0[1:2:end], total1[1:2:end]],
    yaxis = ("Normalised Coincidences", (0,1.2e6)),
    xaxis = ("Relative Wavelength (pm)", (-75,75)),
    st = :scatter,
    label = ["Det 0" "Det 1"],
    markercolor = [RdYlPu31 RdYlPu33],
    markerstrokecolor = [light_red light_purple],
    markersize = 5,
    markerstrokewidth = 1,
    # yticks = ([0,5e5,1e6], ["0", "5e5", "1e6"])
    )
