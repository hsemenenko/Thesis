using Plots, DelimitedFiles, Plots.PlotMeasures

gr(size = (800,640))
pgfplots()

#load files
decoy_mod_file = open(".\\chapters\\chapter04\\fig04\\Electrical Signals\\250mhz-bb84-decoy-mod.csv")
phase_enc_file = open(".\\chapters\\chapter04\\fig04\\Electrical Signals\\250mhz-bb84-phase-enc.csv")
phase_rand_file = open(".\\chapters\\chapter04\\fig04\\Electrical Signals\\250mhz-bb84-phase-rand.csv")
pulse_mod_file = open(".\\chapters\\chapter04\\fig04\\Electrical Signals\\250mhz-bb84-pulse-mod.csv")

#open files
decoy_mod = readdlm(decoy_mod_file, ',')
phase_enc = readdlm(phase_enc_file, ',')
phase_rand = readdlm(phase_rand_file, ',')
pulse_mod = readdlm(pulse_mod_file, ',')

#Plot
decoy_plt = plot(
   decoy_mod[3000:23500, 2],
   seriescolor = RGB(128/255,106/255,183/255),
   top_margin = 0cm,
   bottom_margin = -1cm,
   ylabel = "Decoy Mod"
   )

phase_enc_plt = plot(
   phase_enc[3000:23500, 2],
   seriescolor = RGB(128/255,106/255,183/255),
   top_margin = -1cm,
   bottom_margin = -1cm,
   ylabel = "Phase Enc"
   )

phase_rand_plt = plot(
   phase_rand[3000:23500, 2],
   seriescolor = RGB(128/255,106/255,183/255),
   top_margin = -1cm,
   bottom_margin = -1cm,
   ylabel = "Phase Rand"
   )

pulse_mod_plt = plot(
   pulse_mod[3000:23500, 2],
   seriescolor = RGB(128/255,106/255,183/255),
   top_margin = -1cm,
   bottom_margin = 0cm,
   ylabel = "Pulse Mod"
   )

labels_plt = plot(
   annotations=([(1100,0.5, text("ket{0}", :center)),
      (2250,0.5, text("ket{0}", :center)),
      (3400,0.5, text("ket{1}", :center)),
      (4600,0.5, text("ket{0}", :center)),
      (5750,0.5, text("ket{1}", :center))
   ]),
   xlims = (0,20500),
   ylims = (0.4999,0.501),
   top_margin = 0cm,
   bottom_margin = 0cm,
   )

plt = plot(
   labels_plt,
   decoy_plt,
   phase_enc_plt,
   phase_rand_plt,
   pulse_mod_plt,
   xticks = false,
   yticks = false,
   xaxis = false,
   yaxis = false,
   leg = false,
   left_margin = 1cm,
   layout = (5,1)
   )

state_lines = [100,750,1375,2000]
vline!([state_lines,state_lines,state_lines,state_lines],
      width = [1,1,1,1],
      seriescolor = RGB(171/255,31/255,45/255),
      line = :dash
   )

savefig("chapters\\chapter04\\fig04\\Electrical Signals\\plot.png")
