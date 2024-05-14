# multidisplay

The multidisplay app is a Flutter application that works on legacy iOS devices to track habits, manage events, track expenses, and view weather. 

## Getting Started

To run this project, the following configuration files need to be setup:


`
flutter packages pub run build_runner build  --delete-conflicting-outputs
`

`
flutter test --coverage
lcov --remove coverage/lcov.info "lib/**/generated/*" -o coverage/new_lcov.info
genhtml coverage/new_lcov.info -o coverage 
open coverage/index.html
`