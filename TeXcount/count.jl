using Dates
using Plots
using Plots.PlotMeasures
gr(size=(1024,768))

date = Date[]
texts = Int64[]
caption = Int64[]
figure = Int64[]
maths = Int64[]
words = Int64[]

t_reg = r"Words in text: (.*\d)"
c_reg = r"Words outside text \(captions, etc\.\): (.*\d)"
f_reg = r"Number of floats/tables/figures: (.*\d)"
i_reg = r"Number of math inlines: (.*\d)"
d_reg = r"Number of math displayed: (.*\d)"
w_reg = r"All words: (.*\d)"

milestones = [Date("2019-10-11")]

for file in filter(x -> endswith(x, "txt"), readdir("./History"))
    push!(date, Date(file[1:10],"yyyy_mm_dd"))
    data = open("./History/" * file) do f
        read(f, String)
    end
    t = parse(Int, collect(eachmatch(t_reg, data))[end][1])
    push!(texts, t)
    c = parse(Int, collect(eachmatch(c_reg, data))[end][1])
    push!(caption, c)
    f = parse(Int, collect(eachmatch(f_reg, data))[end][1])
    push!(figure, f)
    m = parse(Int, collect(eachmatch(i_reg, data))[end][1]) + parse(Int, collect(eachmatch(d_reg, data))[end][1])
    push!(maths, m)
    w = parse(Int, collect(eachmatch(w_reg, data))[end][1])
    push!(words, w)
end

plot([date[66],date[66]],
        [0, words[66]],
        st = :path,
        label = ["Chapter 3 Draft"],
        yformatter = :plain,
        w=4,
        color = :purple,
        yforeground_color_grid = :white,
        xforeground_color_grid = :white
        )

plot!(date,
   [words,texts,caption],
   xrotation = 45,
   lab = ["Total" "Text" "Captions"],
   linetype=:steppost,
   w=3,
   yaxis = ("Text and captions", (0,25000)),
   yformatter = :plain,
   legend = :topleft,
   color = [:green :blue :blue],
   linestyle = [:solid :dash :dot],
   left_margin = 10mm,
   right_margin = 10mm,
   ygridlinewidth = 0
   )

plot!(twinx(),
   date,
   [maths, figure],
   lab = [ "Equations" "Figures"],
   w=3,
   legend = :topright,
   yaxis = ("\nFigures and Equations", (0,400)),
   xaxis = false,
   linestyle = [:solid :dot],
   color = :orange,
   linetype=:steppost,
   xrotation = 45,
   yforeground_color_grid = :white,
   xforeground_color_grid = :white
   )

savefig("count.png")
