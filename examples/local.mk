# Copyright (C) 2005, 2008-2012 Free Software Foundation, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

dist_noinst_SCRIPTS = examples/extexi examples/test
TEST_LOG_COMPILER = $(top_srcdir)/examples/test

## ------------ ##
## Extracting.  ##
## ------------ ##

doc = $(top_srcdir)/doc/bison.texi
extexi = $(top_srcdir)/examples/extexi
extract = VERSION="$(VERSION)" $(PERL) -f $(extexi) $(doc) --
extracted =
CLEANFILES += $(extracted) examples/extracted.stamp
examples/extracted.stamp: $(doc) $(extexi)
	$(AM_V_GEN)rm -f $@ $@.tmp
	$(AM_V_at)touch $@.tmp
	$(AM_V_at)$(extract) $(extracted)
	$(AM_V_at)mv $@.tmp $@

$(extracted): examples/extracted.stamp
	@test -f $@ || rm -f examples/extracted.stamp
	@test -f $@ || $(MAKE) $(AM_MAKEFLAGS) examples/extracted.stamp

include examples/calc++/local.mk
include examples/mfcalc/local.mk
include examples/rpcalc/local.mk
