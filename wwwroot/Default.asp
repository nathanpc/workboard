<!-- #include virtual="/_includes/base.asp" -->
<!-- #include virtual="/_includes/templates/header.asp" -->

<p>This is a "bulletin board" web interface for brainstorming my personal
projects. I know it looks extremely old, but that's exactly the idea as it was
inspired by the amazing <a href="http://wiki.c2.com/">WikiWikiWeb</a>. I want
to be able to open this in any browser that you can image and still be able to
read its contents and post things to it.</p>

<p>In order to keep things organized and prevent this from becoming the digital
equivalent to my workbench surface filled with Post-Its (which is exactly what
this is supposed to replace), I've developed the concept of "virtual workspaces",
which organizes posts into their respective projects or categories. Here's a
list of the current workspaces that I'm working on:</p>

<ul>
	<% Dim strName %>
	<% For Each strName In GetWorkspaces() %>
		<li>
			<a href="/Workspace.asp?name=<%= Server.URLEncode(strName) %>">
				<%= strName %>
			</a>
		</li>
	<% Next %>
	<li>
		<form method="post" action="/Workspace.asp" id="newws" name="newws">
			<input type="hidden" name="action" value="newws" />
			<label for="wsname">New Workspace:</label>
			<input type="text" id="wsname" name="wsname" />
			<input type="submit" value="Submit" />
		</form>
	</li>
</ul>

<p>If you would like to know more about this project please visit its
<a href="https://github.com/nathanpc/workboard">GitHub page</a>. If you're
actually considering using this please let me know, because I would be very
interested in knowing more about you.</p>

<p>I love playing around with retro technologies, and since this was a simple
project, that most likely I'm the only one that's going to use, I've decided
to have some fun and build it using
<a href="http://en.wikipedia.org/wiki/Active_Server_Pages">Classic ASP</a>
and <a href="https://en.wikipedia.org/wiki/Adobe_Dreamweaver">Macromedia
Dreamweaver MX 2004</a>.</p>

<!-- #include virtual="/_includes/templates/footer.asp" -->