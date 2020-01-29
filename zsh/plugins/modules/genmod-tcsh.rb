#!/usr/bin/env ruby

require 'open3'
require 'tempfile'

$script = File.realpath($0)
$script_dir = File.dirname($script)

# Get source file
source_file = ARGV[0]
unless File.file? source_file
	raise "source file #{source_file} doesn't exist"
end

def source_tcsh(file)
	puts "Sourcing #{file}..."
	command = "#{$script_dir}/source.tcsh #{file}"
	env_dir, stderr, status = Open3.capture3(command)
	env_dir.chomp!
	unless status.exitstatus == 0 then
		puts stderr
		raise "failed to source #{file}"
	end
	puts "Environment dumped to: #{env_dir}"
	return env_dir
end

# Usage: read_env(`env`)
# Return: array of modules
def module_list(env)
	env.scan(/^LOADEDMODULES=(.*)$/).flatten.first.split(':').reject(&:empty?)
end

# Usage: read_env(`env`)
# Return: hash of env
def read_env(env)
	hash = Hash.new([])
	env.scan(/(^\w+)=(.*)$/).each do |line|
		key, value = line
		hash[key] = value.split(':')
	end
	return hash
end

# Usage: diff_env(pre_hash, post_hash)
# Return: hash of env
def diff_env(pre, post)
	diff = Hash.new([])
	(pre.keys + post.keys).sort.each do |key|
		new_values = post[key] - pre[key]
		diff[key] = new_values unless new_values.empty?
	end
	return diff
end

env_dir = source_tcsh(source_file)
puts "Parsing modules..."
pre_modules = module_list(File.read("#{env_dir}/pre.env"))
post_modules = module_list(File.read("#{env_dir}/post.env"))
post_env = read_env(File.read("#{env_dir}/post.env"))
new_modules = post_modules - pre_modules

puts "Generating new modulefile with only modules..."
tempfile = Tempfile.new('modules')
tempfile.write("module load \\\n  #{new_modules.join(" \\\n  ")}\n")
tempfile.close

env_dir = source_tcsh(tempfile.path)
puts "Parsing environment..."
pre_env = read_env(File.read("#{env_dir}/post.env"))
new_env = diff_env(pre_env, post_env)

puts "Generating new modulefile..."
modulefile = "#{source_file}.modulefile"
modulefile_header = <<ENDHEADER
#%Module
# vi: filetype=tcl
# $> module load $PWD/#{modulefile}
set ModulesCurrentModulefile [info script]
set ModulesCurrentModulepath [file dirname $ModulesCurrentModulefile]
ENDHEADER

File.open(modulefile, 'w') do |file|
	file.write(modulefile_header)
	file.write("module load \\\n  #{new_modules.join(" \\\n  ")}\n")
	new_env.each do |key, value|
		next if key =~ /(LIC(ENSE)?_FILE|_modshare|^_LMFILES_)$/
		if value.size == 1
			file.puts "setenv #{key} #{value.first}"
		else
			value.each { |sub_value| file.puts "prepend-path #{key} #{sub_value}" }
		end
	end
end
puts "Generated modulefile '#{modulefile}'"

