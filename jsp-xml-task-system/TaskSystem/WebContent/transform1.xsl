<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<table class="tablesorter" border="1">
			<thead> 
			<tr>
				<th>Name</th>
				<th>Due Date</th>
				<th>Priority</th>
				<th>Depends On</th>
				<th>Status</th>
			</tr>
			</thead>
			<tbody> 
				<xsl:apply-templates />
			</tbody>
			
			
		</table>
	</xsl:template>
	<xsl:template match="task">
		
		<tr>
			<td>
				<xsl:apply-templates select="@name" />
			</td>
			<td>
				<xsl:apply-templates select="@dueDate" />
			</td>
			<td>
				<xsl:apply-templates select="@priority" />
			</td>
			<td>
				<xsl:apply-templates select="@dependsOn" />
			</td>
			<td>
				<xsl:apply-templates select="@status" />
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>