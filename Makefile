
     STAMP := $(shell date '+%Y%m%d.%H%M%S')
      DIST := project-euler.$(STAMP)
   DISTDIR := Dist/$(DIST)

usage:
	@echo "usage: [clean]"

clean:
	rm -rf Dist/
	rm -f *.tar.gz

dist:
	mkdir -p $(DISTDIR)
	cp -a Makefile bin done lib pe* $(DISTDIR)
	tar czf $(DIST).tar.gz $(DISTDIR)
	rm -rf $(DISTDIR)

# to get the latest: git reset --hard

