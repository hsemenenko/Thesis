data0 = readdlm("I_sweep_0_150_mA_LAS0.csv",',')
data1 = readdlm("I_sweep_0_150_mA_LAS1.csv",',')

plot(
    plot(0:0.25:150,
        data1.*1000,
        yaxis = ("Power (uW)", (0,0.24)),
        xaxis = ("Current (mA)", (0,150)),
        label = "300 um",
        color = RdYlPu31
    ),
    plot(0:0.25:150,
        data0.*1000,
        xaxis = ("Current (mA)", (0,150)),
        ylims = (0,1.7),
        label = "500 um",
        color = RdYlPu33
        ),
    layout=(1,2),
    w = 2,
    bottom_margin = 0.5cm,
    left_margin = 0.5cm,
    size = (1000,400),
    leg = :topleft
)
