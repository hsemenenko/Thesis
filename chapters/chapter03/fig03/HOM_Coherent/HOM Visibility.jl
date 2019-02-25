#Packages
using QuadGK, Plots, SpecialFunctions, Plots.PlotMeasures
if isdefined(Main, :Juno) && Juno.isactive()
    gr(size = (1920, 1080));
else
    gr(reuse = true, size = (1920, 1080), show = true); plot(); gui()
end

#Variables
α1 = 0.01
α2 = 0.01
η1 = 0.8
η2 = 0.8
θ  = π/4-0.01
r  = sin(θ)
t  = cos(θ)

#Probabilities from paper
P1(α,ϕ) = (1 - exp(-α^2 * (1 + cos(ϕ)) * η1))*(1 - exp(-α^2 * (1 - cos(ϕ)) * η2))
P1_b(α,η) = 1 - 2 * besseli(0,α^2 * η)/exp(α^2 * η) + besseli(0,0)/exp(2 * α^2 * η)
P2(α) = (1 - exp(-α^2 * η1))*(1 - exp(-α^2 * η2))

#Expectations from paper
function E1(α)
    I(x) = (1/(2*π))*P1(α, x)
    return quadgk(I, 0, 2*π)
end
E1_b(α) = P1_b(α,η1)
E2(α) = P2(α)

#Visibility
V(α) = 1 - E1_b(α)[1]/E2(α)

#Generalised probabilities
P1_g(α,β,η1,η2,r,t,θ) = (1 - exp(-abs(r * exp(im * θ)* α + t * β)^2 * η1))*(1 - exp(-abs(t * exp(im * θ)* α - r * β)^2 * η2))
P2_g(α,β,η1,η2,r,t) = (1 - exp(-(abs(r*α)^2 + abs(t*β)^2)* η1))*(1 - exp(-(abs(t*α)^2 + abs(r*β)^2)* η2))

#Generalised Expectations
function E1_g(α,β,η1,η2,r,t)
    I(x) = (1/(2*π))*P1_g(α,β,η1,η2,r,t,x)
    return quadgk(I,0,2*π)
end
E2_g(α,β,η1,η2,r,t) = P2_g(α,β,η1,η2,r,t)

#Generalised Visibility
V_g(α,β,η1,η2,r,t) = 1 - E1_g(α,β,η1,η2,r,t)[1]/E2_g(α,β,η1,η2,r,t)

#Plotting
xrange = 0:0.1:1
yrange = V.(xrange)
yrange_g = V_g.(xrange,xrange,η1,η2,r,t)
display(plot(xrange,
            [yrange,yrange_g],
            ylim=(0,0.55),
            xlim=(0,Inf)
        ))

xrange = 0:0.005:π
xrange_c = (cos.(xrange/2)).^2
xrange_s = (sin.(xrange/2)).^2
phot_nums = [0.01 2 3 4 5 6 7 8 9 10]
yrange = zeros(length(xrange),length(phot_nums))
for i in 1:length(phot_nums)
    yrange[:,i] = V_g.(phot_nums[i],phot_nums[i],η1,η2,xrange_c,xrange_s)
end
display(plot(xrange_c,
            yrange,
            ylim=(0,0.55),
            xlim=(0,Inf),
            lab = phot_nums,
            legendfont = font(16),
            xaxis = ("Reflectivity/Transmission",font(16)),
            xticks = ([0,0.25,0.5,0.75,1]),
            yaxis = ("Visibility",font(16)),
            yticks = ([0,0.25,0.5]),
            linewidth = 4,
            linealpha = 0.8,
            left_margin=[10mm 10mm],
            bottom_margin=10mm,
            color_palette = :auto
        ))

data = Array{Any}(length(xrange_c) + 1, length(phot_nums) + 1)
data[1,1] = "x"
data[1,2:end] = phot_nums
data[2:end,1] = xrange_c
data[2:end,2:end] = yrange
writedlm("HOM_Bs_vis.dat", data, ',')

#Wait for enter if script it being run
if !isdefined(Main, :Juno)
    println("\nPress enter to exit...\n")
    readline(STDIN)
end
