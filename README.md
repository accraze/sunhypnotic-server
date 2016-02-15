# sunhypnotic-server

Haskell based JSON API for SunHypnotic release data.
Work in Progress.

http://sunhypnotic.com

## Build & Run

First clone the repo:

```

$ git clone http://github.com/accraze/sunhypnotic-server
$ cd sunhypnotic-server

```

This project is built using [Stack](http://docs.haskellstack.org/en/stable/README.html). To install all deps and build an executable:

```
$ stack setup
...
$ stack build

```

Then you can use the `ghci` REPL to interact with the API.

```
$ stack ghci
....
*SunHypnotic> serve
Starting Server...
Setting phasers to stun... (port 3000) (ctrl-c to quit)
```

Then you can get JSON release data at http://localhost:3000/releases or http://localhost:3000/releases/:id

## License

[MIT](https://github.com/accraze/sunhypnotic-server/blob/master/LICENSE) License 2016 © accraze

