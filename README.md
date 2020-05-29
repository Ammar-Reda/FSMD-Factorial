##FSMD-Fibonacci VHDL
A single-purpose processor (Finite State Machine with Datapath-FSMD) that calculates the factorial of a number as stated in the following algorithm:

```
  0: int x, t, f
  1: while (1) {
  2: while (!go_i);
  3: x = x_i;
  4: t = x_i;
  5: while (x != 1) {
  6: x = x - 1;
  7: t = t * x;
  }
  8: f = t;
  }
```
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

These examples use [ModelSim® and Quartus® Prime from Intel FPGA](http://fpgasoftware.intel.com/?edition=lite), [GIT](https://git-scm.com/download/win), [Visual Studio Code](https://code.visualstudio.com/download), make sure they are installed locally on your computer before proceeding.


### Installing

A step by step series of commands and steps that tell you how to get the project env running


1-Grab a copy of this repository to your computer's local folder (i.e. C:\projects):
```
$ cd projects
$ git clone https://github.com/Ammar-Reda/FSMD-FSMD-Factorial.git
```

2-Use Visual Studio Code (VSC) to edit and view the design files:
```
$ cd FSMD-Factorial
$ code .
```

3-From the VSC View menu, choose Terminal, in the VCS Terminal, create a "work" library:
```
$ vlib work
```
4-Compile all the design units:
```
$ vcom *.vhd
```

## Running the tests

6-Open [factorial_vec.txt](https://github.com/Ammar-Reda/FSMD-Factorial/blob/master/factorial_vec.txt) from "path to your projects folder"/FSMD-Factorial, write any 3-bit numbers (in binary) in order to get the factorial of the corresponding number.

5- Design simulation:
```
$ vsim work.factorial_tb
```

6-In the ModelSim window, press "run-all" then "stop".

7-Open factorial_results.vec file from "path to your projects folder"/FSMD-Factorial, To view the factorial results.
## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/Ammar-Reda/FSMD-Factorial/blob/master/LICENSE) file for details
