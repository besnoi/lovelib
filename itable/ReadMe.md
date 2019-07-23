# iTable Library
iTable is a very very simple but useful helper library for Lua which adds extra table functionality

### Context 
By default Lua doesn't support many table operations even important ones such
as indexOf and slice, etc. So this library is to fill that gap. 

### How to use itable?
Just do this
```lua
require 'itable'
```
And you will see that now use extra table functions such as table.slice,table.merge,table.indexOf,etc

P.S. This ReadMe file is less about documentation of the functions and more about how to achieve something. For eg. we will not discuss what table.indexOf does but rather how to get index of an element.

## Documentation

### Getting the index of an element

```lua
	table.firstIndexOf(tbl,element)
	--returns the index of the first occurence of the element in given table 

	table.lastIndexOf(tbl,element)
	--returns the index of the first occurence of the element in given table 

	table.indexOf(tbl,element)
	--same as table.firstIndexOf
```

### Check to see if an element exists in a table

```lua
	table.exists(tbl,element)
	--checks whether or not an element exists in a table
```

### Slice a table into a subset of that table

```lua
	table.slice(tbl, fromIndex, toIndex, skip)
	--make a table from 'fromIndex' to 'toIndex' and skip 'skip-1' elements continually

	table.subset(tbl, fromIndex, toIndex)
	--same as table.slice just doesn't allow skipping any element between edges
```

Remember that both table.subset and table.slice are **not in-place** so the original table will remain unchanged. They simply return the table that was sliced 

Examples:

```lua
	table.concat(table.subset({1,2,3,4,5},2,4),',')
	--Output: 2,3,4
	table.concat(table.subset({1,2,3,4,5},3),',')
	--Output: 3,4,5
	table.concat(table.slice({1,2,3,4,5,6},1,6,2),',')
	--Output: 1,3,5
```

### Get Min/Max element of a table

If you have a linear table of numbers then very often you want the minimum or maximum element of the array. In any case you can use `table.min` and `table.max`

```lua
	table.min(tbl)
	--returns minimum element of an array of numbers

	table.max(tbl)
	--returns maximum element of an array of numbers
```

### Get Range of Numbers as a table

```lua
	table.range(from, to, skip)
	--returns a table of elements in the range [from,to] and skips (skip-1) elements alternatively
```

Since there are overloads so I need to give example-

```lua
	table.concat(table.range(5),',')
	--1,2,3,4,5 (note from and skip are defaulted to 1)

	table.concat(table.range(4,10,2),',')
	--4,6,8,10 (note from and skip are defaulted to 1)
```

### Removing all occurences of an element

Quite sometimes you want to remove all the occurences of an element in a table. This can be achieved by `table.removeAll`:

```lua
	table.removeAll(tbl,el)
	--removes all occurences of el in table tbl
```

### Get Random Element in a table

```lua
	table.random(tbl)
	--gets random element in table tbl
```
For eg,
```lua
	table.random{7,8,9,10}
	--7 or 8 or 9 or 10
```

### Shuffling a table

This is the function that can really come in handy when making a card-based game like Free Cell, etc. If a table represents the cards then you can simply shuffle the table and that'd be virually shuffling the cards. Can also be useful for word-based games where you want to jumble a word provided the word is represented as a table of characters rather than string.

```lua
	table.shuffle(tbl)
	--(not in-place) returns the original table
	table.mix(tbl)
	--(in-place) shuffles the original table
```

Please note that both `table.shuffle` and `table.mix` uses different algorithms to get their jobs done. And note that `table.shuffle` calls `table.mix` under-the-hood so choose wisely.

### Reversing a table (in-place)

``table.reverse`` Reverses the table passed in the argument

```lua
	table.reverse(tbl)
	--the given table 'tbl' is reversed
```

### Copying a table

In Lua, tables are passed by references (for performance-related reasons) so when you say ``tbl1=tbl2`` tbl2 is not passed to tbl1 by value but by reference - so when you change tbl2 tbl1 is also changed. And sometimes you want that behaviour but sometimes you don't. In case you don't want that behaviour you can use table.copy

```lua
	table.copy(tbl)
	--returns a table containing exactly the same elements as tbl (can be used with all sorts of tables)
```

Example:-
```lua
	a={{1,2},3,4}
	b=table.copy(a)
	b[1]=1
	print(a[1],b[1])
```

### Appending elements to a table

```table.append``` will save you from pushing a lot of elements to the back (i.e. appending) by letting you pushing them all at one go

```lua
	table.append(tbl,value1,value2,...,valuen)
	--Push value1,...,valuen to the end of the table
```

For example

```lua
	t={1,2,3}
	table.append(t,4,5,6)
	--Now t is {1,2,3,4,5,6}
```

### Merging a table with other tables

Note that tables in this context means linear arrays (not hashtables)

```lua
	table.merge(main_tbl,tbl1,tbl2,...,tbln)
	--Push elements of tbl1 to the end of main_tbl, and so on
```

For example

```lua
	t={1,2,3}
	table.merge(t,{4},{5,6},{7})
	--Now t is {1,2,3,4,5,6,7}

	t={}
	table.merge(a,{-1},{-1,{1,2,3}},{-1})
	--Now a is {-1,-1,{1,2,3},-1}

	t={'h','e','l','l','o',' '}
	table.merge(t,{'w','o','r','l','d')
	table.concat(t)
	--Output: hello world
```

Some may get confused be table.append and table.merge and when should one use which so the next example shows the fundamental difference betwen table.append and table.merge and also gives you an idea how to handle tables when working with *tinyCSV library*-

Let's highscores be the same for both the cases i.e.
```lua
	highscores={{"Robin",0},{"Batman",10000}}
```
And then
```lua
	table.merge(highscores,{"SuperMan",10000},{"WonderWoman",20})
	--{{"Robin",0},{"Batman",10000},"SuperMan",10000,"WonderWoman",20}
```

*But this is not what we wanted, right?* Relax table.append will solve the problem

```lua
	table.append(highscores,{"SuperMan",10000},{"WonderWoman",20})
	--{{"Robin",0},{"Batman",10000},{"SuperMan",10000},{"WonderWoman",20}}
end
```

### Merging a Hash-Table with another Hash-Table

*Note:* Use this method only when table is in the hash-table (or associative arrays whatever you want to call them) format. If the table is in linear array format then use table.merge. 

The syntax is similar to table.merge 

```lua
	table.join(main_tbl,tbl1,tbl2,...,tbln)
	--Push elements of tbl1 to the end of main_tbl, and so on
```

```lua
	win={WINDOW_WIDTH=1280,WINDOW_HEIGHT=720}
	table.join(win,{RESIZABLE=false,FULLSCREEN=false},{VSYNC=false})
	--Now try =win.VSYNC or =win.RESIZABLE

	scores={['player1']=80}
	table.join(win,{['player2']=100})
	--scores={['player1']=80,['player2']=100}
```

### Dividing a table into several tables

```table.divide``` or ```table.subdivide``` will divide a table into several tables. But remember that table.subdivide should be used with hash-tables and table.divide with linear arrays.

```lua
	table.divide(tbl,n)
	--divides a linear table into n or n+1 tables

	table.subdivide(tbl,n)
	--divides a hash-table into n or n+1 tables
```

Remember that both table.subdivide and table.divide are *not in-place* so the original table will remain unchanged. They simply return the table that was divided

Examples:-

```lua
	herosandzeros={wonderwoman=20,robin=0,batman=10000,superman=10000}
	--we assume it is internally stored in the same order
	table.subdivide(herosandzeros,2)
	--returns {{wonderwoman=20,robin=0},{batman=10000,superman=10000}}

	table.subdivide({1,2,3,4,5},2)
	--returns {{1,2},{['3']=3,['4']=4},{['5']=5}}

	table.divide({1,2,3,4,5},2)
	--returns {{1,2},{3,4},{5}}
```
### An extra loop function

table.sort doesn't return anything but sometimes you want it to return so in that case you can use table.isort which works like this

```lua
	table.isort(tbl,funcn)
	--sorts table tbl a/c to rule function 'funcn' and returns the sorted table
```

Also table.isort is not in-place i.e. no changes are made to the original table

The following example illustrates the difference between table.isort and table.sort

```lua
	=table.concat(table.isort({5,7,6}))
	--567
	=table.concat(table.sort({5,7,6}))
	--ERROR
```
