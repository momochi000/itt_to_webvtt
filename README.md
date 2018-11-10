# .itt to .vtt converter script

This script takes an input .itt caption file, parses it, and outputs a properly
formatted .vtt.  I created this script out of a need for .vtt captioning on
html5 since Final Cut Pro only outputs either ITT or CEA-608 whereas HTML5
<track> tags only use .vtt.

# Prerequisites
Ruby 2.4.1 and bundler or Docker.  If using your own rvm or rb-env then bundle install and run the converter.rb file.

If using docker then build the image
`docker build -t <username>/<imagename> <path-to-Dockerfile>`

Then run the converter file
`docker run -it <username>/<imagename> ./converter.rb <infile> [outfile]`

currently input file and outputfile are not supported, working on that now.
To experiment inside the docker image:
`docker run -it --mount type=bind,source="$(pwd)",target=/myapp <username>/<iamgename> bash`
which will put you at a prompt inside the running container with your local working directory mounted inside.
