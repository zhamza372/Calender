require_relative "assignment.rb"

describe "Calender", "adding events" do
  
  it "should add event in a date" do
    check = EventOperations.new.add_event(Hash.new, Event.new("event1", "description1", "2012-12-12"))
    expect(check).to eql true
  end
  
  it "should not add event with same title" do
    event_operations = EventOperations.new
    hash = Hash.new
    check1 = event_operations.add_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check2 = event_operations.add_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check = check1 && check2
    expect(check).to eql false
  end

  it "should add two events in same date" do
    event_operations = EventOperations.new
    hash = Hash.new
    check1 = event_operations.add_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check2 = event_operations.add_event(hash, Event.new("event2", "description2", "2012-12-12"))
    check = check1 && check2
    expect(check).to eql true
  end

end

describe "Calender", "update events" do
  
  it "should update event if a single event is registered on a day" do
    event_operations = EventOperations.new
    hash = Hash.new
    check1 = event_operations.add_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check2 = event_operations.update_event(hash, Event.new("event1", "description1", "2012-12-12"),Event.new("event2", "description2", "2012-12-12"))
    check = check1 && check2
    expect(check).to eql true
  end
  
  it "should update event if two events are on same date" do
    event_operations = EventOperations.new
    hash = Hash.new
    check1 = event_operations.add_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check2 = event_operations.add_event(hash, Event.new("event2", "description2", "2012-12-12"))
    
    check3 = event_operations.update_event(hash, Event.new("event1", "description1", "2012-12-12"),Event.new("event3", "description3", "2012-12-12"))
    check = check1 && check2 && check3
    expect(check).to eql true
  end

  it "should not update event if the event is not registered" do
    event_operations = EventOperations.new
    hash = Hash.new
    check = event_operations.update_event(hash, Event.new("event1", "description1", "2012-12-12"),Event.new("event3", "description3", "2012-12-12"))
    expect(check).to eql false
  end

end

describe "Calender", "delete events" do
  
  it "should delete event if a single event is registered on a day" do
    event_operations = EventOperations.new
    hash = Hash.new
    check1 = event_operations.add_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check2 = event_operations.delete_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check = check1 && check2
    expect(check).to eql true
  end
  
  it "should delete event if two events are on same date" do
    event_operations = EventOperations.new
    hash = Hash.new
    check1 = event_operations.add_event(hash, Event.new("event1", "description1", "2012-12-12"))
    check2 = event_operations.add_event(hash, Event.new("event2", "description2", "2012-12-12"))
    check3 = event_operations.delete_event(hash, Event.new("event2", "description2", "2012-12-12"))
    check = check1 && check2 && check3
    expect(check).to eql true
  end

  it "should not delete event if the event is not registered" do
    event_operations = EventOperations.new
    hash = Hash.new
    check = event_operations.delete_event(hash, Event.new("event3", "description3", "2012-12-12"))
    expect(check).to eql false
  end

end

