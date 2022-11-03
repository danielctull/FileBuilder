# FileBuilder

This package contains two result builders, `FileBuilder` and `TextBuilder` which can be used together to generate directories & files.

### FileBuilder

`FileBuilder` allows the creation of directories and files. This allows one script to create the correct directory structure and generate multiple files within them.

A file builder takes a list of `File` values to build up. Three primary kinds are provided:
* `Directory`: Defines a directory and its contents.
* `DataFile`: Creates a new file with data.
* `TextFile`: Creates a new text file, with contents generated with a `TextBuilder`.

#### TextBuilder

`TextBuilder` is used for building up a string inside of a `TextFile`.
