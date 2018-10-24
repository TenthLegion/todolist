load 'todolistmethods.rb'

todostore = PStore.new("todolist.pstore")
start(todostore)

#The following is used to make adhoc updates outside of the update method
#which is still incomplete.


#var = "add update"
#val = "in progress"
#updateStatus(todostore, var, val)