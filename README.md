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
- Provide test data to exercise the application.

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

  QUIT - terminate the application

### Further extensions

Here are some ideas for additional commands:

  HELP - list all available commands
  MAP - show a map of the table top
  MAP_ON - always show the map after each command
  MAP_OFF - stop showing the map after each command
  REPORT_ON - always report after each command
  REPORT_OFF - stop reporting after each command
  OBSTACLE x,y - place an obstacle (coffee cup, vase of flowers) at a location on the table
  