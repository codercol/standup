## Rails 6.0.3.2 (June 17, 2020)

- No changes.

## Rails 6.0.3.1 (May 18, 2020)

- No changes.

## Rails 6.0.3 (May 06, 2020)

- Recommend applications don't use the `database` kwarg in `connected_to`

  The database kwarg in `connected_to` was meant to be used for one-off scripts but is often used in requests. This is really dangerous because it re-establishes a connection every time. It's deprecated in 6.1 and will be removed in 6.2 without replacement. This change soft deprecates it in 6.0 by removing documentation.

  _Eileen M. Uchitelle_

- Fix support for PostgreSQL 11+ partitioned indexes.

  _Sebastián Palma_

- Add support for beginless ranges, introduced in Ruby 2.7.

  _Josh Goodall_

- Fix insert_all with enum values

  Fixes #38716.

  _Joel Blum_

- Regexp-escape table name for MS SQL

  Add `Regexp.escape` to one method in ActiveRecord, so that table names with regular expression characters in them work as expected. Since MS SQL Server uses "[" and "]" to quote table and column names, and those characters are regular expression characters, methods like `pluck` and `select` fail in certain cases when used with the MS SQL Server adapter.

  _Larry Reid_

- Store advisory locks on their own named connection.

  Previously advisory locks were taken out against a connection when a migration started. This works fine in single database applications but doesn't work well when migrations need to open new connections which results in the lock getting dropped.

  In order to fix this we are storing the advisory lock on a new connection with the connection specification name `AdisoryLockBase`. The caveat is that we need to maintain at least 2 connections to a database while migrations are running in order to do this.

  _Eileen M. Uchitelle_, _John Crepezzi_

- Ensure `:reading` connections always raise if a write is attempted.

  Now Rails will raise an `ActiveRecord::ReadOnlyError` if any connection on the reading handler attempts to make a write. If your reading role needs to write you should name the role something other than `:reading`.

  _Eileen M. Uchitelle_

- Enforce fresh ETag header after a collection's contents change by adding
  ActiveRecord::Relation#cache_key_with_version. This method will be used by
  ActionController::ConditionalGet to ensure that when collection cache versioning
  is enabled, requests using ConditionalGet don't return the same ETag header
  after a collection is modified. Fixes #38078.

  _Aaron Lipman_

- A database URL can now contain a querystring value that contains an equal sign. This is needed to support passing PostgresSQL `options`.

  _Joshua Flanagan_

- Retain explicit selections on the base model after applying `includes` and `joins`.

  Resolves #34889.

  _Patrick Rebsch_

## Rails 6.0.2.2 (March 19, 2020)

- No changes.

## Rails 6.0.3.2 (December 18, 2019)

- No changes.

## Rails 6.0.2 (December 13, 2019)

- Share the same connection pool for primary and replica databases in the
  transactional tests for the same database.

  _Edouard Chin_

- Fix the preloader when one record is fetched using `after_initialize`
  but not the entire collection.

  _Bradley Price_

- Fix collection callbacks not terminating when `:abort` is thrown.

  _Edouard Chin_, _Ryuta Kamizono_

- Correctly deprecate `where.not` working as NOR for relations.

  12a9664 deprecated where.not working as NOR, however
  doing a relation query like `where.not(relation: { ... })`
  wouldn't be properly deprecated and `where.not` would work as
  NAND instead.

  _Edouard Chin_

- Fix `db:migrate` task with multiple databases to restore the connection
  to the previous database.

  The migrate task iterates and establish a connection over each db
  resulting in the last one to be used by subsequent rake tasks.
  We should reestablish a connection to the connection that was
  established before the migrate tasks was run

  _Edouard Chin_

- Fix multi-threaded issue for `AcceptanceValidator`.

  _Ryuta Kamizono_

## Rails 6.0.1 (November 5, 2019)

- Common Table Expressions are allowed on read-only connections.

  _Chris Morris_

- New record instantiation respects `unscope`.

  _Ryuta Kamizono_

- Fixed a case where `find_in_batches` could halt too early.

  _Takayuki Nakata_

- Autosaved associations always perform validations when a custom validation
  context is used.

  _Tekin Suleyman_

- `sql.active_record` notifications now include the `:connection` in
  their payloads.

  _Eugene Kenny_

- A rollback encountered in an `after_commit` callback does not reset
  previously-committed record state.

  _Ryuta Kamizono_

- Fixed that join order was lost when eager-loading.

  _Ryuta Kamizono_

- `DESCRIBE` queries are allowed on read-only connections.

  _Dylan Thacker-Smith_

- Fixed that records that had been `inspect`ed could not be marshaled.

  _Eugene Kenny_

- The connection pool reaper thread is respawned in forked processes. This
  fixes that idle connections in forked processes wouldn't be reaped.

  _John Hawthorn_

- The memoized result of `ActiveRecord::Relation#take` is properly cleared
  when `ActiveRecord::Relation#reset` or `ActiveRecord::Relation#reload`
  is called.

  _Anmol Arora_

- Fixed the performance regression for `primary_keys` introduced MySQL 8.0.

  _Hiroyuki Ishii_

- `insert`, `insert_all`, `upsert`, and `upsert_all` now clear the query cache.

  _Eugene Kenny_

- Call `while_preventing_writes` directly from `connected_to`.

  In some cases application authors want to use the database switching middleware and make explicit calls with `connected_to`. It's possible for an app to turn off writes and not turn them back on by the time we call `connected_to(role: :writing)`.

  This change allows apps to fix this by assuming if a role is writing we want to allow writes, except in the case it's explicitly turned off.

  _Eileen M. Uchitelle_

- Improve detection of ActiveRecord::StatementTimeout with mysql2 adapter in the edge case when the query is terminated during filesort.

  _Kir Shatrov_

## Rails 6.0.0 (August 16, 2019)

- Preserve user supplied joins order as much as possible.

  Fixes #36761, #34328, #24281, #12953.

  _Ryuta Kamizono_

- Make the DATABASE_URL env variable only affect the primary connection. Add new env variables for multiple databases.

  _John Crepezzi_, _Eileen Uchitelle_

- Add a warning for enum elements with 'not\_' prefix.

      class Foo
        enum status: [:sent, :not_sent]
      end

  _Edu Depetris_

- Make currency symbols optional for money column type in PostgreSQL

  _Joel Schneider_

## Rails 6.0.0.rc2 (July 22, 2019)

- Add database_exists? method to connection adapters to check if a database exists.

  _Guilherme Mansur_

- PostgreSQL: Fix GROUP BY with ORDER BY virtual count attribute.

  Fixes #36022.

  _Ryuta Kamizono_

- Make ActiveRecord `ConnectionPool.connections` method thread-safe.

  Fixes #36465.

  _Jeff Doering_

- Fix sqlite3 collation parsing when using decimal columns.

  _Martin R. Schuster_

- Fix invalid schema when primary key column has a comment.

  Fixes #29966.

  _Guilherme Goettems Schneider_

- Fix table comment also being applied to the primary key column.

  _Guilherme Goettems Schneider_

- Fix merging left_joins to maintain its own `join_type` context.

  Fixes #36103.

  _Ryuta Kamizono_

## Rails 6.0.0.rc1 (April 24, 2019)

- Add `touch` option to `has_one` association.

  _Abhay Nikam_

- Deprecate `where.not` working as NOR and will be changed to NAND in Rails 6.1.

  ```ruby
  all = [treasures(:diamond), treasures(:sapphire), cars(:honda), treasures(:sapphire)]
  assert_equal all, PriceEstimate.all.map(&:estimate_of)
  ```

  In Rails 6.0:

  ```ruby
  sapphire = treasures(:sapphire)

  nor = all.reject { |e|
    e.estimate_of_type == sapphire.class.polymorphic_name
  }.reject { |e|
    e.estimate_of_id == sapphire.id
  }
  assert_equal [cars(:honda)], nor

  without_sapphire = PriceEstimate.where.not(
    estimate_of_type: sapphire.class.polymorphic_name, estimate_of_id: sapphire.id
  )
  assert_equal nor, without_sapphire.map(&:estimate_of)
  ```

  In Rails 6.1:

  ```ruby
  sapphire = treasures(:sapphire)

  nand = all - [sapphire]
  assert_equal [treasures(:diamond), cars(:honda)], nand

  without_sapphire = PriceEstimate.where.not(
    estimate_of_type: sapphire.class.polymorphic_name, estimate_of_id: sapphire.id
  )
  assert_equal nand, without_sapphire.map(&:estimate_of)
  ```

  _Ryuta Kamizono_

- Fix dirty tracking after rollback.

  Fixes #15018, #30167, #33868.

  _Ryuta Kamizono_

- Add `ActiveRecord::Relation#cache_version` to support recyclable cache keys via
  the versioned entries in `ActiveSupport::Cache`. This also means that
  `ActiveRecord::Relation#cache_key` will now return a stable key that does not
  include the max timestamp or count any more.

  NOTE: This feature is turned off by default, and `cache_key` will still return
  cache keys with timestamps until you set `ActiveRecord::Base.collection_cache_versioning = true`.
  That's the setting for all new apps on Rails 6.0+

  _Lachlan Sylvester_

- Fix dirty tracking for `touch` to track saved changes.

  Fixes #33429.

  _Ryuta Kamzono_

- `change_column_comment` and `change_table_comment` are invertible only if
  `to` and `from` options are specified.

  _Yoshiyuki Kinjo_

- Don't call commit/rollback callbacks when a record isn't saved.

  Fixes #29747.

  _Ryuta Kamizono_

- Fix circular `autosave: true` causes invalid records to be saved.

  Prior to the fix, when there was a circular series of `autosave: true`
  associations, the callback for a `has_many` association was run while
  another instance of the same callback on the same association hadn't
  finished running. When control returned to the first instance of the
  callback, the instance variable had changed, and subsequent associated
  records weren't saved correctly. Specifically, the ID field for the
  `belongs_to` corresponding to the `has_many` was `nil`.

  Fixes #28080.

  _Larry Reid_

- Raise `ArgumentError` for invalid `:limit` and `:precision` like as other options.

  Before:

  ```ruby
  add_column :items, :attr1, :binary,   size: 10      # => ArgumentError
  add_column :items, :attr2, :decimal,  scale: 10     # => ArgumentError
  add_column :items, :attr3, :integer,  limit: 10     # => ActiveRecordError
  add_column :items, :attr4, :datetime, precision: 10 # => ActiveRecordError
  ```

  After:

  ```ruby
  add_column :items, :attr1, :binary,   size: 10      # => ArgumentError
  add_column :items, :attr2, :decimal,  scale: 10     # => ArgumentError
  add_column :items, :attr3, :integer,  limit: 10     # => ArgumentError
  add_column :items, :attr4, :datetime, precision: 10 # => ArgumentError
  ```

  _Ryuta Kamizono_

- Association loading isn't to be affected by scoping consistently
  whether preloaded / eager loaded or not, with the exception of `unscoped`.

  Before:

  ```ruby
  Post.where("1=0").scoping do
    Comment.find(1).post                   # => nil
    Comment.preload(:post).find(1).post    # => #<Post id: 1, ...>
    Comment.eager_load(:post).find(1).post # => #<Post id: 1, ...>
  end
  ```

  After:

  ```ruby
  Post.where("1=0").scoping do
    Comment.find(1).post                   # => #<Post id: 1, ...>
    Comment.preload(:post).find(1).post    # => #<Post id: 1, ...>
    Comment.eager_load(:post).find(1).post # => #<Post id: 1, ...>
  end
  ```

  Fixes #34638, #35398.

  _Ryuta Kamizono_

- Add `rails db:prepare` to migrate or setup a database.

  Runs `db:migrate` if the database exists or `db:setup` if it doesn't.

  _Roberto Miranda_

- Add `after_save_commit` callback as shortcut for `after_commit :hook, on: [ :create, :update ]`.

  _DHH_

- Assign all attributes before calling `build` to ensure the child record is visible in
  `before_add` and `after_add` callbacks for `has_many :through` associations.

  Fixes #33249.

  _Ryan H. Kerr_

- Add `ActiveRecord::Relation#extract_associated` for extracting associated records from a relation.

  ```
  account.memberships.extract_associated(:user)
  # => Returns collection of User records
  ```

  _DHH_

- Add `ActiveRecord::Relation#annotate` for adding SQL comments to its queries.

  For example:

  ```
  Post.where(id: 123).annotate("this is a comment").to_sql
  # SELECT "posts".* FROM "posts" WHERE "posts"."id" = 123 /* this is a comment */
  ```

  This can be useful in instrumentation or other analysis of issued queries.

  _Matt Yoho_

- Support Optimizer Hints.

  In most databases, a way to control the optimizer is by using optimizer hints,
  which can be specified within individual statements.

  Example (for MySQL):

      Topic.optimizer_hints("MAX_EXECUTION_TIME(50000)", "NO_INDEX_MERGE(topics)")
      # SELECT /*+ MAX_EXECUTION_TIME(50000) NO_INDEX_MERGE(topics) */ `topics`.* FROM `topics`

  Example (for PostgreSQL with pg_hint_plan):

      Topic.optimizer_hints("SeqScan(topics)", "Parallel(topics 8)")
      # SELECT /*+ SeqScan(topics) Parallel(topics 8) */ "topics".* FROM "topics"

  See also:

  - https://dev.mysql.com/doc/refman/8.0/en/optimizer-hints.html
  - https://pghintplan.osdn.jp/pg_hint_plan.html
  - https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgsql/influencing-the-optimizer.html
  - https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-query?view=sql-server-2017
  - https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.admin.perf.doc/doc/c0070117.html

  _Ryuta Kamizono_

- Fix query attribute method on user-defined attribute to be aware of typecasted value.

  For example, the following code no longer return false as casted non-empty string:

  ```
  class Post < ActiveRecord::Base
    attribute :user_defined_text, :text
  end

  Post.new(user_defined_text: "false").user_defined_text? # => true
  ```

  _Yuji Kamijima_

- Quote empty ranges like other empty enumerables.

  _Patrick Rebsch_

- Add `insert_all`/`insert_all!`/`upsert_all` methods to `ActiveRecord::Persistence`,
  allowing bulk inserts akin to the bulk updates provided by `update_all` and
  bulk deletes by `delete_all`.

  Supports skipping or upserting duplicates through the `ON CONFLICT` syntax
  for PostgreSQL (9.5+) and SQLite (3.24+) and `ON DUPLICATE KEY UPDATE` syntax
  for MySQL.

  _Bob Lail_

- Add `rails db:seed:replant` that truncates tables of each database
  for current environment and loads the seeds.

  _bogdanvlviv_, _DHH_

- Add `ActiveRecord::Base.connection.truncate` for SQLite3 adapter.

  _bogdanvlviv_

- Deprecate mismatched collation comparison for uniqueness validator.

  Uniqueness validator will no longer enforce case sensitive comparison in Rails 6.1.
  To continue case sensitive comparison on the case insensitive column,
  pass `case_sensitive: true` option explicitly to the uniqueness validator.

  _Ryuta Kamizono_

- Add `reselect` method. This is a short-hand for `unscope(:select).select(fields)`.

  Fixes #27340.

  _Willian Gustavo Veiga_

- Add negative scopes for all enum values.

  Example:

      class Post < ActiveRecord::Base
        enum status: %i[ drafted active trashed ]
      end

      Post.not_drafted # => where.not(status: :drafted)
      Post.not_active  # => where.not(status: :active)
      Post.not_trashed # => where.not(status: :trashed)

  _DHH_

- Fix different `count` calculation when using `size` with manual `select` with DISTINCT.

  Fixes #35214.

  _Juani Villarejo_

## Rails 6.0.0.beta3 (March 11, 2019)

- No changes.

## Rails 6.0.0.beta2 (February 25, 2019)

- Fix prepared statements caching to be enabled even when query caching is enabled.

  _Ryuta Kamizono_

- Ensure `update_all` series cares about optimistic locking.

  _Ryuta Kamizono_

- Don't allow `where` with non numeric string matches to 0 values.

  _Ryuta Kamizono_

- Introduce `ActiveRecord::Relation#destroy_by` and `ActiveRecord::Relation#delete_by`.

  `destroy_by` allows relation to find all the records matching the condition and perform
  `destroy_all` on the matched records.

  Example:

      Person.destroy_by(name: 'David')
      Person.destroy_by(name: 'David', rating: 4)

      david = Person.find_by(name: 'David')
      david.posts.destroy_by(id: [1, 2, 3])

  `delete_by` allows relation to find all the records matching the condition and perform
  `delete_all` on the matched records.

  Example:

      Person.delete_by(name: 'David')
      Person.delete_by(name: 'David', rating: 4)

      david = Person.find_by(name: 'David')
      david.posts.delete_by(id: [1, 2, 3])

  _Abhay Nikam_

- Don't allow `where` with invalid value matches to nil values.

  Fixes #33624.

  _Ryuta Kamizono_

- SQLite3: Implement `add_foreign_key` and `remove_foreign_key`.

  _Ryuta Kamizono_

- Deprecate using class level querying methods if the receiver scope
  regarded as leaked. Use `klass.unscoped` to avoid the leaking scope.

  _Ryuta Kamizono_

- Allow applications to automatically switch connections.

  Adds a middleware and configuration options that can be used in your
  application to automatically switch between the writing and reading
  database connections.

  `GET` and `HEAD` requests will read from the replica unless there was
  a write in the last 2 seconds, otherwise they will read from the primary.
  Non-get requests will always write to the primary. The middleware accepts
  an argument for a Resolver class and an Operations class where you are able
  to change how the auto-switcher works to be most beneficial for your
  application.

  To use the middleware in your application you can use the following
  configuration options:

  ```
  config.active_record.database_selector = { delay: 2.seconds }
  config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
  ```

  To change the database selection strategy, pass a custom class to the
  configuration options:

  ```
  config.active_record.database_selector = { delay: 10.seconds }
  config.active_record.database_resolver = MyResolver
  config.active_record.database_resolver_context = MyResolver::MyCookies
  ```

  _Eileen M. Uchitelle_

- MySQL: Support `:size` option to change text and blob size.

  _Ryuta Kamizono_

- Make `t.timestamps` with precision by default.

  _Ryuta Kamizono_

## Rails 6.0.0.beta1 (January 18, 2019)

- Remove deprecated `#set_state` from the transaction object.

  _Rafael Mendonça França_

- Remove deprecated `#supports_statement_cache?` from the database adapters.

  _Rafael Mendonça França_

- Remove deprecated `#insert_fixtures` from the database adapters.

  _Rafael Mendonça França_

- Remove deprecated `ActiveRecord::ConnectionAdapters::SQLite3Adapter#valid_alter_table_type?`.

  _Rafael Mendonça França_

- Do not allow passing the column name to `sum` when a block is passed.

  _Rafael Mendonça França_

- Do not allow passing the column name to `count` when a block is passed.

  _Rafael Mendonça França_

- Remove delegation of missing methods in a relation to arel.

  _Rafael Mendonça França_

- Remove delegation of missing methods in a relation to private methods of the class.

  _Rafael Mendonça França_

- Deprecate `config.active_record.sqlite3.represent_boolean_as_integer`.

  _Rafael Mendonça França_

- Change `SQLite3Adapter` to always represent boolean values as integers.

  _Rafael Mendonça França_

- Remove ability to specify a timestamp name for `#cache_key`.

  _Rafael Mendonça França_

- Remove deprecated `ActiveRecord::Migrator.migrations_path=`.

  _Rafael Mendonça França_

- Remove deprecated `expand_hash_conditions_for_aggregates`.

  _Rafael Mendonça França_

- Set polymorphic type column to NULL on `dependent: :nullify` strategy.

  On polymorphic associations both the foreign key and the foreign type columns will be set to NULL.

  _Laerti Papa_

- Allow permitted instance of `ActionController::Parameters` as argument of `ActiveRecord::Relation#exists?`.

  _Gannon McGibbon_

- Add support for endless ranges introduces in Ruby 2.6.

  _Greg Navis_

- Deprecate passing `migrations_paths` to `connection.assume_migrated_upto_version`.

  _Ryuta Kamizono_

- MySQL: `ROW_FORMAT=DYNAMIC` create table option by default.

  Since MySQL 5.7.9, the `innodb_default_row_format` option defines the default row
  format for InnoDB tables. The default setting is `DYNAMIC`.
  The row format is required for indexing on `varchar(255)` with `utf8mb4` columns.

  _Ryuta Kamizono_

- Fix join table column quoting with SQLite.

  _Gannon McGibbon_

- Allow disabling scopes generated by `ActiveRecord.enum`.

  _Alfred Dominic_

- Ensure that `delete_all` on collection proxy returns affected count.

  _Ryuta Kamizono_

- Reset scope after delete on collection association to clear stale offsets of removed records.

  _Gannon McGibbon_

- Add the ability to prevent writes to a database for the duration of a block.

  Allows the application to prevent writes to a database. This can be useful when
  you're building out multiple databases and want to make sure you're not sending
  writes when you want a read.

  If `while_preventing_writes` is called and the query is considered a write
  query the database will raise an exception regardless of whether the database
  user is able to write.

  This is not meant to be a catch-all for write queries but rather a way to enforce
  read-only queries without opening a second connection. One purpose of this is to
  catch accidental writes, not all writes.

  _Eileen M. Uchitelle_

- Allow aliased attributes to be used in `#update_columns` and `#update`.

  _Gannon McGibbon_

- Allow spaces in postgres table names.

  Fixes issue where "user post" is misinterpreted as "\"user\".\"post\"" when quoting table names with the postgres adapter.

  _Gannon McGibbon_

- Cached `columns_hash` fields should be excluded from `ResultSet#column_types`.

  PR #34528 addresses the inconsistent behaviour when attribute is defined for an ignored column. The following test
  was passing for SQLite and MySQL, but failed for PostgreSQL:

  ```ruby
  class DeveloperName < ActiveRecord::Type::String
    def deserialize(value)
      "Developer: #{value}"
    end
  end

  class AttributedDeveloper < ActiveRecord::Base
    self.table_name = "developers"

    attribute :name, DeveloperName.new

    self.ignored_columns += ["name"]
  end

  developer = AttributedDeveloper.create
  developer.update_column :name, "name"

  loaded_developer = AttributedDeveloper.where(id: developer.id).select("*").first
  puts loaded_developer.name # should be "Developer: name" but it's just "name"
  ```

  _Dmitry Tsepelev_

- Make the implicit order column configurable.

  When calling ordered finder methods such as `first` or `last` without an
  explicit order clause, ActiveRecord sorts records by primary key. This can
  result in unpredictable and surprising behaviour when the primary key is
  not an auto-incrementing integer, for example when it's a UUID. This change
  makes it possible to override the column used for implicit ordering such
  that `first` and `last` will return more predictable results.

  Example:

      class Project < ActiveRecord::Base
        self.implicit_order_column = "created_at"
      end

  _Tekin Suleyman_

- Bump minimum PostgreSQL version to 9.3.

  _Yasuo Honda_

- Values of enum are frozen, raising an error when attempting to modify them.

  _Emmanuel Byrd_

- Move `ActiveRecord::StatementInvalid` SQL to error property and include binds as separate error property.

  `ActiveRecord::ConnectionAdapters::AbstractAdapter#translate_exception_class` now requires `binds` to be passed as the last argument.

  `ActiveRecord::ConnectionAdapters::AbstractAdapter#translate_exception` now requires `message`, `sql`, and `binds` to be passed as keyword arguments.

  Subclasses of `ActiveRecord::StatementInvalid` must now provide `sql:` and `binds:` arguments to `super`.

  Example:

  ```
  class MySubclassedError < ActiveRecord::StatementInvalid
    def initialize(message, sql:, binds:)
      super(message, sql: sql, binds: binds)
    end
  end
  ```

  _Gannon McGibbon_

- Add an `:if_not_exists` option to `create_table`.

  Example:

      create_table :posts, if_not_exists: true do |t|
        t.string :title
      end

  That would execute:

      CREATE TABLE IF NOT EXISTS posts (
        ...
      )

  If the table already exists, `if_not_exists: false` (the default) raises an
  exception whereas `if_not_exists: true` does nothing.

  _fatkodima_, _Stefan Kanev_

- Defining an Enum as a Hash with blank key, or as an Array with a blank value, now raises an `ArgumentError`.

  _Christophe Maximin_

- Adds support for multiple databases to `rails db:schema:cache:dump` and `rails db:schema:cache:clear`.

  _Gannon McGibbon_

- `update_columns` now correctly raises `ActiveModel::MissingAttributeError`
  if the attribute does not exist.

  _Sean Griffin_

- Add support for hash and URL configs in database hash of `ActiveRecord::Base.connected_to`.

  ```
  User.connected_to(database: { writing: "postgres://foo" }) do
    User.create!(name: "Gannon")
  end

  config = { "adapter" => "sqlite3", "database" => "db/readonly.sqlite3" }
  User.connected_to(database: { reading: config }) do
    User.count
  end
  ```

  _Gannon McGibbon_

- Support default expression for MySQL.

  MySQL 8.0.13 and higher supports default value to be a function or expression.

  https://dev.mysql.com/doc/refman/8.0/en/create-table.html

  _Ryuta Kamizono_

- Support expression indexes for MySQL.

  MySQL 8.0.13 and higher supports functional key parts that index
  expression values rather than column or column prefix values.

  https://dev.mysql.com/doc/refman/8.0/en/create-index.html

  _Ryuta Kamizono_

- Fix collection cache key with limit and custom select to avoid ambiguous timestamp column error.

  Fixes #33056.

  _Federico Martinez_

- Add basic API for connection switching to support multiple databases.

  1. Adds a `connects_to` method for models to connect to multiple databases. Example:

  ```
  class AnimalsModel < ApplicationRecord
    self.abstract_class = true

    connects_to database: { writing: :animals_primary, reading: :animals_replica }
  end

  class Dog < AnimalsModel
    # connected to both the animals_primary db for writing and the animals_replica for reading
  end
  ```

  2. Adds a `connected_to` block method for switching connection roles or connecting to
     a database that the model didn't connect to. Connecting to the database in this block is
     useful when you have another defined connection, for example `slow_replica` that you don't
     want to connect to by default but need in the console, or a specific code block.

  ```
  ActiveRecord::Base.connected_to(role: :reading) do
    Dog.first # finds dog from replica connected to AnimalsBase
    Book.first # doesn't have a reading connection, will raise an error
  end
  ```

  ```
  ActiveRecord::Base.connected_to(database: :slow_replica) do
    SlowReplicaModel.first # if the db config has a slow_replica configuration this will be used to do the lookup, otherwise this will throw an exception
  end
  ```

  _Eileen M. Uchitelle_

- Enum raises on invalid definition values

  When defining a Hash enum it can be easy to use `[]` instead of `{}`. This
  commit checks that only valid definition values are provided, those can
  be a Hash, an array of Symbols or an array of Strings. Otherwise it
  raises an `ArgumentError`.

  Fixes #33961

  _Alberto Almagro_

- Reloading associations now clears the Query Cache like `Persistence#reload` does.

  ```
  class Post < ActiveRecord::Base
    has_one :category
    belongs_to :author
    has_many :comments
  end

  # Each of the following will now clear the query cache.
  post.reload_category
  post.reload_author
  post.comments.reload
  ```

  _Christophe Maximin_

- Added `index` option for `change_table` migration helpers.
  With this change you can create indexes while adding new
  columns into the existing tables.

  Example:

      change_table(:languages) do |t|
        t.string :country_code, index: true
      end

  _Mehmet Emin İNAÇ_

- Fix `transaction` reverting for migrations.

  Before: Commands inside a `transaction` in a reverted migration ran uninverted.
  Now: This change fixes that by reverting commands inside `transaction` block.

  _fatkodima_, _David Verhasselt_

- Raise an error instead of scanning the filesystem root when `fixture_path` is blank.

  _Gannon McGibbon_, _Max Albrecht_

- Allow `ActiveRecord::Base.configurations=` to be set with a symbolized hash.

  _Gannon McGibbon_

- Don't update counter cache unless the record is actually saved.

  Fixes #31493, #33113, #33117.

  _Ryuta Kamizono_

- Deprecate `ActiveRecord::Result#to_hash` in favor of `ActiveRecord::Result#to_a`.

  _Gannon McGibbon_, _Kevin Cheng_

- SQLite3 adapter supports expression indexes.

  ```
  create_table :users do |t|
    t.string :email
  end

  add_index :users, 'lower(email)', name: 'index_users_on_email', unique: true
  ```

  _Gray Kemmey_

- Allow subclasses to redefine autosave callbacks for associated records.

  Fixes #33305.

  _Andrey Subbota_

- Bump minimum MySQL version to 5.5.8.

  _Yasuo Honda_

- Use MySQL utf8mb4 character set by default.

  `utf8mb4` character set with 4-Byte encoding supports supplementary characters including emoji.
  The previous default 3-Byte encoding character set `utf8` is not enough to support them.

  _Yasuo Honda_

- Fix duplicated record creation when using nested attributes with `create_with`.

  _Darwin Wu_

- Configuration item `config.filter_parameters` could also filter out
  sensitive values of database columns when calling `#inspect`.
  We also added `ActiveRecord::Base::filter_attributes`/`=` in order to
  specify sensitive attributes to specific model.

  ```
  Rails.application.config.filter_parameters += [:credit_card_number, /phone/]
  Account.last.inspect # => #<Account id: 123, name: "DHH", credit_card_number: [FILTERED], telephone_number: [FILTERED] ...>
  SecureAccount.filter_attributes += [:name]
  SecureAccount.last.inspect # => #<SecureAccount id: 42, name: [FILTERED], credit_card_number: [FILTERED] ...>
  ```

  _Zhang Kang_, _Yoshiyuki Kinjo_

- Deprecate `column_name_length`, `table_name_length`, `columns_per_table`,
  `indexes_per_table`, `columns_per_multicolumn_index`, `sql_query_length`,
  and `joins_per_query` methods in `DatabaseLimits`.

  _Ryuta Kamizono_

- `ActiveRecord::Base.configurations` now returns an object.

  `ActiveRecord::Base.configurations` used to return a hash, but this
  is an inflexible data model. In order to improve multiple-database
  handling in Rails, we've changed this to return an object. Some methods
  are provided to make the object behave hash-like in order to ease the
  transition process. Since most applications don't manipulate the hash
  we've decided to add backwards-compatible functionality that will throw
  a deprecation warning if used, however calling `ActiveRecord::Base.configurations`
  will use the new version internally and externally.

  For example, the following `database.yml`:

  ```
  development:
    adapter: sqlite3
    database: db/development.sqlite3
  ```

  Used to become a hash:

  ```
  { "development" => { "adapter" => "sqlite3", "database" => "db/development.sqlite3" } }
  ```

  Is now converted into the following object:

  ```
  #<ActiveRecord::DatabaseConfigurations:0x00007fd1acbdf800 @configurations=[
    #<ActiveRecord::DatabaseConfigurations::HashConfig:0x00007fd1acbded10 @env_name="development",
      @spec_name="primary", @config={"adapter"=>"sqlite3", "database"=>"db/development.sqlite3"}>
    ]
  ```

  Iterating over the database configurations has also changed. Instead of
  calling hash methods on the `configurations` hash directly, a new method `configs_for` has
  been provided that allows you to select the correct configuration. `env_name` and
  `spec_name` arguments are optional. For example, these return an array of
  database config objects for the requested environment and a single database config object
  will be returned for the requested environment and specification name respectively.

  ```
  ActiveRecord::Base.configurations.configs_for(env_name: "development")
  ActiveRecord::Base.configurations.configs_for(env_name: "development", spec_name: "primary")
  ```

  _Eileen M. Uchitelle_, _Aaron Patterson_

- Add database configuration to disable advisory locks.

  ```
  production:
    adapter: postgresql
    advisory_locks: false
  ```

  _Guo Xiang_

- SQLite3 adapter `alter_table` method restores foreign keys.

  _Yasuo Honda_

- Allow `:to_table` option to `invert_remove_foreign_key`.

  Example:

  remove_foreign_key :accounts, to_table: :owners

  _Nikolay Epifanov_, _Rich Chen_

- Add environment & load_config dependency to `bin/rake db:seed` to enable
  seed load in environments without Rails and custom DB configuration

  _Tobias Bielohlawek_

- Fix default value for mysql time types with specified precision.

  _Nikolay Kondratyev_

- Fix `touch` option to behave consistently with `Persistence#touch` method.

  _Ryuta Kamizono_

- Migrations raise when duplicate column definition.

  Fixes #33024.

  _Federico Martinez_

- Bump minimum SQLite version to 3.8

  _Yasuo Honda_

- Fix parent record should not get saved with duplicate children records.

  Fixes #32940.

  _Santosh Wadghule_

- Fix logic on disabling commit callbacks so they are not called unexpectedly when errors occur.

  _Brian Durand_

- Ensure `Associations::CollectionAssociation#size` and `Associations::CollectionAssociation#empty?`
  use loaded association ids if present.

  _Graham Turner_

- Add support to preload associations of polymorphic associations when not all the records have the requested associations.

  _Dana Sherson_

- Add `touch_all` method to `ActiveRecord::Relation`.

  Example:

      Person.where(name: "David").touch_all(time: Time.new(2020, 5, 16, 0, 0, 0))

  _fatkodima_, _duggiefresh_

- Add `ActiveRecord::Base.base_class?` predicate.

  _Bogdan Gusiev_

- Add custom prefix/suffix options to `ActiveRecord::Store.store_accessor`.

  _Tan Huynh_, _Yukio Mizuta_

- Rails 6 requires Ruby 2.5.0 or newer.

  _Jeremy Daer_, _Kasper Timm Hansen_

- Deprecate `update_attributes`/`!` in favor of `update`/`!`.

  _Eddie Lebow_

- Add `ActiveRecord::Base.create_or_find_by`/`!` to deal with the SELECT/INSERT race condition in
  `ActiveRecord::Base.find_or_create_by`/`!` by leaning on unique constraints in the database.

  _DHH_

- Add `Relation#pick` as short-hand for single-value plucks.

  _DHH_

Please check [5-2-stable](https://github.com/rails/rails/blob/5-2-stable/activerecord/CHANGELOG.md) for previous changes.
