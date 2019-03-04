<#import "frames/main.ftl" as main>
<#import "frames/login.ftl" as l>

<@main.page>
Login page
<@l.login "/login" />
<a href="/registration">Add new user</a>
</@main.page>