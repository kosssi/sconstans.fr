deploy:
	cd _site; git init
	cd _site; git remote add origin git@github.com:sconstans/sconstans.github.io.git
	cd _site; touch .nojekyll
	cd _site; git add .
	cd _site; git ci -m "MEP"
	cd _site; git push origin master:master -f
	rm _site/.git -rf
