require 'formula'

class Redis < Formula
  homepage 'http://redis.io/'
  url 'http://download.redis.io/releases/redis-2.8.6.tar.gz'
  sha1 '8680046580c75987961241f2e1e417c242b91a49'

  version '2.8.6-boxen1'

  fails_with :llvm do
    build 2334
    cause 'Fails with "reference out of range from _linenoise"'
  end

  def install
    # Architecture isn't detected correctly on 32bit Snow Leopard without help
    ENV["OBJARCH"] = MacOS.prefer_64_bit? ? "-arch x86_64" : "-arch i386"

    # Head and stable have different code layouts
    src = (buildpath/'src/Makefile').exist? ? buildpath/'src' : buildpath
    system "make", "-C", src, "CC=#{ENV.cc}"

    %w[benchmark cli server check-dump check-aof].each { |p| bin.install src/"redis-#{p}" }
    %w[run db/redis log].each { |p| (var+p).mkpath }

    # Fix up default conf file to match our paths
    inreplace "redis.conf" do |s|
      s.gsub! "/var/run/redis.pid", "#{var}/run/redis.pid"
      s.gsub! "dir ./", "dir #{var}/db/redis/"
      s.gsub! "\# bind 127.0.0.1", "bind 127.0.0.1"
    end

    # Fix redis upgrade from 2.4 to 2.6.
    if File.exists?(etc/'redis.conf') && !File.readlines(etc/'redis.conf').grep(/^vm-enabled/).empty?
      mv etc/'redis.conf', etc/'redis.conf.old'
      ohai "Your redis.conf will not work with 2.6; moved it to redis.conf.old"
    end

    etc.install 'redis.conf' unless (etc/'redis.conf').exist?
  end
end
