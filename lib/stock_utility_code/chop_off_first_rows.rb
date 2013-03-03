class ChopOffFirstRows

  def initialize
    Dir.chdir(File.join(Rails.root, 'lib', 'assets')) {
     @files = Dir.glob("*")  
    }
  end

  def go
    @files.each do |filename|
      File.open(File.join(Rails.root, 'lib', 'cleaned', filename), 'w+') do |outf|
        File.open(File.join(Rails.root, 'lib', 'assets', filename)) do |inf|
          inf.each_line.with_index do |line, i|
            outf.write(line) unless i == 0
          end
        end
      end
    end
  end


end
