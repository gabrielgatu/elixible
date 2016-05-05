# Elixible

Elixible is a minimal, and still under development, XMPP client written in elixir.

This project is born with the intention just to understand better how XMPP works, so, this has to be considered as a learning project and, definitively, not production ready.

More details will be added as soon as I have some free time :)

## Usage

- To login with a user:
  ```
   Sample.Client.login(jid, password)

  Example: Sample.Client.login "gabriel@localhost", "pass"
   ```

- To send a message:
  ```
  Sample.Client.send_message(from, to, message)

  Example: Sample.Client.send_message "gabriel@localhost", "foobar@localhost", "hi!"
  ```

## Supported actions

Currently, only authentication and message exchange is supported.

## Handlers available

A handler is just a callback, when the user receives a stanza, it is mapped into a struct and passed into its handler.

**Currently available:**

- handle_iq
- handle_chatstate
- handle_message

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
