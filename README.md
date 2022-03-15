robot framework exercise

tests can be run tag:
robot.exe -i Test --outputdir \output Path\to\suites

by testcase:
robot.exe -t "Test Suite 1 Test Case 1" --outputdir \output Path\to\suites

by suite:
robot.exe --outputdir \output Path\to\suite

all suites:
robot.exe --outputdir \output Path\to\suites
