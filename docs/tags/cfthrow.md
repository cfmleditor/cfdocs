# cfthrow

Throws a developer-specified exception, which can be caught
 with a cfcatch tag that has any of the following type attribute
 options:
 type = "custom_type"
 type = "Application"
 type = "Any"

### Syntax

```html
<cfthrow>
```

### Script Syntax

```javascript
throw(message="");
```

## Attribute Reference

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| type | string | No | Custom | Do not enter another predefined type; types are not<br /> generated by CFML applications. If you specify<br /> Application, you need not specify a type for cfcatch. |
| message | string | No |  | Message that describes exception event. |
| detail | string | No |  | Description of the event. CFML appends error position<br /> to description; server uses this parameter if an error is<br /> not caught by your code. |
| errorcode | string | No |  | A custom error code that you supply. |
| extendedinfo | string | No |  | A custom error code that you supply. |
| object | any | No |  | Requires the value of the cfobject tag name attribute.<br /><br /> Throws a Java exception from a CFML tag.<br /><br /> This attribute is mutually exclusive with all other<br /> attributes of this tag. |

## Script Example: Try, Throw, Catch, Finally!

Throw and Finally requires CF9+ in cfscript

```html
try {
    throw(message="Oops", detail="xyz"); //CF9+
} catch (any e) {
    writeOutput("Error: " & e.message);
} finally { //CF9+
    writeOutput("I run even if no error");
}
```

### Expected Result: Error: OopsI run even if no error
