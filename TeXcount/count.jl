using Dates

dir = "C:\\Users\\Henry\\Dropbox\\Bristol University Work\\Thesis\\"

cd(dir)

cmd = `perl ./TeXcount/texcount.pl  -nosub -inc ./henry_semenenko_thesis.tex`

stats = read(cmd)

dir_history = dir * "\\TeXcount\\History\\" * Dates.format(now(), "yyyy_mm_dd_HHMM") * ".txt"

file = open(dir_history, "w")

write(file, stats)

close(file)