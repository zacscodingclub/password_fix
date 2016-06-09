class PasswordFix::Process
  def initialize(path)
    @folder_path = path
    @all_files = get_all_filenames(@folder_path)
    process_all_files(@all_files)
  end

  def testing_path
    # something used for testing
    @folder_path << "/fixtures"
  end

  def get_all_filenames(path)
    Dir.glob(Dir.home + path + "/*.txt")
  end

  def process_all_files(files)
    files.each do |file|
      process_file(file)
    end
  end

  def process_file(file)
    good_lines = []

    File.open(file).each do |line|
      unless not_good_for_sql?(line)
        good_lines << line
      end
    end

    PasswordFix::Write.new(file, good_lines)

    # read the file line by line
    # determine if it's a good line
    # shove that line into an array
    # send that array to the writer
  end

  def not_good_for_sql?(line)
    # first condition: Can't be greater than 50
    # scrub!  http://ruby-doc.org/core-2.1.0/String.html#method-i-scrub-21
    # replaces invalid byte sequences (non UTF-8) with valid
    # regex: Can't single quotes, double quotes or any weird characters
    line.length > 50 || line.scrub!.match(/["'\P{ASCII}]/)
  end
end
# Process Text
# Gets all the .txt files in this folder
# good_lines = []
# for each file
#   for each line
#     if it has an ascii or '"`
#        skip the line
#     else
#        good_lines << line
#     end
#   end
# end
#
