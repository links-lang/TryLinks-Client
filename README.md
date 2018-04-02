# TryLinks Server

TryLinks client repository.

Live at [here](http://devpractical.com:5000/web).

Powered by [AngularDart](https://webdev.dartlang.org/angular), [Socket.IO](https://socket.io/), and more.

## Usage

First clone this repository using

~~~bash
git clone https://github.com/NickWu007/TryLinks-Client.git
~~~

Then use the angular dart cli tool to serve a live preview. Make sure you have the [TryLinks Server](https://github.com/NickWu007/TryLinks-Server) running as well.

~~~bash
pub serve -DService=http://localhost
~~~

The `-DService` is to point to the address of the server.

You can also buid the client into plain javascript and html.

~~~bash
pub build -DService=http://localhost
~~~

This will generate a `build` directory. Move the content of this directory to `public` under *TryLinks-Server*. Then rerun the server. You should be able to view the functional website at `http://localhost:5000/web`.

## Notes to Contributors

### Fork TryLinks server

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.
