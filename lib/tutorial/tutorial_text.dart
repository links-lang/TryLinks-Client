const tutorialHeaders = const [
  '1: Hello, world!',
  '2: Simple forms',
  '3: Client-side forms',
  '4: Client-side TODO list',
  '5: Factorial: Querying tables',
  '6: Database TODO list',
];

const tutorialDescs = const [
  r'''
  ### Lesson 1 Hello World
  Let's start with the simplest possible program: one that just prints "Hello, world" (albeit on a Web page). The starter code is given.

This is a tiny bit more complicated than you might expect. Let's go through the main components of the program:

The `mainPage` function defines what to do to render the main page of the program. The keyword fun starts a function definition, and we write `(_)` to indicate that there is one argument but that we don't care about its value. (The underscore `_` is a wildcard that can be used as a variable if we don't care about the variable's value.) The body of the function is enclosed in curly braces.

The body of the function defines the return value. In Links, the body of a function is evaluated to a value, which is returned. In this case, the return value is a *page*, defined using the `page` keyword. Pages can be defined using XML literals; for example, here we write `<html>` and `<body>` tags, then `<h1>Hello world!</h1>`, then the appropriate closing tags. The difference between a page and an XML value is that a page has additional structure needed for Links to render the page as the result of a web request (for example to handle any forms embedded in the page).

The `main` function calls `addRoute` to install the `mainPage` handler as the default response to any HTTP request, and `startServer()` starts the Links web server.

To run this example, type the following (from within directory 1_hello):

```
$ linx hello.links
```

The command should not return. If you followed the VM configuration instructions, you should be able to see the web page on the right side on the page.
''',
  '',
  '',
  '',
  '',
  '',
  '',
];