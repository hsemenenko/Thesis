using Plots, Plots.PlotMeasures, DelimitedFiles, Statistics


file = open("LAS0_500um_SOA\\All_spectra.csv")

data = readdlm(file,',')

w_a = Float64.(data[98:end,1])
p_a = Float64.(data[98:end,2].*1.1e5)
w_b = Float64.(data[98:end,3])
p_b = Float64.(data[98:end,4].*5.5e4)
w_c = Float64.(data[98:end,5])
p_c = Float64.(data[98:end,6].*8e4)


plot([w_a,w_b,w_c],
    [p_a,p_b,p_c],
    yaxis = ("Power (dB)", :log10,(1e-5,1.5e-0)),
    xaxis = ("Wavelength (nm)", (1550.5,1555.3)),
    leg=false,
    w = 1.1,
    color = [RdYlPu31 RdYlPu33 RdYlPu32]
    )

savefig("spectra.pdf")

close(file)


file = open("LAS1_300um_SOA_gain_switch\\spectra.csv")

data = readdlm(file,',')

close(file)

w_gs = Float64.(data[98:end,1])
p_gs = Float64.(data[98:end,2].*8e5)

plot(w_gs,
    p_gs,
    yaxis = ("Power (dB)", :log10,(5e-4,1.5e-0)),
    xaxis = ("Wavelength (nm)", (1552.75,1554.75)),
    leg=false,
    w = 1.2,
    color = [RdYlPu33 RdYlPu33 RdYlPu32]
    )
