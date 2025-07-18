# spreadsheetDeleteColumns

Deletes the data from multiple columns of an Excel spreadsheet object. This function does not remove the columns.

```javascript
spreadsheetDeleteColumns(spreadsheetObj, range)
```

```javascript
returns void
```

## Argument Reference

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| spreadsheetObj | variableName | Yes |  | No Help Available |
| range | numeric | Yes |  | No Help Available |

## Tag Example

```javascript
<cfset q = queryNew("Name,Beers,Vegetables,Fruits,Meats", "cf_sql_varchar,cf_sql_integer,cf_sql_integer,cf_sql_integer,cf_sql_integer")> 
 <!---<cfloop index="x" from="1" to="10">---> 
 <cfset queryAddRow(q)> 
 <cfset querySetCell(q, "Name", "John")> 
 <cfset querySetCell(q, "Beers", "1")> 
 <cfset querySetCell(q, "Vegetables", "1")> 
 <cfset querySetCell(q, "Fruits", "1")> 
 <cfset querySetCell(q, "Meats", "1")> 
 <cfset mySheet =   SpreadsheetNew( "Test"  ) /> 
 <!--- Make a spreadsheet object ---> 
 <cfset s = spreadsheetNew()> 
 <!--- Add header row ---> 
 <cfset spreadsheetAddRow(s, "Name,Beers,Vegetables,Fruits,Meats")> 
 <!--- Add query ---> 
 <cfset SpreadsheetDeleteColumn(s,2-3) > 
 <cfdump var="#s#" /> <cfheader name="Content-Disposition" value="inline; filename=testFile.xls">  <cfcontent type="application/vnd.msexcel" variable="#SpreadSheetReadBinary(s)#">
```
