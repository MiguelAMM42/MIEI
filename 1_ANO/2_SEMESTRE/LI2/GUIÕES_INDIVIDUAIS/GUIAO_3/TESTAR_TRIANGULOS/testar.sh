prog="./triangulos"
testes="2 3 5
 3  4  8
 4  3  8
 5  3  2
 7  3  4
 7  4  3
 3  4  7
 3  4  8
 4  3  7
 4  3  9
 1  1  1
 2  2  2
10 10 10
10 10 18
18 10 10
10 18 10
 3  4  5
13 12  5
7 8 9
"

IFS="
"

for t in $testes
do
	echo $t
	echo $t | $prog
done
