include(`../m4/cf.m4')
VERSIONID(`linux for setup with uucp which uses domain names')dnl
OSTYPE(linux)
FEATURE(always_add_domain)dnl
MAILER(local)dnl
MAILER(smtp)dnl
MAILER(uucp)
define(`SMART_HOST', uucp-dom:otheruucphost)
