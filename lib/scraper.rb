require 'nokogiri'
require 'open-uri'
require "pry"
require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    Nokogiri::HTML(open("https://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses

    title = get_page.css("h2")

  end

  def make_courses
    #binding.pry
    course_title = get_courses
    sched = get_page.css("em")
    desc = get_page.css("p")

    for i in 3...desc.length
      Course.new.tap do |course|
      #  binding.pry
        course.title = course_title[i].text
        course.schedule = sched[i].text
        course.description = desc[i].text
      end
    end
  end

end
