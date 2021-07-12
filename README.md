# WorkBoard

A "bulletin board" web interface for brainstorming your personal projects.


## What is this?

Usually when I'm working on a project I tend to write a whole bunch of Post-Its
and save important URLs in browser windows and some times save them to a text
file. This is messy and makes it very difficult to come back to a project after
a while. This project aims to replace all those Post-Its and random files.
It'll be equaly messy, only this time it's digital.


## How to set this up?

Firstly you'll need Classic ASP a capable [IIS 6.0+](https://www.iis.net/) server
setup and a [SQL Server 2005+](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
instance running.

After those prerequisites are met, import the database template file
`initialize_database.sql` into your SQL Server instance. After that's all done,
rename the `config.template.asp` (located in `wwwroot/_includes/`) to `config.asp`
and edit the database parameters to meet your configuration.


## Why Classic ASP?

I love playing around with retro technologies, and since this was a simple
project, that most likely I'm the only one that's going to use, I've decided
to have some fun and build it using [Classic ASP](https://en.wikipedia.org/wiki/Active_Server_Pages)
and [Macromedia Dreamweaver MX 2004](https://en.wikipedia.org/wiki/Adobe_Dreamweaver).


## License

This project is licensed under the **MIT License**.
