Name:		kdelibs-extramimetypes
Version:	5.2
Release: 	1%{?dist}
Summary:	Extra mimetypes for KDE.
License:	GPL
Group:		System Environment/Libraries
URL:		http://phantomx.dnsdojo.org/
Source:		http://phantomx.dnsdojo.org/down/%{name}-%{version}.tar.bz2
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Requires:	kdelibs >= 3.5, desktop-file-utils >= 0.10
BuildArch:	noarch

%description
This package contains extra unusual mimetypes for KDE and integration
with some applications.

%prep
%setup -q

%build

%install
%{__rm} -rf %{buildroot}
%{__make} install DESTDIR=%{buildroot}

%{__rm} -f %{buildroot}%{_datadir}/mimelnk/application/x-la.desktop

%clean
%{__rm} -rf %{buildroot}

%files
%defattr(-,root,root,-)
%doc %{_datadir}/doc/%{name}-%{version}
%{_datadir}/applnk/.hidden/*.desktop
%{_datadir}/mimelnk/application/*.desktop
%{_datadir}/mimelnk/audio/*.desktop
%{_datadir}/mimelnk/text/*.desktop

%changelog
* Sun Sep  9 21:09:15 BRT 2007
- Updated to 5.0.

* Fri Mar  2 2007 Phantom X - 4.1-1
- Updated to 4.1.

* Thu Jul 13 2006 Phantom X - 2.1-1
- Updated to 2.1.

* Wed Jun 21 2006 Phantom X - 2.0-1
- Updated to 2.0.
- %%post and %%postun not needed.

* Mon Jun 19 2006 Phantom X - 1.4-1.1
- Fix kwrite %%post script.

* Fri Jun 16 2006 Phantom X - 1.4-1
- 1.4.

* Tue May 11 2006 Phantom X - 1.3-2
- FC5.

* Mon Apr 24 2006 Phantom X - 1.3-1
- Upgraded to 1.3.
- Updated spec.

* Tue Mar 01 2005 Phantom X - 1.2-2
- Removed audio/x-mpc, that is included in kde >= 3.4.

* Tue Mar 01 2005 Phantom X - 1.2-1
- Upgraded to 1.2.

* Tue Mar 01 2005 Phantom X - 1.1-1
- Initial RPM release.
