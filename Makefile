deploy:
	mkdir -p outputs/
	cp -r static/ outputs/
	mkdir -p outputs/posts
	./genpage.sh posts
	mkdir -p outputs/pages
	./genpage.sh pages
	./genpage.sh index index.md outputs/index.html
	sudo cp -r outputs/* /var/www/
clean:
	rm -rf outputs/*
