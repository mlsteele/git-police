#!/usr/bin/env ruby
# Check whether git repositories in home directory have been pushed to master.

repos = (`find ~ -name .git`).split("\n")

def get_commit_hash(label)
  hash = `git rev-parse #{label} 2> /dev/null`
  if $?.to_i == 0
    hash
  else
    nil
  end
end

repos.each do |repo|
  Dir.chdir "#{repo}/.."
  puts "\nRepo: #{`pwd`}"
  commit_head = get_commit_hash "HEAD"
  commit_master = get_commit_hash "master"
  commit_origin_master = get_commit_hash "origin/master"
  # puts "commit_head: #{commit_head}"
  # puts "commit_master: #{commit_master}"
  # puts "commit_origin_master: #{commit_origin_master}"

  if commit_origin_master.nil? then
    puts "Warning: Repo has no origin/master."
  end

  if commit_master.nil? then
    puts "Warning: Repo has no master branch."
  end

  if commit_master != commit_origin_master and not commit_origin_master.nil? then
    puts "Warning: Repo is not in sync with origin."
  end
end
