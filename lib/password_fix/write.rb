class PasswordFix::Write
  def initialize(file, lines)
    make_paths(file)
    @lines = lines

    call
  end

  def call
    out_file = File.new(@base_path + "/" + @filename, "w")

    @lines.each do |line|
      out_file.puts(line)
    end

    out_file.close
  end

  def make_paths(filename)
    @filename = filename.split("/").last.prepend("fixed_")
    @base_path = filename.split("/")[0..-2].join("/")
  end
end
#
# #
# # Write New Text
#
# create new file
# for each good_lines
#   add to new file text
#
