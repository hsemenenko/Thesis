using Plots, DelimitedFiles, Plots.PlotMeasures

file = open("chapters/chapter03/fig03/Laser_current_sweep/TX1 laser spectrum current sweep from 20mA to 29mA in 1 mA steps 23.75C OSA Output.csv")

data = readdlm(file, ',')

plot(data[3:end,1],
    [data[3:end,i] for i in 2:8:20],
    label = ["20mA" "24mA" "28mA"],
    xaxis = ("Wavelength (nm)", (1550, 1550.4)),
    yaxis = false,
    ylims = (1e-8,4.5e-7),
    grid= false,
    seriescolor = RdYlPu3,
    left_margin = -1cm,
    right_margin = 1cm#("Normalised Power (dBm)", (1e-8,4.5e-7))
    )

savefig("chapters/chapter03/fig03/Laser_current_sweep/plot.pdf")
