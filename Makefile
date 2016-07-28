deploy:
	cp -r static/ outputs/static
	mkdir outputs/posts
	./genpage.sh posts
	mkdir outputs/pages
	./genpage.sh pages
	./genpage.sh index index.md outputs/index.html
clean:
	rm -rf outputs/*
