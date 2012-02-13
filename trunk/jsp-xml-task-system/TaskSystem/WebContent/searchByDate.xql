<tasks>
{
for $t in doc("testuser1_tasks.xml")//task[@dueDate=""]
let $d := doc("testuser1_tasks.xml")//task[@ID=$t/@dependsOn]/@name
return <task ID='{$t/@ID}' 
name='{$t/@name}'  dueDate='{$t/@dueDate}' priority='{$t/@priority}' 
dependsOn='{$d}' 
status='{
if($t/@completed="false")
then "Complete"
else
"Incomplete"
}'>
</task>
}
</tasks>