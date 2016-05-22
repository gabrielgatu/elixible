# Elixible

Elixible is a minimal, and still under development, XMPP client written in elixir.

This project is born with the intention just to understand better how XMPP works, so, this has to be considered as a learning project and, definitively, not production ready.

More details will be added as soon as I have some free time :)

## Project Structure

- Auth: Authentication system. Currently very minimal (and bad). Only plain supported.

- Client: Modules for connection, handlers, user API.

- XMPP: Parsing and mapping modules.

## Setup

First of all you have to config a module as a client. It will be responsable for implementing the *handlers*.
To do so, go to your `/config` folder and add the configuration:

```
config :elixible,
  client: ModuleName.Client
```

## Usage

- To login with a user:
  ```
   Client.login(jid, password)

   Example: Client.login "gabriel@localhost", "pass"
   ```

- To send a message:
  ```
  Client.send_message(from, to, message)

  Example: Client.send_message "gabriel@localhost", "foobar@localhost", "hi!"
  ```

- To send a presence:
  ```
  Client.send_presence(from, status)

  Example: Client.send_presence "gabriel@localhost", "Available right now!"
  ```

- To show online users:
  ```
  Client.online_users(from)

  Example: Client.online_users "gabriel@localhost"
  ```

## Supported actions

Supported features:

- Login
- Send/Receive presence
- Send/Receive messages
- Show online users

## Handlers available

A handler is just a callback, when the user receives a stanza, it is mapped into a struct and passed into its handler.

**Currently available:**

- handle_iq
- handle_chatstate
- handle_presence
- handle_message

## Libraries used

[XmppMapper](https://github.com/gabrielgatu/xmpp_mapper) is used to parse all the xml stanzas received from the socket.

## License

The MIT License (MIT)

Copyright (c) 2016 Gabriel Gatu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
