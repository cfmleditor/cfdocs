# arrayLen

Determines the largest index in an array.
For dense arrays, this corresponds to the number of elements in the array.
 CF MX: this function can be used on child XML objects.

```javascript
arrayLen(array)
```

```javascript
returns numeric
```

## Member Function Syntax

```javascript
someArray.len()
```

## Argument Reference

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| array | array | Yes |  | An array from which to get the final index. |

## Using arrayLen to get the length of a dense array

Uses the arrayLen function to get the total length of a dense array

```javascript
numberArray = [1,2,3,4];
writeOutput(arrayLen(numberArray));
```

### Expected Result: 4

## Using member function to get the length of a dense array

CF11+ Lucee4.5+ Using the len member function is the same as running arrayLen.

```javascript
colorArray = ['Green','red','blue'];
writeOutput(colorArray.len());
```

### Expected Result: 3

## Using arrayLen on a sparse array

Uses the arrayLen function to get the largest index of a spare array

```javascript
sparseArray = [];
sparseArray[42] = 42;
writeOutput(arrayLen(sparseArray));
```

### Expected Result: 42
