const tutorialHeaders = const [
  '1: Hello, world!',
  '2: Simple forms',
  '3: Client-side forms',
  '4: Client-side TODO list',
];

const tutorialDescs = const [
  r'''
## Lesson 1 Hello World
  
Let's start with the simplest possible program: one that just prints "Hello, world" (albeit on a Web page). The starter code is given.

This is a tiny bit more complicated than you might expect. Let's go through the main components of the program:

The `mainPage` function defines what to do to render the main page of the program. The keyword fun starts a function definition, and we write `(_)` to indicate that there is one argument but that we don't care about its value. (The underscore `_` is a wildcard that can be used as a variable if we don't care about the variable's value.) The body of the function is enclosed in curly braces.

The body of the function defines the return value. In Links, the body of a function is evaluated to a value, which is returned. In this case, the return value is a *page*, defined using the `page` keyword. Pages can be defined using XML literals; for example, here we write `<html>` and `<body>` tags, then `<h1>Hello world!</h1>`, then the appropriate closing tags. The difference between a page and an XML value is that a page has additional structure needed for Links to render the page as the result of a web request (for example to handle any forms embedded in the page).

The `main` function calls `addRoute` to install the `mainPage` handler as the default response to any HTTP request, and `startServer()` starts the Links web server.

## Exercises
 
1. Change the program by modifying the content of the HTML body, or adding content (such as a page title) under the `<head>` tag. Does this work? What happens if you add HTML with unbalanced tags, e.g. `<p> test <b> bold </p>`?

2. In Links, there is a difference between a `page` (which is a legitimate response to an HTTP request) and plain XML. What happens if you omit the keyword `page` from `mainPage`?

3. If you are familiar with CSS or JavaScript, what happens if you include a `<style>` or `<script>` tag in the page content?

''',
  r'''
## Lesson 2: Simple Forms

This example illustrates how to create a form in Links and how to handle form submission. There are several ways to do this in Links:

 * HTML forms with submission handled by POSTing the form response to the server
 * HTML forms with submission handled by client-side (JavaScript) code
 * formlets, a higher-level abstraction for forms that allows for validation

This lesson is about the first approach, which is simplest and probably most familiar from other HTML or web programming settings. The form is defined in the `mainPage` function. This function creates a page that contains a submittable form. This is done largely as in ordinary HTML using the `<form>` tag to delimit the form, `<input>` tags to describe the form inputs, and the `<button>` tag to define a submission button.  

There are also some important differences. In Links, there are special attributes that should be used with forms, so that Links can recognize and bind input values to Links variables, and likewise to give Links code that should be executed when the form is submitted. Take a look at the `<form>` tag and its children on the right.

The `<input>` tags includes an attribute `l:name` which is given value `s` in the string field and `i` in the integer field. Using this attribute means that when the form is submitted, Links will bind the value in the string field to `s` and bind the value of the integer field to 'i'. (The values are considered as strings in either case, since they are provided in a text field. For HTML forms, Links does not perform any validation.) The `value` attribute is just as in plain HTML: it gives the initial value of the field.

The `<form>` tag includes an attribute `l:action` whose value is a piece of Links code to be called when the form is submitted. The code is enclosed in `{}` braces in order to ensure Links parses it as Links code rather than as a string literal. Because the `l:action` field is used, the Links code is expected to return a page. (Unfortunately, the error message you get if this is wrong is quite opaque.)

The code in the `l:action` field is, in this case, a call to a function `handleForm` that constructs the page resulting from submitting the form. This code can refer to the variables `s` and `i` introduced in the form using `l:name`. Since they are both strings, we need to convert the integer parameter to an actual integer (this will fail if the submitted string doesn't parse to an integer).

The `handleForm` function simply constructs a new page that shows the submitted string and integer values. Both need to be coerced to XML strings using `stringToXml` or `intToXml`.

## Exercises

1. What happens if you leave off the `l:` prefix of the `name` attribute? Is the error message you get enlightening?

2. What happens if you leave off the `l:` prefix of the `action` attribute? Is the error message you get enlightening?

3. What happens if you leave off the curly braces in the `l:action` attribute value `"{handleForm(s,stringToInt(i))}"`?

4. What happens if you return something other than a page from the `l:action` attribute value? For example, change to `{(s,i)}`?

5. Experiment with including other standard HTML form elements such as `textarea`, `radio`, `checkbox`.
  ''',
  r'''
## Lesson 3: Client side forms

This example illustrates the second way to submit forms in Links. The form defined in the `mainPage` function is similar to the form in the previous lesson, but with one difference: the `l:onsubmit` attribute is used instead of `l:action`.

The difference between the two attributes is as follows:

 * `l:action` specifies a new page to display when the form is submitted. This is implemented via an HTTP POST request, involving a round-trip to the HTTP server that renders a new page. The action is specified by giving a Links expression that returns a page.

 * `l:onsubmit` specifies an action to take on the client when the form is submitted. This is implemented by JavaScript code running in the browser client, and does not necessarily involve a round-trip to the server (this can happen, though, if the action asynchronously contacts the server for some other reason). The action is specified by giving a Links expression that returns unit `()`; that is, the action may have side effects (such as modifying the DOM tree) but does not return a value or construct a new page.
 
Here, the Links code called when the form is submitted is `handleForm(s,stringToInt(i))`. Unlike the previous `handleForm` function, this one does not construct a new page; instead it calls a function `replaceNode` that takes an XML fragment and a DOM node identifier. The latter is obtained by calling `getNodeById("result")` which finds the node in the DOM tree of the program that has id `result`. This node can be seen in `mainPage`; it is a `<div>` node that can be replaced with content showing the form result.

## Exercises

1. What happens if you change `l:onsubmit` to `l:action`?

2. Modify the code to behave appropriately (e.g. showing an error message instead of the form results) if the value of the integer field is not a valid number. (Hint: Links supports regular expression matching e.g. `str =~ /a*b*/` tests whether a string `str` is a sequence of zero or more `a`s followed by zero or more `b`s).
  ''',
  r'''
## Lesson 4: Client side TODO list

This program creates an interactive, client-side TODO list. It works on the same principle as the previous one: values are submitted using a form, and the form response is an action performed on the client side (using `l:onsubmit`).

The `todo` function takes as an argument the current list of items. When first called, this list has one element, `"add itens to todo list"`. The function creates an XML snippet containing two things: a form for adding todo list items, and the todo list itself. When submitted, the form replaces the document content (using `replaceDocument`) with the result of calling todo again with an extended `todo` list.

The todo list itself is rendered as a table, with the first column containing the todo list items themselves and the second column containing buttons which, when pressed, will remove the list item. The buttons are embedded in forms, again using the `l:onsubmit` action so that the action will be performed on the client side without an intervening `POST` action.

The todo list is built using a comprehension of the form `for (item <- items) <XML snippet>`. There are a couple of things worth mentioning about this construct. Comprehensions allow us to iterate over the elements of a list, such as `items`, and on each iteration the corresponding element is bound to a variable `item`, which can be used in the body of the comprehension. The body of the comprehension in this case is the XML snippet that constructs each table row. In general, the result of a comprehension is a list constructed by concatenating all of the lists constructed in each iteration; thus, the return value of a comprehension body has to be a list. This is the case because in Links, the type Xml is an alias for the list type `[XmlItem]`, that is, `Xml` content is a list of `XmlItem` values, each of which corresponds to a single XML tree.

(For somewhat obscure reasons, this works fine as long as we are returning only a single XML tree as the result of `for`. But if we wanted to return multiple XML items, we could enclose them in the XML quasiquote tags `<#>...</#>` so that Links will parse all of them as a single list.)

Finally, the `remove` function traverses the todo list and removes the item(s) with matching names.

## Exercises

1. What happens if you stop the Links interpreter and restart it? Is the todo list persistent?

2. What happens if you visit the todo list from two different browser windows? Is the todo list shared across them?

3. What happens if you add multiple identical items to the todo list? What happens if you try to remove one of them? How could we change this behavior?

4. Links's comprehension syntax allows for where clauses, as follows:

~~~
for (x <- [1,2,3]) where (x == 2) [x+10]
~~~

evaluates to [12]. Can you use comprehensions to rewrite remove?
  ''',
];