#Quantified Life

This site is a personal website I've made to track various aspects of my life.

The core feature I'm currently using it is just as a way to write down my
thoughts. There are two main data models, the Day, and the Post. The day model
is the foundation for most things on the platform. Every object has a 'date'
listed, which will reference a specific day. This is used in the main timeline
(Still in the works) to display activities for every day.
The post model is used for random writing. I will occasionally write 'blog
post' style posts, although nothing public yet. I also frequently use it for
just some 'stream of conciousness' style posts, or random 'notes to self'.

There are also many other models that are being worked on. I'm working on
pulling in data from various services I use to aggregate all of my data in one
place. I currently have it pulling from the Github Events API to display all
of my events for each day. I also have it integrated with Filepicker, so I can
upload my pictures, and grab the EXIF data from them to assign them to a
particular day. I'm also working on Dropbox integration, so it automatically
uploads photos from my "Dropbox/Camera Uploads" folder. This avoids the need
for me to write an android app for auto-uploading.

This site is still in very rapid development, and I am constantly adding new
features. It is also very personalized for me, although I may eventually build
it out for others to use.
