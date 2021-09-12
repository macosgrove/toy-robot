# Toy Robot

### What is this ?

Toy Robot is a ruby coding exercise that I completed as part of a job application for Mable.  
### Description
- The application is a simulation of a toy robot moving on a square tabletop, 
  of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but is 
  prevented from falling to destruction. Any movement that would result in the 
  robot falling from the table is prevented, however further valid 
  movement commands are still allowed.
- The application reads in commands of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- PLACE will put the toy robot on the table in position X,Y and facing NORTH,
  SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any
  sequence of commands may be issued, in any order, including another PLACE
  command. The application should discard all commands in the sequence until a
  valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently
  facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction
  without changing the position of the robot.
- REPORT will announce the X,Y and F of the robot. This can be in any form, but
  standard output is sufficient.
- A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT
  and REPORT commands.
- Input can be from a file, or from standard input.

The application is excercised through unit tests and test data supplied in an integration spec.

### Initial setup

- Clone this repo
- Install the ruby version specified in the `.ruby-version` file
- Run `bundle install`

### Running the application

Start the application with `rake toy_robot`.

### Running the tests

The application has an RSpec test suite. Run the tests with `rake spec` or just `rspec`.

### Example Input and Output
a)
```
PLACE 0,0,NORTH
MOVE
REPORT
```
Output: `0,1,NORTH`

b)
```
PLACE 0,0,NORTH
LEFT
REPORT
```
Output: `0,0,WEST`

c)
```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
```
Output: `3,3,NORTH`

### Extensions

The following extension commands have been implemented:

- HELP - list all available commands
- MAP - display a map showing the location and direction of the robot
- REPORTING_ON - always report after each command
- REPORTING_OFF - stop reporting after each command
- VERBOSE_ON - report errors in the output
- VERBOSE_OFF - ignore errors 
- QUIT - terminate the application

### Further extensions

Here are some ideas for additional commands:

- MAP_ON - always show the map after each command
- MAP_OFF - stop showing the map after each command
- OBSTACLE x,y - place an obstacle (coffee cup, vase of flowers) at a location on the table

The Rake task could be extended to take parameters, eg verbose mode, reporting mode, table size, an input file.

### Patterns and Principles

The following patterns, principles and practices have been used in this application:

- Test driven development
- Self documenting code
- Single responsibility principle
- Dependency injection
- Builder pattern (Factory class)
- Chain of Responsibility pattern (Interpreter class)

and I'm sure there are others.
