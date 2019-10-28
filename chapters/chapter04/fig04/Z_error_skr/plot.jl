plot([data[1:end-i,1] for i in [22, 45, 51, 53, 54, 54, 55, 65]],
    [data[1:end-i,j] for (i,j) in [(22,2),(45,3),(51, 4),(53,5),(54,6),(54,7),(55,8),(65,9)]],
    yaxis = ("Secret Key Rate (bps)", :log10, (3e-5, 5e5)),
    xaxis = ("Error (%)", (0,1.5)),
    color = RdYlPu8,
    w = 1.9,
    label = ["$x km" for x in 0:50:350],
    leg = :bottomright
    )
