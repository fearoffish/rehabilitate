module Backup
  class Lister
    def self.list(options)
      puts "Configuring fog..."
      fog_config = YAML.load(File.read(File.expand_path("~/.fog")))
      s3 = Fog::AWS::S3.new(
          :aws_access_key_id     => fog_config[:default][:aws_access_key_id],
          :aws_secret_access_key => fog_config[:default][:aws_secret_access_key]
      )
      s3.directories.get("ey-mongodb-backups").files.each do |file|
        puts "#{file.key} => #{file.size/1024/1024}Mb"
      end
    end
  end
end