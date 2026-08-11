-- This script runs once, the first time the MySQL container initializes its
-- data volume. Its ONLY job is to make sure the databases exist and that the
-- application user can access them.
--
-- The table schema and seed data are intentionally NOT defined here. They are
-- owned by Rails (db/migrate/*, db/schema.rb and db/seeds.rb) so there is a
-- single source of truth. Defining tables in both places caused the schema to
-- drift (e.g. a `payer_name` column here vs. a `date` column in Rails) and made
-- `rails db:migrate` fail because the tables already existed.

CREATE DATABASE IF NOT EXISTS expense_system_development
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE DATABASE IF NOT EXISTS expense_system_test
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- The MYSQL_USER (expense_user) is only granted access to MYSQL_DATABASE by
-- default. Grant it access to the test database too so RSpec can run.
GRANT ALL PRIVILEGES ON expense_system_development.* TO 'expense_user'@'%';
GRANT ALL PRIVILEGES ON expense_system_test.* TO 'expense_user'@'%';
FLUSH PRIVILEGES;
