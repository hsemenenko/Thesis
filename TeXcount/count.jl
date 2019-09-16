using Dates
using Plots
using Plots.PlotMeasures
gr(size=(1024,768))

date = Date[]
text = Int64[]
caption = Int64[]
figure = Int64[]
maths = Int64[]

t_reg = r"Words in text: (.*\d)"
c_reg = r"Words outside text \(captions, etc\.\): (.*\d)"
f_reg = r"Number of floats/tables/figures: (.*\d)"
i_reg = r"Number of math inlines: (.*\d)"
d_reg = r"Number of math displayed: (.*\d)"

for file in filter(x -> endswith(x, "txt"), readdir("./History"))
    push!(date, Date(file[1:10],"yyyy_mm_dd"))
    data = open("./History/" * file) do f
        read(f, String)
    end
    t = parse(Int, collect(eachmatch(t_reg, data))[end][1])
    push!(text, t)
    c = parse(Int, collect(eachmatch(c_reg, data))[end][1])
    push!(caption, c)
    f = parse(Int, collect(eachmatch(f_reg, data))[end][1])
    push!(figure, f)
    m = parse(Int, collect(eachmatch(i_reg, data))[end][1]) + parse(Int, collect(eachmatch(d_reg, data))[end][1])
    push!(maths, m)
end

plot(date,
   [text,caption],
   xrotation = 45,
   lab = ["Text" "Captions"],
   linetype=:steppost,
   w=3,
   yaxis = ("Text and captions", (0,20000)),
   legend = :topleft,
   left_margin = 10mm,
   right_margin = 10mm
   )

plot!(twinx(),
   date,
   [figure, maths],
   lab = ["Figures" "Equations"],
   line=(:dot),
   w=3,
   legend = :topright,
   yaxis = ("\nFigures and Equations", (0,300)),
   xaxis = false,
   linetype=:steppost,
   xrotation = 45)

savefig("count.png")
