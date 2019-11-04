using Plots
using Plots.PlotMeasures
gr()
using DelimitedFiles

#Electrical signals
seq1 = readdlm("isi seq 1.csv",',')
seq2 = readdlm("isi seq 2.csv",',')
seq3 = readdlm("isi seq 3.csv",',')

#Histograms
hist1 = readdlm("histogram_isi_1sequence.dat", '\n')
hist1 = Int64.(hist1[11:end])
hist2 = readdlm("histogram_isi_2sequence.dat", '\n')
hist2 = Int64.(hist2[11:end])
hist3 = readdlm("histogram_isi_3sequence.dat", '\n')
hist3 = Int64.(hist3[11:end])

plot(
    hist1[1:800]
)
