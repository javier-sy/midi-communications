# MIDI Communications

**Platform independent realtime MIDI input and output for Ruby.**

This library is part of a suite of Ruby libraries for MIDI:

| Function | Library |
| --- | --- |
| MIDI Events representation | [MIDI Events](https://github.com/javier-sy/midi-events) |
| MIDI Data parsing | [MIDI Parser](https://github.com/javier-sy/midi-parser) |
| MIDI communication with Instruments and Control Surfaces | [MIDI Communications](https://github.com/javier-sy/midi-communications) |
| Low level MIDI interface to MacOS | [MIDI Communications MacOS Layer](https://github.com/javier-sy/midi-communications-macos) |
| Low level MIDI interface to Linux | **TO DO** (by now [MIDI Communications](https://github.com/javier-sy/midi-communications) uses [alsa-rawmidi](http://github.com/arirusso/alsa-rawmidi)) | 
| Low level MIDI interface to JRuby | **TO DO** (by now [MIDI Communications](https://github.com/javier-sy/midi-communications) uses [midi-jruby](http://github.com/arirusso/midi-jruby))| 
| Low level MIDI interface to Windows | **TO DO** (by now [MIDI Communications](https://github.com/javier-sy/midi-communications) uses [midi-winm](http://github.com/arirusso/midi-winmm)) | 

This library is based on [Ari Russo's](http://github.com/arirusso) library [UniMIDI](https://github.com/arirusso/unimidi).

### Features

* Supports OSX, Linux, JRuby, Windows and Cygwin
* No compilation required
* Both input and output to and from multiple devices concurrently
* Generalized handling of different MIDI and SysEx Message types
* On OSX use IAC to internally route MIDI to other programs
* No events history and no buffers optimization

### Requirements

**MIDI Communications** uses one of the following libraries, depending on which platform you're using it on.  The necessary library should install automatically with the midi-communications gem.

Platform

* OSX: [midi-communications-macos](http://github.com/javier-sy/midi-communications-macos)
* JRuby: [midi-jruby](http://github.com/arirusso/midi-jruby) (**TODO: update to midi-communications-jruby**)
* Linux: [alsa-rawmidi](http://github.com/arirusso/alsa-rawmidi) (**TODO: update to midi-communications-linux**)
* Windows/Cygwin: [midi-winmm](http://github.com/arirusso/midi-winmm) (**TODO: update to midi-communications-windows**)

### Install

If you're using Bundler, add this line to your application's Gemfile:

`gem "midi-communications"`

Otherwise...

`gem install midi-communications`

### Usage

Some examples are included with the library:

* [Selecting a device](http://github.com/arirusso/javier-sy/midi-communications/blob/master/examples/select_a_device.rb)
* [MIDI input](http://github.com/javier-sy/midi-communications/blob/master/examples/input.rb)
* [MIDI output](http://github.com/javier-sy/midi-communications/blob/master/examples/output.rb)
* [MIDI Sysex output](http://github.com/javier-sy/midi-communications/blob/master/examples/sysex_output.rb)

### Tests

**MIDI Communications** includes a set of tests which assume that an output is connected to an input.  You will be asked to select which input and output as the test is run.

The tests can be run using:

`rake test`

See below for additional notes on testing with JRuby.

### Documentation

[rdoc](http://rdoc.info/gems/midi-communications) (**TODO**)

### Platform Specific Notes

##### JRuby

* (**TO CONFIRM**) You must be in 1.9 mode.  This is normally accomplished by passing --1.9 to JRuby at the command line.  For testing in 1.9 mode, use `jruby --1.9 -S rake test`
* (**TO CONFIRM**) javax.sound has some documented issues with SysEx messages in some versions OSX Snow Leopard which do affect this library.

##### Linux

* (**TO CONFIRM**) *libasound* and *libasound-dev* packages are required

## Differences between [MIDI Communications](https://github.com/javier-sy/midi-communications) library and [UniMIDI](https://github.com/arirusso/unimidi) library

[MIDI Communications](https://github.com/javier-sy/midi-communications) is mostly a clone of [UniMIDI](https://github.com/arirusso/unimidi) with some modifications:
* Uses [MIDI Communications MacOS Layer](https://github.com/javier-sy/midi-communications-macos) instead of [ffi-coremidi](https://github.com/arirusso/ffi-coremidi)
* Removed buffering (to reduce CPU usage in some scenarios)
* Source updated to Ruby 2.7 code conventions (method keyword parameters instead of options = {}, hash keys as 'key:' instead of ':key =>', etc.)
* Updated dependencies versions
* Renamed module to MIDICommunications instead of UniMIDI
* Renamed gem to midi-communications instead of unimidi
* TODO: update tests to use rspec instead of rake
* TODO: migrate to (or confirm it's working ok on) Ruby 3.0 and Ruby 3.1

## Then, why does exist this library if it is mostly a clone of another library?

The author has been developing since 2016 a Ruby project called
[Musa DSL](https://github.com/javier-sy/musa-dsl) that needs a way
of representing MIDI Events and a way of communicating with
MIDI Instruments and MIDI Control Surfaces.

[Ari Russo](https://github.com/arirusso) has done a great job creating
several interdependent Ruby libraries that allow
MIDI Events representation ([MIDI Message](https://github.com/arirusso/midi-message)
and [Nibbler](https://github.com/arirusso/nibbler))
and communication with MIDI Instruments and MIDI Control Surfaces
([unimidi](https://github.com/arirusso/unimidi),
[ffi-coremidi](https://github.com/arirusso/ffi-coremidi) and others)
that, **with some modifications**, I've been using in MusaDSL.

After thinking about the best approach to publish MusaDSL
I've decided to publish my own renamed versions of the modified dependencies because:

* The original libraries have features
  (buffering, very detailed logging and processing history information, not locking behaviour when waiting input midi messages)
  that are not needed in MusaDSL and, in fact,
  can degrade the performance on some use cases in MusaDSL.
* The requirements for **Musa DSL** users probably will evolve in time, so it will be easier to maintain an independent source code base.
* Some differences on the approach of the modifications vs the original library doesn't allow to merge the modifications on the original libraries.
* Then the renaming of the libraries is needed to avoid confusing existent users of the original libraries.
* Due to some of the interdependencies of Ari Russo libraries,
  the modification and renaming on some of the low level libraries (ffi-coremidi, etc.)
  forces to modify and rename unimidi library.

All in all I have decided to publish a suite of libraries optimized for MusaDSL use case that also can be used by other people in their projects.

| Function | Library | Based on Ari Russo's| Difference |
| --- | --- | --- | --- |
| MIDI Events representation | [MIDI Events](https://github.com/javier-sy/midi-events) | [MIDI Message](https://github.com/arirusso/midi-message) | removed parsing, small improvements |
| MIDI Data parsing | [MIDI Parser](https://github.com/javier-sy/midi-parser) | [Nibbler](https://github.com/arirusso/nibbler) | removed process history information, minor optimizations |
| MIDI communication with Instruments and Control Surfaces | [MIDI Communications](https://github.com/javier-sy/midi-communications) | [unimidi](https://github.com/arirusso/unimidi) | use of [MIDI Communications MacOS Layer](https://github.com/javier-sy/midi-communications-macos, removed process history information, removed buffering, removed command line script)
| Low level MIDI interface to MacOS | [MIDI Communications MacOS Layer](https://github.com/javier-sy/midi-communications-macos) | [ffi-coremidi](https://github.com/arirusso/ffi-coremidi) | removed buffering and process history information, locking behaviour when waiting midi events, improved midi devices name detection, minor optimizations |
| Low level MIDI interface to Linux | **TO DO** | | |
| Low level MIDI interface to JRuby | **TO DO** | | |
| Low level MIDI interface to Windows | **TO DO** | | |

## Author

* [Javier Sánchez Yeste](https://github.com/javier-sy)

## Acknowledgements

Thanks to [Ari Russo](http://github.com/arirusso) for his ruby library [unimidi](https://github.com/arirusso/unimidi) licensed under Apache License 2.0.

### License

[MIDI Communications](https://github.com/javier-sy/midi-communications) Copyright (c) 2021 [Javier Sánchez Yeste](https://yeste.studio), licensed under LGPL 3.0 License

[unimidi](https://github.com/arirusso/unimidi) Copyright (c) 2010-2017 [Ari Russo](http://arirusso.com), licensed under Apache License 2.0 (see the file LICENSE.unimidi)
