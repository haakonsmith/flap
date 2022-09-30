# Flap

Imagine you are fluttering by in a peaceful meadow, and in the distance, you hear a loud, ungraceful, violent, troglodyte flapping by. Smashing their wings or all the good things within their reach. This is Flap.

Flap was born out of the thesaurus entry for the word Flutter, and as such, the obvious connection to that UI framework reveals that this is in fact a cheap knockoff of Flutter. Welcome to FLAP. Flap is a craftOS UI framework.

## Included functionality

Flap includes lua! But benefits include:

- An eventLoop abstraction over the `os.queueEvent`, that allows for queueing of callbacks and timers.
- _Some_ builtin widgets, and a tree based recursive renderer.
- _Some_ functionality...

## Installation/Usage

As this package was developed for use with computer craft, it is distributed as a single file, found under `/deploy`. Simply, place `flap.lua` adjacent to your script then:

```lua 
require 'flap'
```


## Development

### Building

Building uses a slightly modified version of the `many2one` script, this is in the root directory called `cc_deploy.lua`.

Run `lua cc_deploy.lua` and it will generate the singleton file.

### Fast iterations

Using the singleton can be a bit of a pain if you are me developing this library. So what I like to do is clone the repo into a craftOS instance, then just develop from there. It does not need to be portable.
