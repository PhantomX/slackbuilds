# To rebuild your sendmail configuration databases, run "make"
# in this directory after making any changes.

all: access.db aliases.db domaintable.db mailertable.db virtusertable.db

access.db: access
	@makemap hash access < access

aliases.db: aliases
	@newaliases

domaintable.db: domaintable
	@makemap hash domaintable < domaintable

mailertable.db: mailertable
	@makemap hash mailertable < mailertable

virtusertable.db: virtusertable
	@makemap hash virtusertable < virtusertable

