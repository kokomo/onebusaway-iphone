#!/usr/bin/env ruby
# Copyright (c) 2012 Aaron Brethorst (http://www.cocoacontrols.com/)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Adapted from Jonathan Penn's AutomationExample project:
# https://github.com/jonathanpenn/AutomationExample

require 'rexml/document'
require 'tmpdir'
require 'json'
require 'awesome_print'

class Snapper
  include REXML
  attr_accessor :working_dir
  attr_accessor :build_dir

  def initialize
    self.working_dir = Dir.mktmpdir
    self.build_dir = '/tmp/snapper_build'
  end

  def build_app(log_results = true, clean = false)
    clean = clean ? ' clean ' : ''
    output = `xcodebuild -sdk iphonesimulator #{clean} CONFIGURATION_BUILD_DIR=#{build_dir}`
    puts output if log_results
  end

  def app_path
    @app_path ||= Dir[File.join(self.build_dir, "*.app")].first
  end

  def bundle_identifier
    # ???
  end

  def screenshot_path
    p = File.join(working_dir, 'Run 1', "#{bundle_identifier}.png")
    "\"#{p}\""
  end

  def results_plist_path
    "#{working_dir}/Run 1/Automation Results.plist"
  end

  def ui_data
    plist = Document.new(File.open(results_plist_path))
    json_ui = JSON.parse(plist.root.get_text('//plist/dict/array/dict[1]/string[2]').to_s)
  end

  def run_instruments(log_results = true)
    ui_args = [
      "-D #{self.working_dir}/trace",
      "-t UIAutomationTemplate.tracetemplate",
      app_path,
      "-e UIARESULTSPATH #{self.working_dir}",
      "-e UIASCRIPT snapper.js"
    ]

    output = `./unix_instruments #{ui_args.join(" ")}`
    puts output if log_results
  end

  def cleanup
    `rm -rf #{self.working_dir}`
  end

end

snapper = Snapper.new
snapper.build_app
snapper.run_instruments
ap snapper.ui_data

# `open #{snapper.screenshot_path}`
# `open #{snapper.results_plist_path}`

snapper.cleanup