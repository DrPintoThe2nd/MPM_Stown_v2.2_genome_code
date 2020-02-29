#! /bin/bash

sed 's/>1249 edges=3470693..3470693 left=2947886 right=2947887 ver=1.10 style=3//g' S_townsendi_TG3544_v0.1_FINAL_SuperNova.fas |\
sed 's/>1251 edges=3470691..3470691 left=2947882 right=2947883 ver=1.10 style=3//g' |\
sed 's/>1253 edges=3470679..3470679 left=2947867 right=2947866 ver=1.10 style=3//g' |\
sed 's/>1254 edges=3470678..3470678 left=2947865 right=2947864 ver=1.10 style=3//g' |\
sed 's/>1351 edges=1707403..1707403 left=1968106 right=1968105 ver=1.10 style=3//g' |\
sed 's/>1405 edges=1376383..1376383 left=1597367 right=1597366 ver=1.10 style=3//g' |\
sed 's/>153232 edges=4173628..4173628 left=3024081 right=1399041 ver=1.10 style=3//g' |\
sed 's/>154792 edges=4179460..4179460 left=3028485 right=1949974 ver=1.10 style=3//g' |\
sed 's/>159062 edges=4193627..4193627 left=3039149 right=2467492 ver=1.10 style=3//g' |\
sed 's/>163281 edges=4206779..4206779 left=1640320 right=3049041 ver=1.10 style=3//g' |\
sed 's/>168741 edges=4225497..4225497 left=3063074 right=2106652 ver=1.10 style=3//g' |\
sed 's/>215834 edges=4381298..4381298 left=1304562 right=3180028 ver=1.10 style=3//g' |\
sed 's/>216137 edges=4382238..4382238 left=2367917 right=3180744 ver=1.10 style=3//g' |\
sed 's/>255518 edges=4508361..4508361 left=3276120 right=1165078 ver=1.10 style=3//g' |\
sed 's/>285810 edges=4598181..4598181 left=3344627 right=2022189 ver=1.10 style=3//g' |\
sed 's/>323926 edges=4711445..4711445 left=3430965 right=281917 ver=1.10 style=3//g' |\
sed 's/>340925 edges=4758975..4758975 left=2011786 right=3467518 ver=1.10 style=3//g' |\
sed 's/>342388 edges=4763075..4763075 left=3470640 right=1327760 ver=1.10 style=3//g' |\
sed 's/>361959 edges=4819247..4819247 left=745503 right=3513618 ver=1.10 style=3//g' |\
sed 's/>364981 edges=4826945..4826945 left=3519712 right=2395805 ver=1.10 style=3//g' |\
sed 's/^N*N$//g' |\
sed '/^$/d' > S_townsendi_TG3544_v0.1_FINAL_SuperNova.fa
