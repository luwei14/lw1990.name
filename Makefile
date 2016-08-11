deploy:
	mkdir -p outputs/
	cp -r static/ outputs/static
	mkdir -p outputs/posts
	./genpage.sh posts
	mkdir -p outputs/pages
	./genpage.sh pages
	./genpage.sh index index.md outputs/index.html
clean:
	rm -rf outputs/*
