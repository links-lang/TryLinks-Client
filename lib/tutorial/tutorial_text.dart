const tutorialHeaders = const [
  '1: Hello, world!',
  '2: Simple forms',
  '3: Client-side forms',
  '4: Client-side TODO list',
  '5: Factorial: \nQuerying tables',
  '6: Database TODO list',
];

const tutorialDescs = const [
  r'''
## Lesson 1 Hello World
  
#### You can navigate to other tutorials by click the menu icon on the upper left corner.

### Goal: make a web page that says "Hello World!".

Let's start with the simplest possible program: one that just prints "Hello, world" (albeit on a Web page). The starter code will not work right away, but you can fix it real quick!

This is a tiny bit more complicated than you might expect. Let's go through the main components of the program:

The `mainPage` function defines what to do to render the main page of the program. The keyword fun starts a function definition, and we write `(_)` to indicate that there is one argument but that we don't care about its value. (The underscore `_` is a wildcard that can be used as a variable if we don't care about the variable's value.) The body of the function is enclosed in curly braces.

The body of the function defines the return value. In Links, the body of a function is evaluated to a value, which is returned. In this case, the return value is a *page*, defined using the `page` keyword. Pages can be defined using XML literals; for example, here we write `<html>` and `<body>` tags, then the appropriate closing tags. The difference between a `page` and an `XML` value is that a page has additional structure needed for Links to render the page as the result of a web request (for example to handle any forms embedded in the page).

The `main` function calls `addRoute` to install the `mainPage` handler as the default response to any HTTP request, and `startServer()` starts the Links web server.

If you run the program now, it would show an empty page. Change the `page` returned by `mainPage` to include a `<h1>` tag that has the text "Hello World!". Once you have done that. Click the "Compile" button and see the result!

If you don't see the page and got some errors, double check you have your tags properly closed.

### Exercises
 
1. Change the program by modifying the content of the HTML body, or adding content (such as a page title) under the `<head>` tag. Does this work? What happens if you add HTML with unbalanced tags, e.g. `<p> test <b> bold </p>`?

2. In Links, there is a difference between a `page` (which is a legitimate response to an HTTP request) and plain XML. What happens if you omit the keyword `page` from `mainPage`?

3. If you are familiar with CSS or JavaScript, what happens if you include a `<style>` or `<script>` tag in the page content?

#### You can find the solution to this tutorial here 

<https://github.com/links-lang/links-tutorial/wiki/Lesson-1%3A-Hello%2C-world%21>

''',
  r'''
## Lesson 2: Simple Forms

#### You can navigate to other tutorials by click the menu icon on the upper left corner.

### Goal: make a web form that takes a string and an integer. When the form submits you should be able to see the values you inputted.

This tutorial illustrates how to create a form in Links and how to handle form submission. There are several ways to do this in Links:

 * HTML forms with submission handled by POSTing the form response to the server
 * HTML forms with submission handled by client-side (JavaScript) code
 * formlets, a higher-level abstraction for forms that allows for validation

This lesson is about the first approach, which is simplest and probably most familiar from other HTML or web programming settings. The form is defined in the `mainPage` function. This function creates a page that contains a submittable form. This is done largely as in ordinary HTML using the `<form>` tag to delimit the form, `<input>` tags to describe the form inputs, and the `<button>` tag to define a submission button.  

There are also some important differences. In Links, there are special attributes that should be used with forms, so that Links can recognize and bind input values to Links variables, and likewise to give Links code that should be executed when the form is submitted. Take a look at the `<form>` tag and its children on the right.

The `<input>` tags includes an attribute `l:name` which is given value `s` in the string field and `i` in the integer field. Using this attribute means that when the form is submitted, Links will bind the value in the string field to `s` and bind the value of the integer field to 'i'. (The values are considered as strings in either case, since they are provided in a text field. For HTML forms, Links does not perform any validation.) The `value` attribute is just as in plain HTML: it gives the initial value of the field.

The `<form>` tag includes an attribute `l:action` whose value is a piece of Links code to be called when the form is submitted. The code is enclosed in `{}` braces in order to ensure Links parses it as Links code rather than as a string literal. Because the `l:action` field is used, the Links code is expected to return a page. (Unfortunately, the error message you get if this is wrong is quite opaque.)

Right now `l:action` is not wired to anything, and if you run it, you are going to see a weird error message. Try to make it call the function `handleForm` that constructs the page resulting from submitting the form. Remember you need to include the Links code in `{}`. Be sure to include the variables `s` and `i` introduced in the form using `l:name` as parameters. Since they are both strings, we need to convert the integer parameter to an actual integer (this will fail if the submitted string doesn't parse to an integer).

The `handleForm` function simply constructs a new page that shows the submitted string and integer values. Both need to be coerced to XML strings using `stringToXml` or `intToXml`.

### Exercises

1. What happens if you leave off the `l:` prefix of the `name` attribute? Is the error message you get enlightening?

2. What happens if you leave off the `l:` prefix of the `action` attribute? Is the error message you get enlightening?

3. What happens if you leave off the curly braces in the `l:action` attribute value `"{handleForm(s,stringToInt(i))}"`?

4. What happens if you return something other than a page from the `l:action` attribute value? For example, change to `{(s,i)}`?

5. Experiment with including other standard HTML form elements such as `textarea`, `radio`, `checkbox`.

#### You can find the solution to this tutorial here

https://github.com/links-lang/links-tutorial/wiki/Lesson-2:-Simple-forms

  ''',
  r'''
## Lesson 3: Client side forms

#### You can navigate to other tutorials by click the menu icon on the upper left corner.

### Goal: make a web form that takes a string and an integer. When the form submits you should be able to see the values you inputted.

This example illustrates the second way to submit forms in Links. The form defined in the `mainPage` function is similar to the form in the previous lesson, but with one difference: the `l:onsubmit` attribute is used instead of `l:action`.

The difference between the two attributes is as follows:

 * `l:action` specifies a new page to display when the form is submitted. This is implemented via an HTTP POST request, involving a round-trip to the HTTP server that renders a new page. The action is specified by giving a Links expression that returns a page.

 * `l:onsubmit` specifies an action to take on the client when the form is submitted. This is implemented by JavaScript code running in the browser client, and does not necessarily involve a round-trip to the server (this can happen, though, if the action asynchronously contacts the server for some other reason). The action is specified by giving a Links expression that returns unit `()`; that is, the action may have side effects (such as modifying the DOM tree) but does not return a value or construct a new page.
 
Here, the Links code called when the form is submitted is a new new `handleForm` function. Unlike the previous `handleForm` function, this one does not construct a new page; instead it calls a function `replaceNode` that takes an XML fragment and a DOM node identifier. Try to wire the `l:onsubmit` to call this new function. Again you need to put the Links code in `{}`. Also be careful with the types of the parameters. You may find `stringToInt()` to be useful.

`handleForm` calls `getNodeById()` which finds the node in the DOM tree of the program that has correct id. This node can be seen in `mainPage`; it is a `<div>` node that can be replaced with content showing the form result. Modify the code to find the correct node in the DOM tree. You can find it in the `page` template in `mainPage`.

### Exercises

1. What happens if you change `l:onsubmit` to `l:action`?

2. Modify the code to behave appropriately (e.g. showing an error message instead of the form results) if the value of the integer field is not a valid number. (Hint: Links supports regular expression matching e.g. `str =~ /a*b*/` tests whether a string `str` is a sequence of zero or more `a`s followed by zero or more `b`s).

#### You can find the solution to this tutorial here

https://github.com/links-lang/links-tutorial/wiki/Lesson-3:-Client-side-forms

  ''',
  r'''
## Lesson 4: Client side TODO list

#### You can navigate to other tutorials by click the menu icon on the upper left corner.

### Goal: make a non-persistent TODO list.

This program creates an interactive, client-side TODO list. It works on the same principle as the previous one: values are submitted using a form, and the form response is an action performed on the client side (using `l:onsubmit`).

The `todo` function takes as an argument the current list of items. When first called, this list has one element, `"add itens to todo list"`. The function creates an XML snippet containing two things: a form for adding todo list items, and the todo list itself. When submitted, the form replaces the document content (using `replaceDocument`) with the result of calling todo again with an extended `todo` list. Fill out the parameters of the two `replaceDocument` functions, one for adding new item and one for marking an item as done.

The todo list itself is rendered as a table, with the first column containing the todo list items themselves and the second column containing buttons which, when pressed, will remove the list item. The buttons are embedded in forms, again using the `l:onsubmit` action so that the action will be performed on the client side without an intervening `POST` action.

The todo list is built using a comprehension of the form `for (item <- items) <XML snippet>`. There are a couple of things worth mentioning about this construct. Comprehensions allow us to iterate over the elements of a list, such as `items`, and on each iteration the corresponding element is bound to a variable `item`, which can be used in the body of the comprehension. The body of the comprehension in this case is the XML snippet that constructs each table row. In general, the result of a comprehension is a list constructed by concatenating all of the lists constructed in each iteration; thus, the return value of a comprehension body has to be a list. This is the case because in Links, the type Xml is an alias for the list type `[XmlItem]`, that is, `Xml` content is a list of `XmlItem` values, each of which corresponds to a single XML tree.

(For somewhat obscure reasons, this works fine as long as we are returning only a single XML tree as the result of `for`. But if we wanted to return multiple XML items, we could enclose them in the XML quasiquote tags `<#>...</#>` so that Links will parse all of them as a single list.)

Finally, the `remove` function traverses the todo list and removes the item(s) with matching names. If you know Haskell, this structure should be very familiar.

### Exercises

1. What happens if you stop the Links interpreter and restart it? Is the todo list persistent?

2. What happens if you visit the todo list from two different browser windows? Is the todo list shared across them?

3. What happens if you add multiple identical items to the todo list? What happens if you try to remove one of them? How could we change this behavior?

4. Links's comprehension syntax allows for where clauses, as follows evaluates to `[12]`. Can you use comprehensions to rewrite `remove`?

~~~
for (x <- [1,2,3]) where (x == 2) [x+10]
~~~

#### You can find the solution to this tutorial here

https://github.com/links-lang/links-tutorial/wiki/Lesson-4:-Client-side-TODO-list
  ''',
  r'''
## Lesson 5: Factorial: Querying tables

#### You can navigate to other tutorials by click the menu icon on the upper left corner.

### Goal: make a page where you can query the factorial numbers from 1 to 20.

### Overview

This program exercises (simple) database querying using Links's support for mapping comprehension syntax to queries. (This capability is a form of "language-integrated query", analogous to Microsoft's LINQ).

The main page is a simple form (constructed by function `request`) that accepts an integer, say 5. This form is a little more sophisticated than previous examples: it uses a second event, `l:onkeyup`, to validate the field contents and ensure that the text field can be parsed to an integer. Setting this event handler means that after each key is pressed, the form will be reconstructed by calling `request` with the new text value; this causes the if-then conditional logic to be re-evaluated, which tests whether the field matches a regular expression for nonempty digit sequences (`s =~ /^[0-9]+/`). If not, then the submit button is deactivated.

On submission, the `response` function is called with the field value, and replaces the document content with the results of a database query that pulls in all of the rows where `i` is less than or equal to the number, as a table showing the `i` and `f` values. This is done by the `lookupFactorials` function.

### Queries

Because it involves several new features relating to database connections and querying, we'll go through this function line by line. The first line creates a reference to the database `links`, and binds it to variable `db`. (It is possible to refer to several databases from a single Links program, but writing a query that refers to tables in more than one database results in a run-time error.)

~~~
var db = database "links";
~~~

The next line creates a reference to the `factorials` table, which was created earlier for you:

~~~
var factorials = table "factorials" with (i : Int, f : String) from db;
~~~

The table reference specifies the names and (Links) types of the table fields, and the database `db` where the table lives.

Finally, the `query` expression runs a query (defined using a comprehension):

~~~
 query {
   for (row <-- factorials)
    where (row.i <= n)
    orderby (row.i)
     [#to be filled out]
}
~~~

The `for` line says that the query will consider each row in the `factorials` table. The where line constrains attention to those rows whose `i` field is `<=` n. The `orderby` line sorts the rows by the i field. The last line says that for each iteration of the query we return a new row `[(i=row.i, f=row.f)]`. (It would be equivalent to just return `[row]`.)

One important, but perhaps subtle, difference compared to the comprehension we used in the `todo` list (previous lesson) is that in the line `for (row <-- factorials)`, we use a long arrow <--. The comprehension syntax `for (x <- xs)` with the short arrow is intended for use when `xs` is a list, not a table reference; for a table reference t we use the long arrow. If you get these mixed up, you will get a type error complaining that a list was provided where a table reference was expected, or vice versa.

This query will generate a single SQL query. Links can do many things that a SQL database cannot do, such as printing to the console, or evaluating a recursive function. Using the `query` keyword means that Links will check that the code inside the braces `{...}` can be performed on the database; if this is not the case (for example due to printing or recursive function calls) then Links will raise a compile-time type error. If the query keyword is omitted, then Links will do its best to turn comprehensions into queries, but may fail; that may mean that the query runs very inefficiently, for example by loading all of the data from a table into memory and running the query there. In general, if you expect a part of the program to be performed on the database, enclose it with `query` so that Links will check this.

### Client and server annotations

The other new thing in this example is the annotations `client` and `server` in some of the function definitions. For example `response` has a `client` annotation and `lookupFactorials` has a `server` annotation. These annotations tell Links that these functions should only be executed on the Web client (browser) or only on the server. This is particularly important for database queries. Queries should be run from the server only, because database and table references amount to database connections which will not be meaningful to the Web client. Moreover, making these values available on the Web client can leak important information such as the username and password of the database user.

### Exercises

 1. What happens if you add a `print` statement or call a recursive function in the middle of a query? What happens if you do this after removing the `query{...}` surrounding the query code?

 2. Modify the query to return just one row, the row matching the parameter `n`, or to return all rows whose factorial value is larger than `n`.

 3. What happens if you submit a string such as `5xyz` that starts with a number but includes non-digits? How might you change this behavior to rule this out?

#### You can find the solution to this tutorial here

https://github.com/links-lang/links-tutorial/wiki/Lesson-5:-Factorial:-Querying-tables

''',
  r'''
## Lesson 6: Database TODO list: Updating tables

#### You can navigate to other tutorials by click the menu icon on the upper left corner.

### Goal: make a persistent TODO list.

### Overview

This example program is superficially similar to lesson 4's TODO list. However, instead of storing the TODO list in a list value on the client, this program stores it in the database. So, there are two important differences:

 * Todo list items are persistent in the database and will survive if the Links program terminates and is restarted. (By the same toke, they could also be accessed through the database interactive interface or by other applications with access to the database.)
 * Todo list items are centralized and different copies of the todo list program running in different browser windows can see the same data.

The user interface for this version of the TODO list program is the same as before, so we won't explain it again. The main differences are in how the list is displayed and changed.

In `showList`, instead of using a list comprehension over an in-memory list, we use a query `query {for (item <-- items) [item]}`. This generates a simple SQL querty that just returns all of the list items. Because `showList` queries the database, we annotate it server so that this happens on the server.

The actions for the insert and remove buttons are also different: they simply call the `add` and `remove` functions. These functions use Links's syntax for database table:

~~~
insert TABLE_NAME values [(COLUMN1_NAME=VALUE1, COLUMN2_NAME=VALUE2, ...)];
~~~

And

~~~
delete (r <-- TABLE_NAME) where (r.COLUMN1_NAME=VALUE1, r.COLUMN2_NAME=VALUE2, ...);
~~~

As before, `add` and `remove` are annotated `server` so that these will be performed on the server.

Links also supports `update` syntax, for example:

~~~
update (i <-- items)
   where (i.name == oldname)
    set (name=newname)
~~~

renames an item from `oldname` to `newname`.

### Exercises

 1. What happens if the `server` annotation is removed from `showList`, `add` or `remove`?

 2. What happens if you replace the `server` annotation with `client` in the above functions?

 3. Using `update`, modify `todo_db.links` to allow renaming an existing item.

 4. This version of the TODO list uses `l:action` to handle the form responses by POSTing to the server. Some server communication is unavoidable because we need to get data from teh database, or update the database, but it should be possible to rewrite this program to use `l:onsubmit` to avoid completely rebuilding the page whenever the a button is clicked, using a similar approach to the client-side form in lessons 3 or 5. Modify `todo_db.links` to work this way.

#### You can find the solution to this tutorial here

https://github.com/links-lang/links-tutorial/wiki/Lesson-6:-Database-TODO-list:-Updating-tables

''',
];
