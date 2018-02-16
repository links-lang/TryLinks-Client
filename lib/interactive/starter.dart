const starterTutorialDesc = const [
  'Welcome to the interactive Links shell!\nHere is a short introduction to Links syntax to help you get started.\nIf you are already familia with Links, type "skip intro;" to skip this series.\nFirst try type just a literal like "52;".You will see the literal in the output again, with its inferred type.\nRemember in Links you need a semicolon at the end of each statement.',
  'Now let\'s try something a bit more interesting! type "1 + 2 * 4;" or any integer arithmetic expression and see its result.',
  'Instead of playing with numbers individually, try type "[1, 4, 9, 16];" and see what comes out. List!',
  'You can concatenate 2 lists by using "++". Try "[1, 2] ++ [3, 4, 5];".',
  'You can also push a new element into the head of the list like "1::[2,3,4,5];".',
  'You can define variables in the shell as well! Try "var s = [2, 4, 5];".',
  'Once you have a variable, you can use it in pattern matching. Try "\nswitch (s) { \n case [] -> print("s is empty")\ncase x::xs -> "print("s is not empty")"\n};".',
  'You can conbime values into a "Tuple" too! Try "(a, "OK");".',
  'Conditions can be leveraged to control the flow of you program, such as:\nvar x = 2;\nvar y = 4;\nif (x == y)\n  print("x and y are equal")\nelse\n    print("x and y are not equal");',
  'Links is a functional programming language, which means functions are "first class citizens".\nYou can define a function like "var inc = fun (x) {x + 1};".',
  'Once you have the function defined, you can simply call it, like "inc(7);".',
  'Lastly, loops are used in Links as well, mostly in list comprehension. Take a look at the following example:\nvar s = [1, 2, 3];\nwitch (s) {\n  case [] -> print("s is empty")\n  case x::xs -> print("s is not empty")\n};',
  'That\'s it! You have learned the basic syntax of Links!\nFeel free to try more examples from the syntax page(linked above).\nOr, you can launch our 6-part tutorial which teaches you to develop webpages using Links. Enjoy!'
];