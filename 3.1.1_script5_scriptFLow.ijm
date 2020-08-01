//Conditional statements
a=10;
b=4;
if (a>b) {
	//Code to run if the comparison a>b is true
	print("a is larger than b");
} else if (b>a) {
	//Code to run if the comparison b>a is true and a>b was not true
	print("b is larger than a");
} else {
	//Code to run if neither b>a or a>b were true
	print("a is equal to b");
}

//While statements
a=0;
b=10;
while (a<b) {
	//Code to loop while the comparison a>b is true
	print("This block of code has run "+(a+1)+" times");
	//a++ is the same as writing a=a+1
	a++;
}

//For loops
//Three statements are needed for a for loop:
// 1) A start condition (here, set i=0)
// 2) A continuation test (here, loop again if i<10 is true)
// 3) A command to run every loop (here, increment i by 1, ie. i=i+1)
for (i=0; i<10; i++) {
	print("This block of code has run "+(i+1)+" times");
}

//Functions
customFunction("Hello", "world!");
//The function is not called by itself, only when called, as above.
function customFunction(parameter1, parameter2) {
	print("First parameter is: "+parameter1);
	print("Second parameter is: "+parameter2);
}