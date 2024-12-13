# Surging Blood Guidelines

## **Table of Contents**
- [Coding Guidelines](#coding-style-guidelines)
- [Project Guidelines](#project-guidelines)

## Coding Style Guidelines

This project follows a coding style inspired by the [**GDScript Style Guide**](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html). The following section describe all the guidelines.  
*NB: Some of the guidelines are mere copy of the ones in **GDScript Style Guide**.*

> *This style guide lists conventions to write elegant GDScript. The goal is to encourage writing clean, readable code and promote consistency across projects, discussions, and tutorials. Hopefully, this will also support the development of auto-formatting tools.*

## **Table of Contents**
- [Formatting](#formatting)
  - [Encoding and special characters](#encoding-and-special-characters)
  - [Indenting](#indenting)
  - [Traling Comma](#traling-comma)
  - [Blank Lines](#blank-lines)
  - [Line Length](#line-length)
  - [One statement per line](#one-statement-per-line)
  - [Format multiline statements for readability](#format-multiline-statements-for-readability)
  - [Avoid unnecessary parentheses](#avoid-unnecessary-parentheses)
  - [Boolean operators](#boolean-operators)
  - [Comment spacing](#comment-spacing)
  - [Whitespace](#whitespace)
  - [Quotes](#quotes)
  - [Numbers](#numbers)
  - [Typing](#typing)
  - [Inferring types](#inferring-types)
- [Naming conventions](#naming-conventions)
  - [File names](#file-names)
  - [Classes and Nodes](#classes-and-nodes)
  - [Functions and Variables](#functions-and-variables)
  - [Signals](#signals)
  - [Constants and Enums](#constants-and-enums)
- [Code order](#code-order)
  - [Class Declaration](#class-declaration)
  - [Signals and properties](#signals-and-properties)
  - [Member variables](#member-variables)
  - [Local variables](#local-variables)
  - [Methods and static functions](#methods-and-static-functions)

## Formatting

### Encoding and special characters

- Use line feed (LF) characters to break lines, not CRLF or CR. (editor default)
- Use one line feed character at the end of each file. (editor default)
- Use UTF-8 encoding without a byte order mark. (editor default)
- Use Tabs instead of spaces for indentation. (editor default)

### Indenting

Each indent level should be one greater than the block containing it.

**Good**:

```python
for i in range(10):  
   print("hello")
```

**Bad**:

```python
for i in range(10):
  print("hello")

for i in range(10):
		print("hello")
```

Use 2 indent levels to distinguish continuation lines from regular code blocks.

**Good**:

```python
effect.interpolate_property(sprite, "transform/scale",
		sprite.get_scale(), Vector2(2.0, 2.0), 0.3,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
```

**Bad**:

```python
effect.interpolate_property(sprite, "transform/scale",
	sprite.get_scale(), Vector2(2.0, 2.0), 0.3,
	Tween.TRANS_QUAD, Tween.EASE_OUT)
```

**Exception**: Arrays, dictionaries, and enums uses a single indentation level to distinguish continuation lines:

**Good**:

```python
var party = [
	"Godot",
	"Godette",
	"Steve",
]

var character_dict = {
	"Name": "Bob",
	"Age": 27,
	"Job": "Mechanic",
}

enum Tiles {
	TILE_BRICK,
	TILE_FLOOR,
	TILE_SPIKE,
	TILE_TELEPORT,
}
```

**Bad**:

```python
var party = [
		"Godot",
		"Godette",
		"Steve",
]

var character_dict = {
		"Name": "Bob",
		"Age": 27,
		"Job": "Mechanic",
}

enum Tiles {
		TILE_BRICK,
		TILE_FLOOR,
		TILE_SPIKE,
		TILE_TELEPORT,
}
```

### Traling Comma

Use a trailing comma on the last line in arrays, dictionaries, and enums. This results in easier refactoring and better diffs in version control as the last line doesn't need to be modified when adding new elements.

**Good**:

```python
var array = [
	1,
	2,
	3,
]
```

**Bad**:

```python
var array = [
	1,
	2,
	3
]
```

**Exception**: Trailing commas are unnecessary in single-line lists, so don't add them in this case.

**Good**:

```python
var array = [1, 2, 3]
```

**Bad**:

```python
var array = [1, 2, 3,]
```

### Blank Lines

Surround functions and class definitions with two blank lines:

```python
func heal(amount):
	health += amount
	health = min(health, max_health)
	health_changed.emit(health)


func take_damage(amount, effect=null):
	health -= amount
	health = max(0, health)
	health_changed.emit(health)
```

*Use one blank line inside functions to separate logical sections.*

### Line Length

Keep individual lines of code under 80 characters.

*This helps to read the code on small displays and with two scripts opened side-by-side in an external text editor. For example, when looking at a differential revision.*

### One statement per line

Avoid combining multiple statements on a single line, including conditional statements, to adhere to the GDScript style guidelines for readability.

**Good**:

```python
if position.x > width:
	position.x = 0

if flag:
	print("flagged")
```

**Bad**:

```python
if position.x > width: position.x = 0

if flag: print("flagged")
```

**Exception**: The ternary operator can be written on one line

```python
next_state = "idle" if is_on_floor() else "fall"
```

### Format multiline statements for readability

When you have particularly long if statements or nested ternary expressions, wrapping them over multiple lines improves readability.  
Since continuation lines are still part of the same expression, 2 indent levels should be used instead of one.

GDScript allows wrapping statements using multiple lines using parentheses or backslashes.  
Parentheses are favored in this style guide since they make for easier refactoring.
With backslashes, you have to ensure that the last line never contains a backslash at the end.  
With parentheses, you don't have to worry about the last line having a backslash at the end.

When wrapping a conditional expression over multiple lines, the `and`/`or` keywords should be placed at the beginning of the line continuation, not at the end of the previous line.

**Good**:

```python
var angle_degrees = 135
var quadrant = (
		"northeast" if angle_degrees <= 90
		else "southeast" if angle_degrees <= 180
		else "southwest" if angle_degrees <= 270
		else "northwest"
)

var position = Vector2(250, 350)
if (
		position.x > 200 and position.x < 400
		and position.y > 300 and position.y < 400
):
	pass
```

**Bad**:

```python
var angle_degrees = 135
var quadrant = "northeast" if angle_degrees <= 90 else "southeast" if angle_degrees <= 180 else "southwest" if angle_degrees <= 270 else "northwest"

var position = Vector2(250, 350)
if position.x > 200 and position.x < 400 and position.y > 300 and position.y < 400:
	pass
```

### Avoid unnecessary parentheses

Avoid parentheses in expressions and conditional statements.  
Unless necessary for order of operations or wrapping over multiple lines, they only reduce readability.

**Good**:

```python
if is_colliding():
	queue_free()
```

**Bad**:

```python
if (is_colliding()):
	queue_free()
```

### Boolean operators

Prefer the plain English versions of boolean operators, as they are the most accessible:

- Use `and` instead of `&&`.
- Use `or` instead of `||`.
- Use `not` instead of `!`.

You may also use parentheses around boolean operators to clear any ambiguity. This can make long expressions easier to read.

**Good**:

```python
if (foo and bar) or not baz:
	print("condition is true")
```

**Bad**:

```python
if foo && bar || !baz:
	print("condition is true")
```

### Comment spacing

Regular comments (#) and documentation comments (##) should start with a space, but not code that you comment out. Additionally, code region comments (#region/#endregion) must follow that precise syntax, so they should not start with a space.

Using a space for regular and documentation comments helps differentiate text comments from disabled code.

**Good**:

```python
# This is a comment.
## This is a documentation comment.
#print("This is disabled code")
```

**Bad**:

```python
#This is a comment.
##This is a documentation comment.
# print("This is disabled code")
```

### Whitespace

Always use one space around operators and after commas. Also, avoid extra spaces in dictionary references and function calls. One exception to this is for single-line dictionary declarations, where a space should be added after the opening brace and before the closing brace. This makes the dictionary easier to visually distinguish from an array, as the `[]` characters look close to `{}` with most fonts.

**Good**:

```python
position.x = 5
position.y = target_position.y + 10
dict["key"] = 5
my_array = [4, 5, 6]
my_dictionary = { key = "value" }
print("foo")
```

**Bad**:

```python
position.x=5
position.y = mpos.y+10
dict ["key"] = 5
myarray = [4,5,6]
my_dictionary = {key = "value"}
print ("foo")
```

*Don't use spaces to align expressions vertically:*

```python
x        = 100
y        = 100
velocity = 500
```

### Quotes

Use double quotes unless single quotes make it possible to escape fewer characters in a given string. See the examples below:


```python
# Normal string.
print("hello world")

# Use double quotes as usual to avoid escapes.
print("hello 'world'")

# Use single quotes as an exception to the rule to avoid escapes.
print('hello "world"')

# Both quote styles would require 2 escapes; prefer double quotes if it's a tie.
print("'hello' \"world\"")
```

### Numbers

Don't omit the leading or trailing zero in floating-point numbers. Otherwise, this makes them less readable and harder to distinguish from integers at a glance.

**Good**:

```python
var float_number = 0.234
var other_float_number = 13.0
```

**Bad**:

```python
var float_number = .234
var other_float_number = 13.
```

*Use lowercase for letters in hexadecimal numbers, as their lower height makes the number easier to read.*

**Good**:

```python
var hex_number = 0xfb8c0b
```

**Bad**:

```python
var hex_number = 0xFB8C0B
```

*Take advantage of GDScript's underscores in literals to make large numbers more readable.*

**Good**:

```python
var large_number = 1_234_567_890
var large_hex_number = 0xffff_f8f8_0000
var large_bin_number = 0b1101_0010_1010
# Numbers lower than 1000000 generally don't need separators.
var small_number = 12345
```

**Bad**:

```python
var large_number = 1234567890
var large_hex_number = 0xfffff8f80000
var large_bin_number = 0b110100101010
# Numbers lower than 1000000 generally don't need separators.
var small_number = 12_345
```

### Typing

Put a space after the colon when declaring a type.

**Good**:

```python
var health: int = 0
```

**Bad**:

```python
var health:int = 0
```

Similary, put a space before and after the arrow when declaring a return type for a function.

**Good**:

```python
func get_health() -> int:
    return health
```

**Bad**:

```python
func get_health()->int:
    return health
```

### Inferring types

When the type is clearly inferred, you can use the `:=` operator to declare a variable without specifying its type.

**Good**:

```python
var health: int = 100 # The type can be int or float
var position := Vector2(0, 0) # The type is clearly Vector2
```

**Bad**:

```python
var health := 100 # Is it a int or a float ?
var position: Vector2 = Vector2(0, 0) # The type hint is not necessary

var data := load_data() # What is the return type ?
```

Sometimes, you may want to hint the type, as the return type of a function, even though it may be explicit, may not be what you expect.

```python
# get_node() returns a Node, so we need to hint the type to the correct one.
@onready var health_bar: ProgressBar = get_node("UI/LifeBar")
```

Alternatively, you can use the `as` keyword to cast the return type, and that type will be used to infer the type of the var.

```python
# casting the return type to ProgressBar so the type is inferred correctly.
@onready var health_bar := get_node("UI/LifeBar") as ProgressBar
```

## Naming conventions

### File names

Use `snake_case` for file names and folders.  
For named classes, convert the `PascalCase` class name to snake_case:

```python
# This file should be saved as `weapon.gd`.
class_name Weapon
extends Node
```

```python
# This file should be saved as `yaml_parser.gd`.
class_name YAMLParser
extends Object
```

### Classes and Nodes

Use `PascalCase` for class and node names:

```python
extends CharacterBody3D
```

Also use `PascalCase` when loading a class into a constant or a variable:

```python
const Weapon = preload("res://weapon.gd")
```

### Functions and Variables

Use `snake_case` to name functions and variables:

```python
var particle_effect
func load_level():
```

Prepend a single underscore `_` to virtual methods functions the user must override, private functions, and private variables:

```gdscript
var _counter = 0
func _recalculate_path():
```

### Signals

Use the past tense to name signals:

```python
signal door_opened
signal score_changed
```

### Constants and Enums

Write constants with `CONSTANT_CASE`:

```python
const MAX_HEALTH = 100
const DEFAULT_SPEED = 5
```

Use `PascalCase` for enum names and `CONSTANT_CASE` for their members:

**Good**:

```python
enum Element {
	EARTH,
	WATER,
	AIR,
	FIRE,
}
```

**Bad**:

```python
enum Element { EARTH, WATER, AIR, FIRE }
```

## Code order

```python
01. @tool
02. class_name
03. extends
04. ## docstring

05. signals
06. enums
07. constants
08. @export variables
09. public variables
10. private variables
11. @onready variables

12. optional built-in virtual _init method
13. optional built-in virtual _enter_tree() method
14. built-in virtual _ready method
15. remaining built-in virtual methods
16. public methods
17. private methods
18. subclasses
```

### Class Declaration

If the code is meant to run in the editor, place the `@tool` annotation on the first line of the script.

> *You can use this code to know if the code runs in the editor or not.*
>
> ```python
> if Editor.is_editor_hint():
>     print("This code runs in the editor.")
> else:
>     print("This code runs in the game.")
> ```

Follow with the `class_name` if necessary.  
You can turn a GDScript file into a global type in your project using this feature. For more information, see GDScript reference.

Then, add the `extends` keyword if the class extends a built-in type.

Following that, you should have the class's optional documentation comments.  
You can use that to explain the role of your class to your teammates, how it works, and how other developers should use it, for example.

```python
class_name MyNode
extends Node
## A brief description of the class's role and functionality.
##
## The description of the script, what it can do,
## and any further detail.
```

### Signals and properties

Write signal declarations, followed by properties, that is to say, member variables, after the docstring.

Enums should come after signals, as you can use them as export hints for other properties.

Then, write constants, exported variables, public, private, and onready variables, in that order.

```python
signal player_spawned(position)

enum Jobs {
	KNIGHT,
	WIZARD,
	ROGUE,
	HEALER,
	SHAMAN,
}

const MAX_LIVES = 3

@export var job: Jobs = Jobs.KNIGHT
@export var max_health = 50
@export var attack = 5

var health = max_health:
	set(new_health):
		health = new_health

var _speed = 300.0

@onready var sword = get_node("Sword")
@onready var gun = get_node("Gun")
```

### Member variables

Don't declare member variables if they are only used locally in a method, as it makes the code more difficult to follow. Instead, declare them as local variables in the method's body.

### Local variables

Declare local variables as close as possible to their first use.  
This makes it easier to follow the code, without having to scroll too much to find where the variable was declared.

### Methods and static functions

After the class's properties come the methods.

Start with the `_init()` callback method, that the engine will call upon creating the object in memory. Follow with the `_ready()` callback, that Godot calls when it adds a node to the scene tree.

These functions should come first because they show how the object is initialized.

Other built-in virtual callbacks, like `_unhandled_input()` and `_physics_process`, should come next. These control the object's main loop and interactions with the game engine.

The rest of the class's interface, public and private methods, come after that, in that order.

```python
func _init():
	add_to_group("state_machine")


func _ready():
	state_changed.connect(_on_state_changed)
	_state.enter()


func _unhandled_input(event):
	_state.unhandled_input(event)


func transition_to(target_state_path, msg={}):
	if not has_node(target_state_path):
		return

	var target_state = get_node(target_state_path)
	assert(target_state.is_composite == false)

	_state.exit()
	self._state = target_state
	_state.enter(msg)
	Events.player_state_changed.emit(_state.name)


func _on_state_changed(previous, new):
	print("state changed")
	state_changed.emit()
```

## Project Guidelines

This section describes the guidelines for the project structure.

## **Table of Contents**
- [Naming Conventions](#naming-conventions-1)
- [Folder Structure](#folder-structure)
- [Folder Content](#folder-content)
- [Branches and Commits](#branches-and-commits)

## Naming Conventions
*see [Naming Conventions](#naming-conventions)*

* **Folders**: Use `snake_case` for folder names.
* **Files**: Use `snake_case` for file names.
* **Scripts**: Use `snake_case` for script names.
* **Scenes**: Use `snake_case` for scene names.

Folders name are plural and should mark a group of files that share a common purpose.

**Good**:

```python
assets # Contains all the assets of the project

attributes # Contains all the attributes of the project
```

**Bad**:

```python
asset # Contains all the assets of the project
```

## Folder Structure

The root folder of the project should contain the following folders:

```
root
├── assets
│   ├── textures
│   ├── sounds
│   ├── fonts
│   ├── shaders
│   ├── scenes
│   └── scripts
└── icon.svg
```

It's possible to add more folders to group assets of the same type that we be used for the same purpose.
The folder name then may not use the plural form if the group of assets is used for the same purpose (A single model for example).

```python
root
├── assets
│   ├── textures
│   │   ├── entities
│   │   │   ├── player # Not plural because it's a single entity
│   │   │   │   ├── face.png
│   │   │   │   └── feet.png
│   │   │   └── enemies
│   │   ├── items
│   │   ├── tiles
...
```

## Folder Content

A folder should contain only files of the same type. For example, the `textures` folder should only contain image files.

**Good**:

```python
root
├── assets
│   ├── textures
│   │   ├── face.png
│   │   └── feet.png
...
```

**Bad**:

```python
root
├── assets
│   ├── textures
│   │   ├── explosion.wav # Not a texture
│   │   ├── face.png
│   │   └── feet.png
...
```

## Branches and Commits

Branches should be named after the feature they implement or the bug they fix with the name of the person who mainly works on it and use `camelCase`.

**Good**:

```python
# Lucas is working on the player movement
git checkout -b lucas_PlayerMovement
```

**Bad**:

```python
# What is this branch about ? Who is working on it ?
git checkout -b codedelamorkitu
```

Commits should be small and concise. They should only implement a single feature or fix a single bug and start with a keyword that symbolize what it is about.

**Good**:

```python
git commit -m "feat: Add player movement"
git commit -m "fix: Fix player movement"
git commit -m "merge: Merge branch 'lucas_PlayerMovement'"
git commit -m "change: Change player speed movement"
```

**Bad**:

```python
# Is it a feature or a change ?
git commit -m "Added cooldown"
```
