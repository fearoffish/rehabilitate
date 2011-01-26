require 'rehabilitate/plugin'
require 'rehabilitate/plugins/splitter'

class Rehabilitate
  VERSION = "0.3.16"
  
  def self.backup(options)
    driver = Plugin::create( options.driver )
    driver.backup(options)
  end

  def self.restore(options)
    driver = Plugin::create( options.driver )
    driver.restore(options)
  end

  def self.compress(options)
    driver = Plugin::create( options.compressor )
    driver.compress(options)
  end

  def self.uncompress(options)
    driver = Plugin::create( options.compressor )
    driver.uncompress(options)
  end

  def self.upload(options)
    driver = Plugin::create( options.storage )
    driver.upload(options)
  end

  def self.download(options)
    driver = Plugin::create( options.storage )
    driver.download(options)
  end

  def self.list(options)
    driver = Plugin::create( options.storage )
    driver.list(options)
  end
end
