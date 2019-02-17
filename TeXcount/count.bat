set datetime=%date:~-4%_%date:~3,2%_%date:~0,2%__%time:~0,2%_%time:~3,2%_%time:~6,2%

echo %datetime%

perl texcount.pl -nosub -inc -stat -dir=../ -out=./History/%datetime%.txt ../henry_semenenko_thesis.tex