source='website/'
target='website/_site/'
remote_target=`cat _REMOTE`

blank:

clean:
	rm -f website/images/portraits/*.jpg
	rm -f website/_posts/*.markdown

prepare:
	@ruby website/_scripts/prepare.rb

build:
	@make clean
	@make prepare
	jekyll build -s $(source) -d $(target) --trace && find $(target)

server:
	@make clean
	@make prepare
	jekyll serve -s $(source) -d $(target) --watch --trace

publish:
	make build && rsync -avz --delete -e ssh $(target) $(remote_target)

