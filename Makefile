DEPLOY_DIR = deploy
PAGES_DIR = pages
WRITINGS_DIR = writings
STATIC_DIR = static
HOMEPAGE = home.md
MKDIR_P = mkdir -p
CP_R = cp -r

.PHONY: deploy

deploy: output static pages home
	cd deploy &&  git add . && git commit -m "update site:`date`" && git push origin master

output:
	$(MKDIR_P) $(DEPLOY_DIR)/$(PAGES_DIR)
	$(MKDIR_P) $(DEPLOY_DIR)/$(WRITINGS_DIR)

home: output
	./pagegen.sh genpage $(HOMEPAGE) $(DEPLOY_DIR)/index.html

pages: output
	./pagegen.sh pages $(PAGES_DIR) $(DEPLOY_DIR)
	./pagegen.sh pages $(WRITINGS_DIR) $(DEPLOY_DIR)

static: output
	$(CP_R) $(STATIC_DIR) $(DEPLOY_DIR)
