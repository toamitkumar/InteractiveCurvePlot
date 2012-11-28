# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

require "bundler"
Bundler.require :default

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'interactive_curve_plot'

  app.device_family = :ipad
  app.interface_orientations = [:landscape_left, :landscape_right]

  app.frameworks << "QuartzCore"

  # app.info_plist['NSMainNibFile'] = "MainWindow"

  app.pods do
    pod "CorePlot"
  end


  app.files.unshift(Dir.glob("./lib/**/*.rb"))

  app.vendor_project("vendor/Accordion", :static)
end
