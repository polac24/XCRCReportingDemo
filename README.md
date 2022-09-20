
Project to reproduce problems with XCRemoteCache: by default contains a sample Swift application that depends on a static swift library.

#### Steps to reproduce

1. Open `DemoReferences.xcodeproj` and setup your project
2. Commit in your changes
3. Call `./reproduce.sh` and follow instructions

#### Expected behaviour

1. Customer build succeeds 
1. Cache hit is as expected
1. No IDE problems
