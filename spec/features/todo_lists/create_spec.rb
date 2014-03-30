require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})
		options[:title] ||="My todo list"
		options[:description] ||="This is my todo list"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today."
		click_botton "Create Todo list" 
	end

	it "redirects to the todo list index page on success" do
		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "Displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title:""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(TodoList.count).to_not have_content("This is what I'm doing today.")
	end
end