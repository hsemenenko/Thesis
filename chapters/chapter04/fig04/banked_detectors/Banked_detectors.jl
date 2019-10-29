using Roots, Plots

P(u, n) = exp(-u) * (u^n/factorial((n)))

eff2(u, l) = 0.8 * (1 - P(u * 10^(-0.2 * l / 20), 0))

eff(u, l) = (1 - exp(-u * 0.8 * 10 ^(-0.2 * l / 20)))

#l = distance
#k = deadtime
#u = photon number
#x = probability of click
f(l, k, u, x) = eff(u, l) * (1 - x)^k - x

dt0 = [find_zero(x -> f(l, 0, 0.2, x), (0,1)) for l in 0:1:350]
dt10 = [find_zero(x -> f(l, 10, 0.2, x), (0,1)) for l in 0:1:350]
dt25 = [find_zero(x -> f(l, 25, 0.2, x), (0,1)) for l in 0:1:350]
dt50 = [find_zero(x -> f(l, 50, 0.2, x), (0,1)) for l in 0:1:350]
dt100 = [find_zero(x -> f(l, 100, 0.2, x), (0,1)) for l in 0:1:350]
dt150 = [find_zero(x -> f(l, 150, 0.2, x), (0,1)) for l in 0:1:350]
dt250 = [find_zero(x -> f(l, 250, 0.2, x), (0,1)) for l in 0:1:350]
dt350 = [find_zero(x -> f(l, 350, 0.2, x), (0,1)) for l in 0:1:350]

p1 = plot(dt0,
    yaxis = ("Probability of Detection", :log10, (1.5e-3,2e-1)),
    xaxis = ("Distance (km)", (0,200)),
    label = "",
    color = RGB(0.2,0.2,0.2),
    ls =:dash,
    w = 3
    )

plot!([dt25, dt100, dt250],
    yaxis = ("Probability of Detection", :log10, (1.5e-3,2e-1)),
    xaxis = ("Distance (km)", (0,200)),
    label = [25, 100, 250],
    color = RdYlPu3,
    ls = :solid,
    w = 2
    )

#Assumming a state rate of 250MHz (4ns spacing) and a dead time of 100 ns,
#we can model that the detectors are dead for k=25 cycles
init =

coin2 = [k^2 for k in [find_zero(x -> f(l, 200, 0.2, x), (0,1)) for l in 0:1:350]]
coin4 = [4*k^2*(1-k)^2 for k in [find_zero(x -> f(l, 200, 10^(-0.3) * 0.2, x), (0,1)) for l in 0:1:350]]
coin8 = [16*k^2*(1-k)^6 for k in [find_zero(x -> f(l, 200, 10^(-0.6) * 0.2, x), (0,1)) for l in 0:1:350]]
coin16 = [64*k^2*(1-k)^14 for k in [find_zero(x -> f(l, 200, 10^(-0.9) * 0.2, x), (0,1)) for l in 0:1:350]]
coin32 = [256*k^2*(1-k)^30 for k in [find_zero(x -> f(l, 200, 10^(-1.2) * 0.2, x), (0,1)) for l in 0:1:350]]
coin64 = [1024*k^2*(1-k)^62 for k in [find_zero(x -> f(l, 200, 10^(-1.5) * 0.2, x), (0,1)) for l in 0:1:350]]

p2 = plot(dt0.^2,
    yaxis = ("Probability of Coincidence", :log10, (2e-9, 5e-2)),
    xaxis = ("Distance (km)", (0,350)),
    label = "",
    ls = :dash,
    color = RGB(0.2,0.2,0.2),
    linewidth = 3
    )

plot!([coin2, coin4, coin8],
    label = ["2" "4" "8"],
    linewidth = 2,
    color = RdYlPu3
    )

plot((dt0.^2)./coin2, yaxis = (:log10, (1e-1,1e2)))
