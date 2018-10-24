#Goal: Create a program that is a running todo list that allows the user to add and manage tasks. Began Sept. 1, 2018
#NNote to self: Still need to work on how to find a specific thing in the Pstore, updating todo and saving it to the pstore, and more effective ways of displaying the list.


require 'pstore'


#todostore = PStore.new("todolist.pstore")
#Create todo Class
class Todo 
	def initialize (title, description, status, owner)
		@title = title
		
		@desc = description
		@status = status.upcase!
		@owner = owner
	end

	def upstatus() 
		puts "What's the status?"
		stat = gets.chomp.upcase!

		case stat
		when "IN PROGRESS"
			@status = stat
			puts "task status is: #{@status}"
		when "COMPLETE"
			@status = stat
			puts "Task status is: #{@status}"
			#TO ADD OTHER CASES
		else
			puts "I don't recognize that"
		end
	end
	attr_accessor :title, :owner, :desc, :status
end
			
			
#cat = Todo.new("task title", "open", "do the thing that needs to be done", "rokk")
#puts cat.inspect
#cat.upstatus
#puts cat.inspect


#Create data store


def savetodo(task, pstore)
	  #wiki is the name of the Pstore
	pstore.transaction do  # begin transaction; do all of this or none of it
	  # store page...
	  pstore[task] = task
	  # ensure that an index has been created...
	  #pstore_name[:wiki_index] ||= Array.new
	  # update wiki index...
	  #pstore_name[:wiki_index].push(*add_this.wiki_page_references)
	  puts "You're task has been saved."
	end                   # commit changes to wiki data store file
end



#Create todo
def createtodo
	puts "I'll ask you a couple of questions in order to create your todo."
	puts "What is the title?"
	print "> "
	title = gets.chomp
	puts "Input task description:"
	print "> "
	desc = gets.chomp
	puts "Status (Open, In Progress, Blocked, or Complete):"
	print "> "
	stat = gets.chomp
		#if stat != "OPEN" || "IN PROGRESS" || "BLOCKED" || "COMPLETE"
		#	puts "Your status should be one of the following: Open, In Progress, Blocked, or Complete"
		#	puts "> "
		#end
	puts "Who is the owner: "
	print "> "
	owner = gets.chomp
	
	p = Todo.new(title, desc, stat, owner)
	
	todostore = PStore.new("todolist.pstore")
	savetodo(p, todostore)
	
	puts "\n"
	start(todostore)
end


#createtodo
#puts todostore
def showstore(store)
	var = 1
	puts "#" *10
	store.transaction(true) do  # begin read-only transaction, no changes allowed
  		store.roots.each do |asdf|
    		puts "Here is your task: #{var}"
    		p "Title: " + asdf.title
    		p "Description: " + asdf.desc
    		p "Status: " + asdf.status
    		#p todostore[data_root_name]
    		puts "#" * 10
    		var += 1
    	end
  	end
  	puts "\n"
  	start(store)
end

def delete(store)
	puts "I haven't figured out a way to delete an individual task once it's stored."
	puts "Do you want to delete all of the tasks in the program?"
	del = gets.chomp
			
	if 	 del == "yes" || del == "y"
		store.transaction do
			store.roots.each do |root|
				store.delete(root)
				end
		end
		puts "All tasks have been deleted"
		puts "Del was: #{del}"
	elsif del != "yes"
		puts "No tasks have been deleted."
		puts "Del was: #{del}"
	else
		puts "other else"
		puts "Del was: #{del}"
	end
			
end


#showstore(todostore)
#Update todo status

def start(store)
	puts "\n" "*****Welcome to Checklist 2200!*****"
	puts "Options: "
	puts "(1) Create"
	puts "(2) Update"
	puts "(3) Show tasks"
	puts "(4) Delete"
	puts "(5) Exit"
	print "> "

	input = gets.chomp.downcase
	case input
	when input == "1" || "create"
		 createtodo
	when input == "2" || "update"
		puts "I still need to figure out how to update a task once it's created. Bear with me."
		puts "What task would you like to update?"
		task = gets.chomp.downcase
		puts "What would you like to update? Title or Status?"
		choice = gets.chomp.downcase
		
		if choice == "status"
			puts "Options: Open, complete, in progress"
			newinfo = gets.chomp.downcase
			unless newinfo == "open"
				puts "Invalid entry!"
				puts "Program has ended."
				exit(1)
			end
			#if newinfo != "open" || newinfo != "complete" || newinfo != "in progress" || newinfo != "progress"
			#	puts "Invalid entry!"
			#	puts "Program has ended."
			#	exit(1)
			#else
			#	puts "You choice is: #{newinfo}"
			#end

		elsif choice == "title"
			puts "I will update the title to #{choice}"
		else
			puts "Invalid entry!"
			puts "Program has ended."
			exit(1)	
		end


				




		return start(store)
	when input == "3" || "show" || "show tasks" || "tasks"
		return showstore(store)
	when input == "4" || "delete"
		delete(store)		
	else puts "The program has exited!"
		exit(1)
	end		
end

#val = "new title given"

def updateTitle(store, match, newinfo)
store.transaction(false) do  
  	store.roots.each do |asdf|
		#var = 1
		if asdf.title == match
			puts "what should i do?"
			asdf.title = newinfo
			puts "The title was updated to: #{newinfo}"
		else
			puts "there was no match."
		end
    end
  end
end


def updateStatus(store, match, newinfo)
	store.transaction(false) do  
  	store.roots.each do |asdf|
		#How to do I make it so that once it finds a match, it does 
		#what it should do and end? Rather than continuing through the array?
		if asdf.title == match
			puts "what should i do?"
			asdf.status = newinfo
			puts "The status was updated to: #{newinfo}"
		else
			puts "there was no match."
		end
    end
  end
end