const starterTutorialDesc = const [
  '<span class="tl-repl-code-snippet">[0 / 12]</span> Welcome to the interactive Links shell!\nHere is a short introduction to Links syntax to help you get started.\nIf you are already familiar with Links, type "skip intro;" to skip this series.\n\nFirst try type just a literal like <span class="tl-repl-code-snippet">52;</span>.You will see the literal in the output again, with its inferred type.\nRemember in Links you need a semicolon at the end of each statement.\nThe progress is shown at the start of each tip, and also you can type <span class="tl-repl-code-snippet">next tip;</span> or <span class="tl-repl-code-snippet">go back;</span> to navigate through the guide.',
  '<span class="tl-repl-code-snippet">[1 / 12]</span> Now let\'s try something a bit more interesting! type <span class="tl-repl-code-snippet">1 + 2 * 4;</span> or any integer arithmetic expression and see its result.',
  '<span class="tl-repl-code-snippet">[2 / 12]</span> Instead of playing with numbers individually, try type <span class="tl-repl-code-snippet">[1, 4, 9, 16];</span> and see what comes out. List!',
  '<span class="tl-repl-code-snippet">[3 / 12]</span> You can concatenate 2 lists by using <span class="tl-repl-code-snippet">++</span>. Try <span class="tl-repl-code-snippet">[1, 2] ++ [3, 4, 5];</span>.',
  '<span class="tl-repl-code-snippet">[4 / 12] You can also push a new element into the head of the list like <span class="tl-repl-code-snippet">1::[2,3,4,5];</span>.',
  '<span class="tl-repl-code-snippet">[5 / 12]</span> You can define variables in the shell as well! Try <span class="tl-repl-code-snippet">var s = [2, 4, 5];</span>.',
  '<span class="tl-repl-code-snippet">[6 / 12]</span> Once you have a variable, you can use it in pattern matching. Try the following:\n<span class="tl-repl-code-snippet">switch (s) { \n case [] -> print("s is empty")\ncase x::xs -> print("s is not empty")\n};</span>',
  '<span class="tl-repl-code-snippet">[7 / 12]</span> You can conbime values into a "Tuple" too! Try <span class="tl-repl-code-snippet">var t = (1, "OK");</span>.',
  '<span class="tl-repl-code-snippet">[8 / 12]</span> Conditions can be leveraged to control the flow of you program, such as:\n<span class="tl-repl-code-snippet">var x = 2;\nvar y = 4;\nif (x == y)\n  print("x and y are equal")\nelse\n  print("x and y are not equal");</span>.',
  '<span class="tl-repl-code-snippet">[9 / 12]</span> Links is a functional programming language, which means functions are "first class citizens".\nYou can define a function like <span class="tl-repl-code-snippet">var inc = fun (x) {x + 1};</span>.',
  '<span class="tl-repl-code-snippet">[10 / 12]</span> Once you have the function defined, you can simply call it, like <span class="tl-repl-code-snippet">inc(7);</span>.',
  '<span class="tl-repl-code-snippet">[11 / 12]</span> Lastly, loops are used in Links as well, mostly in list comprehension. Take a look at the following example:\n<span class="tl-repl-code-snippet">var source_list = [2, 3, 7, 8, 9, 55];\nfor (n <- source_list)\n  if (odd(n))\n    [n, n+1]\n  else\n    [n]\n</span>',
  '<span class="tl-repl-code-snippet">[12 / 12]</span> That\'s it! You have learned the basic syntax of Links!\nFeel free to try more examples from the syntax page(linked above).\nOr, you can launch our 6-part tutorial which teaches you to develop webpages using Links. Enjoy!'
];