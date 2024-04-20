<cfset dataDir = expandPath("../data/en")>
<cfset guideDir = expandPath("../guides/en")>
<cfset tags = []>
<cfset functions = []>
<cfset guides = []>
<cfset all = []>
<cfset categories = []>
<cfset versions = {"4"=[], "4.5"=[],"5"=[],"6"=[],"7"=[],"8"=[],"9"=[],"10"=[],"11"=[],"2016"=[],"2018"=[],"2021"=[],"2023"=[]}>
<cfset lucee_versions = {"5"=[],"6"=[]}>
<cfloop array="#directoryList(dataDir, false, "array")#" index="filePath">
	<cfset json = fileRead(filePath,"utf-8")>
	<cftry>
		<cfset data = deserializeJSON(json)>
		<cfset nameKey = getFileFromPath(filePath)>
		<cfset nameKey = lCase(replace(nameKey, ".json", ""))>
		<cfif structKeyExists(data, "type")>
			<cfif data.type IS "tag">
				<cfset arrayAppend(tags, nameKey)>
				<cfset arrayAppend(all, nameKey)>
			<cfelseif data.type IS "function">
				<cfset arrayAppend(functions, nameKey)>
				<cfset arrayAppend(all, nameKey)>
			<cfelseif data.type IS "listing">
				<cfset arrayAppend(categories, nameKey)>
			</cfif>
			<cfif structKeyExists(data, "engines") AND structKeyExists(data.engines, "coldfusion") AND structKeyExists(data.engines.coldfusion, "minimum_version")>
				<cfif isNumeric(data.engines.coldfusion.minimum_version)>
					<cfset minimum_version = data.engines.coldfusion.minimum_version>
				<cfelseif reFind('^[0-9]{2,4}\.[0-9]\.[0-9]+$', data.engines.coldfusion.minimum_version)>
					<cfset minimum_version = listFirst(data.engines.coldfusion.minimum_version, ".")>
				<cfelse>
					<cfset minimum_version = ''>
				</cfif>
				<cfif structKeyExists(versions, val(minimum_version))>
					<cfset arrayAppend(versions[val(minimum_version)], data.name)>
				</cfif>
			</cfif>

			<cfif structKeyExists(data, "engines") AND structKeyExists(data.engines, "lucee") AND structKeyExists(data.engines.lucee, "minimum_version") AND isNumeric(data.engines.lucee.minimum_version)>

				<cfif structKeyExists(lucee_versions, val(data.engines.lucee.minimum_version))>
					<cfset arrayAppend(lucee_versions[val(data.engines.lucee.minimum_version)], data.name)>
				</cfif>

			</cfif>
		</cfif>
		<cfcatch>
			<cfoutput><h2>Error Parsing File: #filePath#</h2></cfoutput>
			<cfdump var="#cfcatch#">
		</cfcatch>
	</cftry>
</cfloop>
<cfloop array="#directoryList(guideDir, false, "array")#" index="filePath">
	<cfset nameKey = getFileFromPath(filePath)>
	<cfif listLast(nameKey,".") IS "md">
		<cftry>
			<cfset nameKey = lCase(replace(nameKey, ".md", ""))>
			<cfset arrayAppend(guides, nameKey)>
		<cfcatch>
			<cfoutput><h2>Error Parsing File: #filePath#</h2></cfoutput>
			<cfdump var="#cfcatch#">
		</cfcatch>
		</cftry>
	</cfif>
</cfloop>

<cfloop array="#structKeyArray(versions)#" index="v">
	<cfset vData = {"name"="ColdFusion #v# New Functions and Tags","type"="listing","description"="List of tags and functions added in ColdFusion #v#", "related"=versions[v]}>
	<cfset arraySort(vData.related, "text")>
	<cfset fileName = "cf#reReplace(v, "[^0-9]", "", "ALL")#">
	<cfset fileWrite("#dataDir#/#fileName#.json", prettyJSON(serializeJSON(vData), "utf-8"))>
	<p>Wrote <cfoutput>#fileName#</cfoutput>.json</p>

	<cfif !arrayContains(categories, fileName)>
		<cfset arrayAppend(categories, fileName)>
	</cfif>
</cfloop>

<cfloop array="#structKeyArray(lucee_versions)#" index="v">
	<cfset vData = {"name"="Lucee #v# New Functions and Tags","type"="listing","description"="List of tags and functions added in Lucee #v#", "related"=lucee_versions[v]}>
	<cfset arraySort(vData.related, "text")>
	<cfset fileName = "lucee#reReplace(v, "[^0-9]", "", "ALL")#">
	<cfset fileWrite("#dataDir#/#fileName#.json", prettyJSON(serializeJSON(vData), "utf-8"))>
	<p>Wrote <cfoutput>#fileName#</cfoutput>.json</p>

	<cfif !arrayContains(categories, fileName)>
		<cfset arrayAppend(categories, fileName)>
	</cfif>
</cfloop>

<cfset arraySort(tags, "text")>
<cfset arraySort(functions, "text")>
<cfset arraySort(guides, "text")>
<cfset arraySort(categories, "text")>
<cfset arraySort(all, "text")>

<cfset index = {"tags"=tags, "functions"=functions,"categories"=categories, "guides"=guides, "components"=["application-cfc"]}>
<cfset fileWrite(dataDir & "/index.json", prettyJSON(serializeJSON(index)), "utf-8")>
<p>Wrote index.json</p>

<cfset tagJSON = fileRead(dataDir & "/tags.json", "utf-8")>
<cfset tagData = deserializeJSON(tagJSON)>
<cfset tagData.related = tags>
<cfset fileWrite(dataDir & "/tags.json", prettyJSON(serializeJSON(tagData), "utf-8"))>
<p>Wrote tags.json</p>

<cfset fJSON = fileRead(dataDir & "/functions.json", "utf-8")>
<cfset fData = deserializeJSON(fJSON)>
<cfset fData.related = functions>
<cfset fileWrite(dataDir & "/functions.json", prettyJSON(serializeJSON(fData), "utf-8"))>
<p>Wrote functions.json</p>

<cfset aJSON = fileRead(dataDir & "/all.json", "utf-8")>
<cfset aData = deserializeJSON(aJSON)>
<cfset aData.related = functions>
<cfset fileWrite(dataDir & "/all.json", prettyJSON(serializeJSON(aData), "utf-8"))>
<p>Wrote all.json</p>

<cfset gJSON = fileRead(dataDir & "/guides.json", "utf-8")>
<cfset gData = deserializeJSON(gJSON)>
<cfset gData.related = guides>
<cfset fileWrite(dataDir & "/guides.json", prettyJSON(serializeJSON(gData), "utf-8"))>
<p>Wrote guides.json</p>

<cfset applicationStop()>
<p>Stopped application so it can reinit</p>

<cffunction name="prettyJSON" returntype="string" output="false">
	<cfargument name="json" type="string" required="true">

	<cfset arguments.json = replace(arguments.json, "],", "],#chr(10)##chr(9)#", "all")>
	<cfset arguments.json = replace(arguments.json, "{", "{#chr(10)##chr(9)#", "all")>
	<cfset arguments.json = replace(arguments.json, "}", "#chr(10)#}", "all")>

	<cfreturn arguments.json>
</cffunction>
