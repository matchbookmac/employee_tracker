require("sinatra")
require("sinatra/activerecord")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/division")
require("./lib/employee")
require("pg")
require("pry")

before() do
  @divisions = Division.all()
  @employees = Employee.all()
end

get('/') do
  erb(:index)
end

get('/reset') do
  Division.all.each do |division|
    division.destroy
  end
  Employee.all.each do |employee|
    employee.destroy
  end
  erb(:index)
end

get('/divisions/new') do
  erb(:division_form)
end

get('/employees/new') do
  erb(:employee_form)
end

post('/divisions/new') do
  division_name = params.fetch("name")
  division = Division.create({:name => division_name})
  redirect to('/')
end

post('/employees/new') do
  employee_name = params.fetch("name")
  employee = Employee.create({:name => employee_name})
  redirect to('/')
end

get('/divisions/:id') do
  @division = Division.find(params['id'].to_i())
  erb(:division)
end

patch('/divisions/:id') do
  division = Division.find(params['id'].to_i())
  division.update(name: params['name'])

  redirect to('/')
end

delete('/divisions/:id') do
  division = Division.find(params['id'].to_i())
  division.delete()
  redirect to('/')
end
