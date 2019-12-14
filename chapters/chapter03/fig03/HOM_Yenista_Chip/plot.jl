using Plots, Plots.PlotMeasures, DelimitedFiles, Statistics

curr_sweep_file = open("external_mod_curr_sweep\\coins_array.csv")

curr_sweep = readdlm(curr_sweep_file, ',')

data0 = curr_sweep[2,1:10:end] ./ mean(curr_sweep[2,1:10])

curr = 12:0.1:34

using LsqFit
model(x,p) = p[1] .- p[2]*exp.(-((x .- p[3]).^2)./(2*p[4]^2))
xdata = curr
ydata = data0
p0 = [maximum(ydata),minimum(ydata),xdata[argmin(ydata)],3]

fit = curve_fit(model, xdata, ydata, p0)
vis = fit.param[2]/fit.param[1]
vis_error = vis * sqrt((sqrt(stderror(fit)[1]^2 + stderror(fit)[2]^2)/(fit.param[1] - fit.param[2]))^2 + (stderror(fit)[1]/fit.param[1])^2)

p1 = plot([curr, curr],
    [model(curr, fit.param), data0],
    yaxis = ("Normalised Coincidences", (0,1.5), 0:0.5:1),
    xaxis = ("Current (mA)", (12,34), 12:4:34),
    st = [:line :scatter],
    leg = false,
    linecolor = light_purple,
    linewidth = 4,
    markercolor = light_red,
    markerstrokecolor = red,
    markersize = 4,
    markerstrokewidth = 1
    )

yen_sweep_file = open("external_mod_wavelength_sweep\\coins.csv")

yen_sweep = readdlm(yen_sweep_file,',')

data1 = yen_sweep./420

model(x,p) = p[1] .- p[2]*exp.(-((x .- p[3]).^2)./(2*p[4]^2))
xdata = -92:1:208
ydata = data1[:]
p0 = [maximum(ydata),minimum(ydata),0,3]

fit = curve_fit(model, xdata, ydata, p0)
vis = fit.param[2]/fit.param[1]
vis_error = vis * sqrt((sqrt(stderror(fit)[1]^2 + stderror(fit)[2]^2)/(fit.param[1] - fit.param[2]))^2 + (stderror(fit)[1]/fit.param[1])^2)

p2 = plot([-92:1:208, -92:1:208],
    [model(-92:1:208, fit.param), data1[1:1:end]],
    yaxis = ("Normalised Coincidences", (0,1.5), 0:0.5:1),
    xaxis = ("Relative Wavelength (pm)", (-75,75)),
    st = [:line :scatter],
    leg = false,
    linecolor = light_purple,
    linewidth = 4,
    markercolor = light_red,
    markerstrokecolor = red,
    markersize = 4,
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
