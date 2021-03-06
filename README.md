


# SchemaPlus family

The SchemaPlus family of gems provide various extensions and enhancements to ActiveRecord.  

Listed alphabetically:

Gem | Description | Included In `schema_plus` gem?
----| ----------- |:------------------------------:
[schema_associations](https://github.com/SchemaPlus/schema_associations) | Automatically defines model associations based on foreign key relations |
<p style="color:grey">schema_auto_foreign_keys</p> | Automatically creates foreign keys on referencing columns | Y
[schema_plus_columns](https://github.com/SchemaPlus/schema_plus_columns) | Column attributes including `column.indexes` and `column.unique?` | Y
[schema_plus_db_default](https://github.com/SchemaPlus/schema_plus_db_default) | Use `ActiveRecord::DB_DEFAULT` to set an attribute to the database default | Y
[schema_plus_default_expr](https://github.com/SchemaPlus/schema_plus_default_expr)  | Use SQL expressions for database default values | Y
[schema_plus_enums](https://github.com/SchemaPlus/schema_plus_enums) | Define enum types in migrations | Y
<p style="color:grey">schema_plus_foreign_keys | Extended support for foreign keys, including creation as column options, `:deferrable`, and SQLite3 support | Y
[schema_plus_indexes](https://github.com/SchemaPlus/schema_plus_indexes) | Convenience and consistency in using indexes | Y
[schema_plus_pg_indexes](https://github.com/SchemaPlus/schema_plus_pg_indexes) |PostgreSQL index features: `case_insenstive`, `expression` and `operator_class` | Y
[schema_plus_tables](https://github.com/SchemaPlus/schema_plus_tables) | Convenience and consistency in using tables | Y
[schema_plus_views](https://github.com/SchemaPlus/schema_plus_views) | Create and drop views in migrations | Y
[schema_validations](https://github.com/SchemaPlus/schema_validations) | Automatically defines ActiveRecord validations based on database constraints |

See detailed documentation in each gem's README.

*Is there some other capability you wish SchemaPlus had a gem for?*  Open an issue here. Or try implementing it yourself -- creating ActiveRecord extensions is easy and fun using SchemaPlus's tools [schema_monkey](https://github.com/SchemaPlus/schema_monkey) and [schema_plus_core](https://github.com/SchemaPlus/schema_plus_core)!!

---
# The `schema_plus` gem

[![Gem Version](https://badge.fury.io/rb/schema_plus.svg)](http://badge.fury.io/rb/schema_plus)
[![Build Status](https://secure.travis-ci.org/SchemaPlus/schema_plus.svg)](http://travis-ci.org/SchemaPlus/schema_plus)
[![Coverage Status](https://img.shields.io/coveralls/SchemaPlus/schema_plus.svg)](https://coveralls.io/r/SchemaPlus/schema_plus)
[![Dependency Status](https://gemnasium.com/lomba/schema_plus.svg)](https://gemnasium.com/SchemaPlus/schema_plus)


> ## This is the README for schema_plus 2.0.0 (prelease)
> which is under development in the master branch, and which supports Rails >= 4.2.  For info about the stable 1.x releases which support Rails 3.1, 4.0, 4.1, and 4.2.0, see the [schema_plus 1.x](https://github.com/SchemaPlus/schema_plus/tree/1.x) branch

---


The `schema_plus` gem is a wrapper that pulls in a common collection of gems from the SchemaPlus family.   But you can feel free to mix and match to get just the gems you want.

Note: Prior to version 2.0, `schema_plus` was a single monolothic gem that implemented in itself all the features that are now included by the wrapper.


> **IN PROGRESS:** In the prerelease versions of SchemaPlus 2.0, some features have yet to be migrated out to their own gems, and their code is still in the body of schema_plus.  Those gems are greyed out in the list above.  The documentation for their features is at the end of this README.


### Upgrading from `schema_plus` 1.8.x

`schema_plus` 2.0 intends to be a completely backwards-compatible drop-in replacement for SchemaPlus 1.8.x, through restricted to ActiveRecord >= 4.2 and Ruby >= 2.1

If you find any incompatibilities, please report an issue!

#### Deprecations
In cases where ActiveRecord 4.2 has introduced features previously supported only by SchemaPlus, but using different names, the SchemaPlus 2.0 family of gems now issue deprecation warnings in favor of the rails form.  The complete list of deprecations:

* Index definition deprecates these options:
  * `:conditions` => `:where`
  * `:kind` => `:using`

* `drop_table` deprecates this option:
  * `cascade: true` => `force: :cascade`

* Foreign key definitions deprecate options to `:on_update` and `:on_delete`:
  * `:set_null` => `:nullify`

* `add_foreign_key` and `remove_foreign_key` deprecate the method signature:
  * `(from_table, columns, to_table, primary_keys, options)` => `(from_table, to_table, options)`

* `ForeignKeyDefinition` deprecates accessors:
  * `#table_name` in favor of `#from_table`
  * `#column_names` in favor of `Array.wrap(#column)`
  * `#references_column_names` in favor of `#primary_key`
  * `#references_table_name in favor of `#to_table`

* `IndexDefinition` deprecates accessors:
  * `#conditions` in favor of `#where`
  * `#kind` in favor of `#using.to_s`

## Compatibility

SchemaPlus 2.x is tested against all combinations of:

<!-- SCHEMA_DEV: MATRIX - begin -->
<!-- These lines are auto-generated by schema_dev based on schema_dev.yml -->
* ruby **2.1.5** with activerecord **4.2.0**, using **mysql2**, **sqlite3** or **postgresql**
* ruby **2.1.5** with activerecord **4.2.1**, using **mysql2**, **sqlite3** or **postgresql**

<!-- SCHEMA_DEV: MATRIX - end -->

## Installation

Install from http://rubygems.org via

    $ gem install "schema_plus"

or in a Gemfile

    gem "schema_plus"

## History

*   See [CHANGELOG](CHANGELOG.md) for per-version release notes.

*   SchemaPlus was originally derived from several "Red Hill On Rails" plugins created by [@harukizaemon](https://github.com/harukizaemon)

*   SchemaPlus was created in 2011 by [@mlomnicki](https://github.com/mlomnicki) and [@ronen](https://github.com/ronen)

*   And [lots of contributors](https://github.com/SchemaPlus/schema_plus/graphs/contributors) since then.

---
---

# Prerelease:  Documentation of features still be moved into separate feature gems


> **NOTE** The documentation in this README is leftover from the 1.x branch; the functionality is the same, but some of the core features of schema_plus (such as foreign keys) are now provided by ActiveRecord 4.2.  schema_plus still provides extra functionality beyond AR 4.2, but the documentation needs to be updated to be clear what's an enhancement of AR 4.2 capabilities rather than completely new features.

### Foreign Key Constraints

SchemaPlus adds support for foreign key constraints. In fact, for the common
convention that you name a column with suffix `_id` to indicate that it's a
foreign key, SchemaPlus automatically defines the appropriate constraint.

SchemaPlus also creates foreign key constraints for rails' `t.references` or
`t.belongs_to`, which take the singular of the referenced table name and
implicitly create the column suffixed with `_id`.

You can explicitly specify whether or not to generate a foreign key
constraint, and specify or override automatic options, using the
`:foreign_key` keyword

Here are some examples:

    t.integer :author_id                              # automatically references table 'authors', key id
    t.integer :parent_id                              # special name parent_id automatically references its own table (for tree nodes)
    t.integer :author_id, foreign_key: true           # same as default automatic behavior
    t.integer :author,    foreign_key: true           # non-conventional column name needs to force creation, table name is assumed to be 'authors'
    t.integer :author_id, foreign_key: false          # don't create a constraint

    t.integer :author_id, foreign_key: { references: :authors }        # same as automatic behavior
    t.integer :author,    foreign_key: { reference: :authors}          # same default name
    t.integer :author_id, foreign_key: { references: [:authors, :id] } # same as automatic behavior
    t.integer :author_id, foreign_key: { references: :people }         # override table name
    t.integer :author_id, foreign_key: { references: [:people, :ssn] } # override table name and key
    t.integer :author_id, foreign_key: { references: nil }             # don't create a constraint
    t.integer :author_id, foreign_key: { name: "my_fk" }               # override default generated constraint name
    t.integer :author_id, foreign_key: { on_delete: :cascade }
    t.integer :author_id, foreign_key: { on_update: :set_null }
    t.integer :author_id, foreign_key: { deferrable: true }
    t.integer :author_id, foreign_key: { deferrable: :initially_deferred }

Of course the options can be combined, e.g.

    t.integer :author_id, foreign_key: { name: "my_fk", on_delete: :no_action }

As a shorthand, all options except `:name` can be specified without placing
them in a hash, e.g.

    t.integer :author_id, on_delete: :cascade
    t.integer :author_id, references: nil

The foreign key behavior can be configured globally (see Config) or per-table
(see create_table).

To examine your foreign key constraints, `connection.foreign_keys` returns a
list of foreign key constraints defined for a given table, and
`connection.reverse_foreign_keys` returns a list of foreign key constraints
that reference a given table.  See doc at
[SchemaPlus::ActiveRecord::ConnectionAdapters::ForeignKeyDefinition](http://rubydoc.info/gems/schema_plus/SchemaPlus/ActiveRecord/ConnectionAdapters/ForeignKeyDefinition).

#### Foreign Key Issues

Foreign keys can cause issues for Rails utilities that delete or load data
because referential integrity imposes a sequencing requirement that those
utilities may not take into consideration.  Monkey-patching may be required
to address some of these issues.  The Wiki article [Making yaml_db work with
foreign key constraints in PostgreSQL](https://github.com/SchemaPlus/schema_plus/wiki/Making-yaml_db-work-with-foreign-key-constraints-in-PostgreSQL)
has some information that may be of assistance in resolving these issues.

### Tables

SchemaPlus extends `create_table ... force: true` to use `:cascade`

### Schema Dump and Load (schema.rb)

When dumping `schema.rb`, SchemaPlus orders the views and tables in the schema
dump alphabetically, but subject to the requirement that each table or view be
defined before those that depend on it.  This allows all foreign key
constraints to be defined within the scope of the table definition. (Unless
there are cyclical dependencies, in which case some foreign keys constraints
must be defined later.)

Also, when dumping `schema.rb`, SchemaPlus dumps explicit foreign key
definition statements rather than relying on the auto-creation behavior, for
maximum clarity and for independence from global config.  And correspondingly,
when loading a schema, i.e. with the context of `ActiveRecord::Schema.define`,
SchemaPlus ensures that auto creation of foreign key constraints is turned off
regardless of the global setting.  But if for some reason you are creating
your schema.rb file by hand, and would like to take advantage of auto-creation
of foreign key constraints, you can re-enable it:

    ActiveRecord::Schema.define do
        SchemaPlus::ForeignKeys.config.auto_create = true
        SchemaPlus::ForeignKeys.config.auto_index = true

        create_table ...etc...
    end


