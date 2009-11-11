$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'active_record'
require 'better_delegation'
require 'spec'
require 'spec/autorun'

spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(spec_dir + "/debug.log")

databases = YAML::load(IO.read(spec_dir + "/db/database.yml"))
ActiveRecord::Base.establish_connection(databases[ENV["DB"] || "sqlite3"])
load(File.join(spec_dir, "db", "schema.rb"))
