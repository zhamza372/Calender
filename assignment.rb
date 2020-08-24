require 'date'

class Event

  def initialize(title, description, date)
    @title = title
    @description = description
    @date = date
  end

  def to_s
    puts "Title=" + @title + ", " + "Desciption=" + @description + ", " + "Date=" + @date.to_s
  end

  attr_accessor :title, :description,:date

end

class EventOperations
  
  def display_menu
    puts "Press 1 to add event"
    puts "Press 2 to update event"
    puts "Press 3 to delete event"
    puts "Press 4 to print the month view"
    puts "Press 5 to print details of events in specific date"
    puts "Press 6 to print the details of all events of specific month"
    puts "Press 7 to exit"
  end

  def take_input
    begin
      puts "Enter date in (yyyy-mm-dd) format"
      date = Date.parse(gets.chomp)
      puts "Enter Title of your event"
      title = gets.chomp
      puts "Enter Description of your event"
      description = gets.chomp
    rescue
      puts "Please enter valid date"
      retry
    end
    return Event.new(title, description, date)
  end

  def add_event(hash, event)
    puts "Add an event"
    if not hash.key?(event.date)
      hash[event.date] = [event]
      puts "Event added successfully"
      return true
    else
      events_array = hash[event.date]
      events_array.each do |events|
        if events.title == event.title
          puts "Event already exist with this title"
          return false
        end     
      end
      events_array.push(event)
      hash[event.date] = events_array
      puts "Event added successfully"
      return true
    end
  end

  def input_for_event_to_update
    begin
      puts "Enter date in (yyyy-mm-dd) format that you want to update"
      date = Date.parse(gets.chomp)
      puts "Enter title that you want to update"
      name = gets.chomp
    rescue
      puts "Please enter valid date"
      retry
    end
    return Event.new(name, "", date)
  end
  
  def input_for_new_event
    begin
      puts "Enter new date in (yyyy-mm-dd) format"
      new_date = Date.parse(gets.chomp)
      puts "Enter new title"
      new_title = gets.chomp
      puts "Enter new description"
      new_description = gets.chomp
    rescue
      puts "Please enter valid date"
      retry
    end
    return Event.new(new_title, new_description , new_date)
  end
  
  def update_event(hash, old_event, new_event)
    puts "Update an event"
    if hash.key?(old_event.date)
      events_array = hash[old_event.date]
      events_array.each do |event|
        if event.title == old_event.title
          events_array.delete(event)
          event = new_event
          if not hash.key?(new_event.date)
            hash[new_event.date] = [new_event]
          else
            newArray = hash[new_event.date]
            newArray.push(new_event)
            hash[new_event.date] = newArray
          end
          puts "Event updated successfully"
          return true
        end
      end
    else
      puts "This event does not exist"
      return false
    end
  end

  def input_to_delete_event
    begin
      puts "Enter date in (yyyy-mm-dd) format"
      date = Date.parse(gets.chomp)
      puts "Enter title that you want to delete"
      name = gets.chomp
    rescue
      puts "Please enter valid date"
      retry
    end
    return Event.new(name, "", date)
  end
  
  def delete_event(hash, event)
    puts "Delete an event"
    if not hash.key?(event.date)
      puts "No Event is registered on this date"
      return false
    else
      events_array = hash[event.date]
      events_array.each do |events|
        if events.title == event.title
          events_array.delete(event)
          puts "Event Removed successfully"
          return true   
        end
      end
    end
  end

  def month_view(hash)
    puts "Print month view"
    begin
      puts "Enter date in (yyyy-mm-dd) format"
      date = Date.parse(gets.chomp)
    rescue
      puts "Please enter valid date"
      retry
    end
    puts "\nMonth View ".rjust(50) + date.to_s
    for days in 1..Date.new(date.year, date.month, -1).day
      monthDates = date.year.to_s.chomp + "-" + date.month.to_s.chomp + "-" + days.to_s.chomp
      if hash.key?(Date.parse(monthDates))
        print days.to_s.ljust(3) , hash[Date.parse(monthDates)].length() ,"     "
      else
        print days.to_s.ljust(3) , "0     "
      end
      if days%7 == 0 or days == Date.new(date.year, date.month, -1).day
        puts "\n\n"
      end
    end
  end

  def specific_date_events(hash)
    puts "Details of events in specific date"
    begin
      puts "Enter date in (yyyy-mm-dd) format"
      date = Date.parse(gets.chomp)
    rescue
      puts "Please enter valid date"
      retry
    end
    puts "\nDetail of Events ".rjust(50) + date.to_s + "\n\n"
    if hash.key?(date)
      events_array = hash[date]
      events_array.each do |event|
        print event.to_s
      end
    else
      puts "No event is registered on this date"
      return false
    end
  end

  def month_event_details(hash)
    puts "Print Details of events in month"
    begin
      puts "Enter date in (yyyy-mm-dd) format"
      date = Date.parse(gets.chomp)
    rescue
      puts "Please enter valid date"
      retry
    end
    puts "\nDetails of events in month ".rjust(50) + date.to_s + "\n\n"
    for days in 1..Date.new(date.year, date.month, -1).day
      monthDates = date.year.to_s.chomp + "-" + date.month.to_s.chomp + "-" + days.to_s.chomp
      if hash.key?(Date.parse(monthDates))
        if hash[Date.parse(monthDates)].length() > 1
          events_array = hash[Date.parse(monthDates)]
          events_array.each do |event|
            puts event.to_s
          end
        else
          puts hash[Date.parse(monthDates)].first.to_s
        end
      end
    end
  end
end

class Driver
  def run
    event_operations = EventOperations.new
    hash = Hash.new
    puts "****** Welcome to calender *******"
    event_operations.display_menu
    while a = gets
      a = a.chomp
      if a == "7"
        puts "Calender is closed successfully"
        return
      elsif a == "1"
        event = event_operations.take_input
        event_operations.add_event(hash, event)  
      elsif a == "2"
        old_event = event_operations.input_for_event_to_update()
        new_event = event_operations.input_for_new_event()
        event_operations.update_event(hash, old_event, new_event) 
      elsif a == "3"
        event = event_operations.input_to_delete_event
        event_operations.delete_event(hash, event)
      elsif a == "4"
        event_operations.month_view(hash)
      elsif a == "5"
        event_operations.specific_date_events(hash)
      elsif a == "6"
        event_operations.month_event_details(hash) 
      elsif a == "8"
        hash.each do |key, value|
          puts value
        end
      else
        puts "Please select valid option"
      end

      event_operations.display_menu
    end
  end
end

Driver.new.run
