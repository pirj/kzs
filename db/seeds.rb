# create admin
Rake::Task['csv:import_permissions'].invoke
Rake::Task['users:create_admin'].invoke
