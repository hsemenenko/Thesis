using Dates
using Plots
gr(size=(1920,1080))

date = []
text = []
caption = []
figure = []
maths = []

t_reg = r"Words in text: (.*\d)"
c_reg = r"Words outside text \(captions, etc\.\): (.*\d)"
f_reg = r"Number of floats/tables/figures: (.*\d)"
i_reg = r"Number of math inlines: (.*\d)"
d_reg = r"Number of math displayed: (.*\d)"

for file in filter(x -> endswith(x, "txt"), readdir("./History"))
    push!(date, Date(file[1:10],"y_m_d")) 
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

plot(date,[text,caption], lab = ["Text" "Captions"], w=3, legend = :topleft)
plot!(twinx(), date, [figure, maths], lab = ["Figures" "Equations"], line=(:dot), w=3, legend = :topright)
savefig("count.pdf")