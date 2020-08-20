require 'date'

class Event
	def initialize(title,description,date)
		@title=title
		@description=description
		@date=date
	end
	def to_s
		puts "Title="+@title+", " +"Desciption="+@description+", " +"Date="+@date.to_s
	end
	attr_accessor :title, :description,:date
end

class Menu
	def displayMenu
		puts "Press 1 to add event"
		puts "Press 2 to update event"
		puts "Press 3 to delete event"
		puts "Press 4 to print the month view"
		puts "Press 5 to print details of events in specific date"
		puts "Press 6 to print the details of all events of specific month"
		puts "Press 7 to exit"
	end
end

def addEvent(hash)
	puts "Add an event"
	begin
		puts "Enter date in (yyyy-mm-dd) format"
		date=Date.parse(gets.chomp)
		puts "Enter Title of your event"
		title=gets.chomp
		puts "Enter Description of your event"
		description=gets.chomp
	rescue
		puts "Please enter valid date"
		retry
	end
	event=Event.new(title,description,date)
	exist=0

	if not hash.key?(date)
		hash[date]=[event]
		puts "Event added successfully"
	else
		eventsArray=hash[date]
		eventsArray.each do |i|

			if i.title==title
				puts "Event already exist with this title"
				exist=1
			end			
		end
		if exist==0
			eventsArray.push(event)
			hash[date]=eventsArray
			puts "Event added successfully"
		end
	end
end


def updateEvent(hash)
	puts "Update an event"

	begin
		puts "Enter date in (yyyy-mm-dd) format that you want to update"
		date=Date.parse(gets.chomp)
		puts "Enter title that you want to update"
		name=gets.chomp
	rescue
		puts "Please enter valid date"
		retry
	end
	if hash.key?(date)
		eventsArray=hash[date]
		eventsArray.each do |i|
		if i.title==name
			begin
  			puts "Enter new date in (yyyy-mm-dd) format"
				newdate=Date.parse(gets.chomp)
				puts "Enter new title"
				newtitle=gets.chomp
				puts "Enter new description"
				newdescription=gets.chomp
			rescue
				puts "Please enter valid date"
  			retry
			end
			eventsArray.delete(i)
			event=Event.new(newtitle,newdescription,newdate)

			if not hash.key?(newdate)
				hash[newdate]=[event]
			else
				newArray=hash[newdate]
				newArray.push(event)
				hash[newdate]=newArray
			end
			puts "Event updated successfully"		
		end
	end
	else
		puts "This event does not exist"
	end
end

def deleteEvent(hash)
	puts "Delete an event"
	begin
		puts "Enter date in (yyyy-mm-dd) format"
		date=Date.parse(gets.chomp)
		puts "Enter title"
		name=gets.chomp
		
	rescue
		puts "Please enter valid date"
		retry
	end
	if not hash.key?(date)
		puts "No Event is registered on this date"
	else
		eventsArray=hash[date]
		eventsArray.each do |i|
			if i.title==name
				eventsArray.delete(i)
				puts "Event Removed successfully"		
			end
		end
	end
end


def monthView(hash)
	puts "Print month view"
	begin
		puts "Enter date in (yyyy-mm-dd) format"
		date=Date.parse(gets.chomp)
	rescue
		puts "Please enter valid date"
		retry
	end
	puts "\nMonth View ".rjust(50) + date.to_s
	for i in 1..31
		monthDates=date.year.to_s.chomp+"-"+date.month.to_s.chomp+"-"+i.to_s.chomp
		if hash.key?(Date.parse(monthDates))
			print i.to_s.ljust(3) , hash[Date.parse(monthDates)].length() ,"     "
		else
			print i.to_s.ljust(3) , "0     "
		end
		if i%7==0 or i==31
			puts "\n\n"
		end
	end
end

def specificDateEvents(hash)
	puts "Details of events in specific date"
	begin
		puts "Enter date in (yyyy-mm-dd) format"
		date=Date.parse(gets.chomp)
	rescue
		puts "Please enter valid date"
		retry
	end
	puts "\nDetail of Events ".rjust(50) + date.to_s + "\n\n"
	if hash.key?(date)
		eventsArray=hash[date]
		eventsArray.each do |i|
			print i.to_s
		end
	
	else
		puts "No event is registered on this date"
	end

end


def monthEventDetails(hash)
	puts "Print Details of events in month"
	begin
		puts "Enter date in (yyyy-mm-dd) format"
		date=Date.parse(gets.chomp)
	rescue
		puts "Please enter valid date"
		retry
	end
	puts "\nDetails of events in month ".rjust(50) + date.to_s+"\n\n"
	for i in 1..31
		monthDates=date.year.to_s.chomp+"-"+date.month.to_s.chomp+"-"+i.to_s.chomp
		if hash.key?(Date.parse(monthDates))
			if hash[Date.parse(monthDates)].length()>1
				eventsArray=hash[Date.parse(monthDates)]
				eventsArray.each do |j|
					puts i.to_s.ljust(3)
					puts j.to_s
				end
			else
				puts hash[Date.parse(monthDates)][0].to_s
			end
		end
	end
end


menu=Menu.new
hash=Hash.new
puts "****** Welcome to calender *******"
menu.displayMenu
while a=gets.chomp
	if a=="7"
		puts "Calender is closed successfully"
		return
	elsif a=="1"
		addEvent(hash)	
	elsif a=="2"
		updateEvent(hash)	
	elsif a=="3"
		deleteEvent(hash)
	elsif a=="4"
		monthView(hash)
	elsif a=="5"
		specificDateEvents(hash)
	elsif a=="6"
		monthEventDetails(hash)	
	elsif a=="8"
		hash.each do |key,value|
			puts value
		end
	end
	menu.displayMenu

end
