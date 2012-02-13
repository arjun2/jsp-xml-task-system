<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<table border="1">
			<tr bgcolor="yellow">
				<th>Name</th>
				<th>Due Date</th>
				<th>Priority</th>
				<th>Depends On</th>
				<th>Status</th>
			</tr>
			<xsl:apply-templates />
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