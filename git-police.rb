#!/usr/bin/env ruby
# Check whether git repositories in home directory have been pushed to master.

def get_commit_hash(label)
  hash = `git rev-parse #{label} 2> /dev/null`
  if $?.to_i == 0
    hash
  else
    nil
  end
end

class Repo
  def initialize(repo_path)
    @path = repo_path
    Dir.chdir "#{repo_path}/.."

    @commit_head = get_commit_hash "HEAD"
    @commit_master = get_commit_hash "master"
    @commit_origin_master = get_commit_hash "origin/master"

    # puts "commit_head: #{commit_head}"
    # puts "commit_master: #{commit_master}"
    # puts "commit_origin_master: #{commit_origin_master}"
  end

  def has_origin?
    not @commit_origin_master.nil?
  end

  def has_master?
    not @commit_master.nil?
  end

  def latest_pushed?
    @commit_master == @commit_origin_master and has_master?
  end

  def path
    @path
  end
end

# -------

repo_paths = (`find ~ -name .git`).split("\n")
repos = repo_paths.map { |path| Repo.new path }

repos_without_origin = repos.select { |r| not r.has_origin? }
unless repos_without_origin.empty? then
  puts "\nRepos without an origin:"
  repos_without_origin.each do |r|
    puts "    #{r.path}"
  end
end

repos_out_of_sync = repos.select { |r| r.has_origin? and not r.latest_pushed? }
unless repos_out_of_sync.empty? then
  puts "\nRepos out of sync with their origins:"
  repos_out_of_sync.each do |r|
    puts "    #{r.path}"
  end
end

repos_without_master = repos.select { |r| not r.has_master? }
unless repos_without_master.empty? then
  puts "\nRepos without a master branch:"
  repos_without_master.each do |r|
    puts "    #{r.path}"
  end
end
