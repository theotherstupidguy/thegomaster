===========
TheGoMaster
===========
A tribute webapp for the "Invincible" Honinbo Shusaku Igo player. 

TODO
====
- Fix the "Go Tips" On/Off to automatically show and fade Go Terms and their meanings 
- Choose a Modal to contain the editinplace "game story or comments"
- Create a footer
- Create a header
- Create a login mechanism 
- Create a User model and associate the other models relationship to it
- Seek if the sgf contains a commentary, we could search for the Go terms of the current move and display it's defintion as a Go Tip
- add a game through url or upload
- addtip section should include a metatag "haiku","qoute","Go term",etc.
- Add ajax paging for /games and /studies
- Go Graph
- a job in which to be able to compare if two sgf files(boolean sum of moves) are of the same game? as if a webcrawler would fetch games of the internet automatically
- signup for teachers or go schools
- Chat app based on http://candy-chat.github.io/candy/#setup
http://www.getvines.org/services/web/

Applications
============
- go students and teachers can use the app as an online classroom and share their commentaries\tips online 
- the application will look cool on a projector or a classroom tvscreen in a go school 

To contribute some code:

Fork this.
git clone git@github.com:YOUR_USERNAME/thegomaster.git
git remote add upstream git://github.com/theotherstupidguy/thegomaster.git
git fetch upstream
git checkout develop
Decide on the feature you wish to add.
Give it a snazzy name, such as kitchen_sink.
git checkout -b kitchen_sink
Install Bundler.
gem install bundler -r --no-ri --no-rdoc
Install gems from Gemfile.
bundle install --binstubs --path vendor
Any further updates needed, just run bundle install, it'll remember the rest.
Write some specs.
Write some code. (Yes, I believe that is the correct order, and you'll never find me doing any different;)
Write some documentation using Yard comments - see http://rubydoc.info/docs/yard/file/docs/GettingStarted.md
Use real English (i.e. full stops and commas, no l33t or LOLZ). I'll accept American English even though it's ugly. Don't be surprised if I 'correct' it.
Code without comments won't get in, I don't have the time to work out what you've done if you're not prepared to spend some time telling me (and everyone else).
Run reek PATH_TO_FILE_WITH_YOUR_CHANGES and see if it gives you any good advice. You don't have to do what it says, just consider it.
Run specs to make sure you've not broken anything. If it doesn't pass all the specs it doesn't get in.
Have a look at coverage/index.htm and see if all your code was checked. We're trying for 100% code coverage.
If your commit changes the way things work or adds a feature then add an example in the examples dir. The specs run off the examples to make sure the library works with a real project while keeping the examples up to date, so make sure you add something there if needs be.
Run bin/rake docs to generate documentation.
Open up docs/index.html and check your documentation has been added and is clear.
Add a short summary of your changes to the top of CHANGES file. Add your name and a link to your bio/website if you like too. Don't add a version number, I'll handle that.
Send me a pull request.
Don't merge into the develop branch!
Don't merge into the master branch!
see http://nvie.com/posts/a-successful-git-branching-model/ for more on how this is supposed to work.
Wait for worldwide fame.
Shrug and get on with you life when it doesn't arrive, but know you helped quite a few people in their life, even in a small way - 1000 raindrops will fill a bucket!

