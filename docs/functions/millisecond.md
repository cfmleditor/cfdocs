# millisecond

Returns the milliseconds of the referenced date.

```javascript
millisecond(date [, timezone])
```

```javascript
returns numeric
```

## Member Function Syntax

```javascript
date.millisecond([timezone])
```

## Argument Reference

| Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| date | date | Yes |  | date object |
| timezone | string | No |  | A datetime object is independent of a specific timezone; it is only an offset in milliseconds from 1970-1-1 00.00:00 UTC (Coordinated Universal Time).<p>The timezone only comes into play when you need specific information like hours in a day, minutes in a hour or which day it is as these calculations depend on the timezone.</p><p>A timezone must be specified in order to translate the date object to something else. If you do not provide the timezone in the function call, it will default to the timezone specified in the Lucee Administrator (Settings/Regional), or the timezone specified for the current request using the function setTimezone().</p><p>You can find a list of all available timezones in the Lucee administrator (Settings/Regional). Some examples of valid timezones include:</p><ul><li>AGT (for time in Argentina)</li><li>Europe/Zurich (for time in Zurich/Switzerland)</li><li>HST (Hawaiian Standard Time in the USA)</li></ul> |
