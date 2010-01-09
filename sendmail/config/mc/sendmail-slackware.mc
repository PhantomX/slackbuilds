dnl# This is the default sendmail .mc file for Slackware.  To generate
dnl# the sendmail.cf file from this (perhaps after making some changes),
dnl# use the m4 files in /usr/share/sendmail/cf like this:
dnl#
dnl# cp sendmail-slackware.mc /usr/share/sendmail/cf/config.mc
dnl# cd /usr/share/sendmail/cf
dnl# sh Build config.cf
dnl#
dnl# You may then install the resulting .cf file:
dnl# cp config.cf /etc/mail/sendmail.cf
dnl#
include(`../m4/cf.m4')
VERSIONID(`default setup for Slackware Linux')dnl
OSTYPE(`linux')dnl
dnl# These settings help protect against people verifying email addresses
dnl# at your site in order to send you email that you probably don't want:
define(`confPRIVACY_FLAGS', `authwarnings,novrfy,noexpn,restrictqrun')dnl
dnl# Uncomment the line below to send outgoing mail through an external server:
dnl define(`SMART_HOST',`mailserver.example.com')
dnl# No timeout for ident:
define(`confTO_IDENT', `0')dnl
dnl# Enable the line below to use smrsh to restrict what sendmail can run:
dnl FEATURE(`smrsh',`/usr/sbin/smrsh')dnl
dnl# See the README in /usr/share/sendmail/cf for a ton of information on
dnl# how these options work:
FEATURE(`use_cw_file')dnl
FEATURE(`use_ct_file')dnl
FEATURE(`mailertable',`hash -o /etc/mail/mailertable.db')dnl
FEATURE(`virtusertable',`hash -o /etc/mail/virtusertable.db')dnl
FEATURE(`access_db', `hash -T<TMPF> /etc/mail/access')dnl
FEATURE(`blacklist_recipients')dnl
FEATURE(`local_procmail',`',`procmail -t -Y -a $h -d $u')dnl
FEATURE(`always_add_domain')dnl
FEATURE(`redirect')dnl
dnl# Turn this feature on if you don't always have DNS, or enjoy junk mail:
dnl FEATURE(`accept_unresolvable_domains')dnl
EXPOSED_USER(`root')dnl
dnl# Also accept mail for localhost.localdomain:
LOCAL_DOMAIN(`localhost.localdomain')dnl
MAILER(local)dnl
MAILER(smtp)dnl
MAILER(procmail)dnl
