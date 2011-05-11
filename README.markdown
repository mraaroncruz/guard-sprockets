## What?
Packages your javascript files together when you save your source file.

## Use
if you haven't already `gem install guard`  
then `gem install guard-sprockets`  
in your project's directory root  
`guard init`  
`guard init sprockets`  
which will add this to your Guardfile  
    guard 'sprockets', :destination => "public/javascripts" do
      watch (%r{app/assets/javascripts/application.js})
    end
change the destination to your public facing javascript directory and the `watch` regex to point at where your source javascript file is.  
The base configuration would work for a rails 3 project with a directory structure like  
    |-- app
    |   |-- controllers
    |   |-- assets
    |   |   |-- sass
    |   |   `-- javascripts
    |   |       `-- application.js # your source javascript file 
    |   |-- helpers
    |   |-- mailers
    |   |-- models
    |   `-- views
    |       `-- layouts
    |-- config
    |   |-- environments
    |   |-- initializers
    |   `-- locales
    |-- db
    |-- doc
    |-- lib
    |   `-- tasks
    ... etc.

## TODO
tests