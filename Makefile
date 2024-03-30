.PHONY: migrate migrate_create migrate_down migrate_up migrate_version

# Get the value of the `table_name` variable or default to an empty string
table_name ?= 

# Check if the `table_name` variable is not empty
ifeq ($(table_name),)
    $(error 'table_name' is required. Use: make migrate_create table_name=<your_table_name>)
endif

# ==============================================================================
# Go migrate database
migrate_create:
	migrate create -ext sql -dir migrations -seq create_$(table_name)_table

force:
	migrate -database postgres://postgres:postgres@localhost:5432/auth_db?sslmode=disable -path migrations force 1

version:
	migrate -database postgres://postgres:postgres@localhost:5432/auth_db?sslmode=disable -path migrations version

migrate_up:
	migrate -database postgres://postgres:postgres@localhost:5432/auth_db?sslmode=disable -path migrations up 1

migrate_down:
	migrate -database postgres://postgres:postgres@localhost:5432/auth_db?sslmode=disable -path migrations down 1
