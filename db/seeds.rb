# create admin
Rake::Task['csv:import_permissions'].invoke
Rake::Task['users:add_permission'].invoke
