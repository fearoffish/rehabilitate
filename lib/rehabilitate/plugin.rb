module Rehabilitate
  class Plugin
    include ::PluginFactory
    
    def self::derivative_dirs
       ["plugins"]
    end
  
    def log(message)
      $LOGGER.info message
    end
  end
end