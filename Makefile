
  STAMP := $(shell date '+%Y%m%d.%H%M%S')
   DIST := project-euler.$(STAMP)

usage:
	@echo "usage: [clean]"

clean:
	rm -rf project-euler.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].*

dist:
	mkdir -p $(DIST)
	cp -a Makefile bin done lib pe* $(DIST)
	tar czf $(DIST).tar.gz $(DIST)
	rm -rf $(DIST)

