$LOAD_PATH.unshift(File.dirname(__FILE__))

module Xcodeproj
  require 'pathname'
  
  require 'xcodeproj/gem_version'
  require 'xcodeproj/user_interface'

  autoload :Command,          'xcodeproj/command'
  autoload :Config,           'xcodeproj/config'
  autoload :Constants,        'xcodeproj/constants'
  autoload :Differ,           'xcodeproj/differ'
  autoload :Helper,           'xcodeproj/helper'
  autoload :PlistHelper,      'xcodeproj/plist_helper'
  autoload :Project,          'xcodeproj/project'
  autoload :Workspace,        'xcodeproj/workspace'
  autoload :XCScheme,         'xcodeproj/scheme'
  autoload :XcodebuildHelper, 'xcodeproj/xcodebuild_helper'
end
