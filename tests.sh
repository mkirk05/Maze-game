#test script

echo -e "~~ File tests ~~"

echo -n "Testing wrong format"
./mazegame test_data/mazeError_6x7.txt > tmp;
if grep -