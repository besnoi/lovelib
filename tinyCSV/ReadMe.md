## TinyCSV:

A very useful library which makes handling with CSV's much easy. You even get to choose the format of your file and also how the data must be passed to the table. The documentation here is incomplete and somewhat outdated. I recommend you to read the comments to understand what each and every function does. Finally you can go to https://github.com/YoungNeer/arkanoid to see how tinyCSV is used in my arkanoid game which was one of my first love2d games and may be one of the best (it also used Anima a lot)

## DOCUMENTATION:

Like I said earlier tiniCSV is a no-nonsense library for Lua which you can use on your LOVE2D project without going through the 'pain' to credit the author (i.e. me). Basically it works like this:-

```lua
    csvfile=require('tiniCSV')
    --csvfile is now the file object that will be used to read/write files
```

### Format of storing data

Before reading and writing file you must know how you want to store data. There are *two ways* you can store data using tinyCSV - each has its own limitations and advantages. And you must use the same format for both reading and writing - otherwise things won't work.
The two formats are:- 
    Format `1`: `[key]=value` format
    Format `2`: `{key,value}` format

**Please remember the ordering**

### PARSING/READING A CSV FILE

```lua
    csvfile:parse(path,sep,format)
    --returns a table representing the data in the file
    --path is the file's source path, sep is the delimiter (':','=',etc) and format is 1 or 2 (refer above)
```

Now let's say `"env.csv"` (in the same directory) looks like this
```csv
env.csv:
    GAME_WIDTH=1280,
    GAME_HEIGHT=720
```

So if you want to parse the data and store it in ``game_environment``, you could do that as follows
```lua
    game_environment=csvfile:parse('env.csv','=',1)
    --same as game_environment=csvfile:parse("env.csv")
```

Now you can use game_environment in your game

```lua
    =game_environment['GAME_WIDTH']
    --1280
    =game_environment['GAME_HEIGHT']
    --720
```

Apparently that's not the only way of reading files. If you want default values ':' for delimiter and 2 for the format then you can use the read function

```lua
    csvfile:read(path)
    --same as parse only difference that delimiter and format are fixed (i.e. ':' and 2)
```

Let's say we have a file `"highscores.save"` (in same directory) as follows:-
```csv
    robin:1000,
    jack:20,
    robin:200
```
Note that the delimiter is ':' instead of '=' and also note that robin occurs twice and we want BOTH ENTRIES which would be impossible if we use format 1, so rather than calling parse and passing the same last two arguments you can use `read` and that should save you some time and all that. So now let's look at the example

```lua
    highscores=csvfile:read('highscores.save')
    print(highscores[1][1],highscores[1][2])
    --robin 1000
    print(highscores[3][1],highscores[3][2])
    --robin 200
```

What if the file isn't in the same directory and in some other directory? In that case you can just specify the relative or absolute path to the file with the filename. But most of the time you will just want to save in the default Love2D save directory - in that case you can juse `parseFile` or `readFile`

```lua
    csvfile:parseFile(filename,delimiter,format)
    csvfile:readFile(filename)
```

### Error handling

Most libraries (particulary Lua ones) would perform any kind of error handling and if they
do they will do it in their own way therby leaving the developer powerless. This is not the case with this library and any other of Neer's libraries (You can bet on it) 

So what if the csvfile is deleted or maybe no data was retrieved?? Maybe the user, the system or you yourself are responsible
But that doesn't matter, our csvfile is deleted (or data is currupt) and what do we do now?

#### When no data is read (file is empty)

Simple, if no data is read then that means csvfile is simply `false`, so you check for that

#### When file doesn't exist 

When a file doesn't exist then csvfile has no value i.e. `nil`

#### In a nutshell!
```lua
if game_environment==false then --No data was read i.e. file is empty
elseif game_environment==nil then --File doesn't exist
end
```

### Comments in CSV Files
And what about comments? Well anything which doesn't fit the key=value format
will be considered as a comment. But I recommend you to start them with a #, like this-

``  #This is a comment
    batman=60,robin=20
``

### WRITING INTO CSV FILE

Now to write out a table's data into the CSV file you can do this 

```lua
    csvfile:write(path,table,delimiter,format)
    --write table to given file
    csvfile:writeFile(filename,table,delimiter,format)
    --write table to given file (in love's default save directory)    
```

And please note that you must specify the format if the format is 2 or in other words the format is 1 by default and delimiter is '=' by default. The only arguments that are must are filename/path and table.

### APPENDING INTO CSV FILE

When you write a file you are essentially truncating the file so to append you need to use the append functions-

```lua
    csvfile:append(path,table,delimiter,format)
    --write table to the end of the given file
    csvfile:appendFile(filename,table,delimiter,format)
    --write table to the end of the given file (in love's default save directory)    
```

**NOTE THAT YOU WILL NEED <a href="https://github.com/YoungNeer/lovelib/tree/master/itable">iTable</a> WHEN USING append OR appendFile**
