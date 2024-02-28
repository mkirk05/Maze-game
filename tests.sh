#test script

echo -e "~~ File tests ~~"

#this will test a maze file which contains an invalid format such as and extra column or row for a singular # or ' '
#this is used to ensure that the program can deal with a maze in the invalid format so it does not use a maze which is invalid
#the expectation from this is that the maze would be said to be invalid and it would not be used in the game
echo -n "Testing wrong format"
./mazegame test_data/extra#.txt > tmp;
if grep -q "Error: Invalid maze" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi 

#this will test an empty file 
#this is used to ensure that the program knows how to identify an empty file so that it is not used in the game
#the expectation is that the program would identify the text file as empty and display the error message 
echo -n "Testing empty files"
./mazegame test_data/empty.txt > tmp;
if grep -q "Error: Empty maze" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi 

#This test a file where the height of the maze is 4 
#this is to ensure the program can identfiy a program that does not follow the perameters given so it is not used within the game
#the expectation is for the program to identify the height is short and display the error message
echo -n "Testing for file that does not meet the requirements (height)"
./mazegame test_data/heightError.txt > tmp;
if grep -q "Error: Maze does not meet requirements" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi 

#This test a file where the width of the maze is 4 
#this is to ensure the program can identfiy a program that does not follow the perameters given so it is not used within the game
#the expectation is for the program to identify the width is short and display the error message
echo -n "Testing for file that does not meet the requirements (width)"
./mazegame test_data/widthError.txt > tmp;
if grep -q "Error: Maze does not meet requirements" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi 

#This tests a file which meets the perameters and has no extra columns 
#this is to ensure that the program can pass a file that meets all the requirements 
#the expectation is that this will pass through the program without a problem and will display a successful message
echo -n "Testing file loads successfully"
./mazegame test_data/maze_6x7.txt > tmp;
if grep -q "Maze successfully loaded" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi 

echo -e "\n~~ User input error ~~"

#this tests what happens with no input
#the expectation is that the program would identify that the space does not match up with any of the commands within the program and display the error message
echo -n "Testing no input"
echo "" | timeout 0.2 ./mazegame test_data/maze_6x7.txt > tmp
if grep -q "Error: Invalid input" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi 

#this tests what happens with a wrong input
#the expectation is that the program would identify the input does not match up with any command within the program and display th error message 
echo -n "Testing wrong input"
echo "f" | timeout 0.2 ./mazegame test_data/maze_6x7.txt > tmp
if grep -q "Error: Invalid input" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi 

echo -e "\n~~ Success ~~"

#this tests what happens when the user presses the key to move up (W)
#the expectation is that the player would move and this would mean that the X position would be updated within the maze
echo -n "Testing moving the user up"
echo "w" | timeout 0.2 ./mazegame test_data/maze_6x7.txt > tmp

#this tests to see what happens when the x meets the E
#the expectation is that when the player moves onto the E it should displpay the winning message
echo -n "Testing win message"
echo "d" | timeout 0.2 ./mazegame test_data/win.txt > tmp
if grep -q "YOU WIN" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi

#this tests to see what happens when m is pressed
#the expectation is that when m is pressed it should print out the file of the maze with the users marker present
echo -n "Testing maze print"
echo "m" | timeout 0.2 ./mazegame test_data/maze_6x7.txt > tmp
if grep -q "### ##" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi

#testing when a user moves into a wall
#the expectation is that when the user runs into the wall it will stop the user by not updating the position 
echo -n "Testing user hitting a wall"
echo "s" | timeout 0.2 ./mazegame test_data/maze_10x10 > tmp
if grep -q "You have hit a wall" tmp;
then
    echo "PASS"
else
    echo "FAIL"
fi