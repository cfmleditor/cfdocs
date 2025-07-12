# isSimpleValue

Returns true only if the value is a string, boolean, numeric, or date.

```javascript
isSimpleValue(value)
```

```javascript
returns boolean
```

## Argument Reference

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| value | any | Yes |  |  |

## A number is a simple value

```javascript
isSimpleValue(42)
```

### Expected Result: YES

## A string is a simple value

```javascript
isSimpleValue("Hello world")
```

### Expected Result: YES

## Null is a complex value

For engines that support null, such as Lucee and Railo, `null` is considered a complex value.

```javascript
isSimpleValue( javaCast('null', '') )
```

### Expected Result: NO

## A structure is a complex value

```javascript
isSimpleValue({})
```

### Expected Result: NO

## An array is a complex value

```javascript
isSimpleValue([])
```

### Expected Result: NO

## A list is a simple value

As lists are just strings with delimiters, they are simple values.

```javascript
isSimpleValue(arrayToList([]))
```

### Expected Result: YES
