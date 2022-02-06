# Easily construct JSON in Bash

Install by appending `json.sh` into your `~/.bash_profile`. Requires Node.js.

```bash
curl https://raw.githubusercontent.com/itsjohncs/construct-json/main/json.sh >> ~/.bash_profile
source ~/.bash_profile
```

This project provides a Bash function `json` that lets you construct JSON using JavaScript's syntax.

```console
$ json "{hello: 'world'}"
{"hello":"world"}
```

The ability to use single or double quotes makes it easier to use Bash's features.

```console
$ GREETING="how are you?"
$ json "{hello: 'world $GREETING', time: $(date +%s)}"
{"hello":"world how are you?","time":1644149394}
```

Additional arguments to `json` are available as the JavaScript variables `_1`, `_2`, `_3`, etc. Useful for untrusted input and strings with mixed quotes.

```console
$ json "{[_1]: _2}" hello "world 'of' \"ducks\""
{"hello":"world 'of' \"ducks\""}
```

Non-array Bash variables (regardless of export status) are also available as JavaScript variables.

```console
$ A=hello
$ export B=world
$ local GREETING=" how's it going?"
$ json "{[A]: B + GREETING}"
{"hello":"world how's it going?"}
```

The JavaScript is executed by Node.js so you have access to its standard library if you need it.

```console
$ json "{hello: JSON.parse(_1)[2], time: parseInt(_2)}" "[1, 2, 3]" "$(date +%s)"
{"hello":3,"time":1644149394}
```

Have fun!

--

Made with love by [johncs](https://johncs.com).
