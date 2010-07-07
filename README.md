PageVisitTracker
================

This is a simple page view tracker for Rails. Features:

* resource-based, meaning it's designed to track views of models.
* tracks each unique visitor, based on a combination of the user agent and ip
* tracks the internal user ID, if there's a `current_user` method in the controller
* does not track visits from bots (based on user agents)


Example
=======

    script/plugin install git://github.com/leonid-shevtsov/page_visit_tracker.git

First, create the model
 
    script/generate page_view_migration
    rake db:migrate


Then, in your controller:

    class PostsController
      def show
        #...
        track_page_view(@post)
      end
    end

Then you can use it in your models like

    class Post
      has_many :page_views, :polymorphic => true, :dependent => :destroy
    end


TODO
====

* test
* maybe more convention over configuration


Copyright (c) 2010 Leonid Shevtsov, released under the MIT license
