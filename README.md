<<<<<<< HEAD
:warning::warning:

THIS IS A COPY OF PAPERTRAIL 14.0

This is being used for migrating to a new version of PaperTrail in `refi` only

DO NOT USE

:warning::warning:

# MotorefiPaperTrail

[![Build Status][4]][5]
[![Gem Version][53]][54]
[![SemVer][55]][56]

Track changes to your models, for auditing or versioning. See how a model looked
at any stage in its lifecycle, revert it to any version, or restore it after it
has been destroyed.

## Documentation

This is the _user guide_. See also, the
[API reference](https://www.rubydoc.info/gems/motorefi_paper_trail).

Choose version:
[Unreleased](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/master/README.md),
[14.0](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v14.0.0/README.md),
[13.0](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v13.0.0/README.md),
[12.3](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v12.3.0/README.md),
[11.1](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v11.1.0/README.md),
[10.3](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v10.3.1/README.md),
[9.2](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v9.2.0/README.md),
[8.1](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v8.1.2/README.md),
[7.1](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v7.1.3/README.md),
[6.0](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v6.0.2/README.md),
[5.2](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v5.2.3/README.md),
[4.2](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v4.2.0/README.md),
[3.0](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v3.0.9/README.md),
[2.7](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v2.7.2/README.md),
[1.6](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/v1.6.5/README.md)

## Table of Contents

<!-- toc -->

- [1. Introduction](#1-introduction)
  - [1.a. Compatibility](#1a-compatibility)
  - [1.b. Installation](#1b-installation)
  - [1.c. Basic Usage](#1c-basic-usage)
  - [1.d. API Summary](#1d-api-summary)
  - [1.e. Configuration](#1e-configuration)
- [2. Limiting What is Versioned, and When](#2-limiting-what-is-versioned-and-when)
  - [2.a. Choosing Lifecycle Events To Monitor](#2a-choosing-lifecycle-events-to-monitor)
  - [2.b. Choosing When To Save New Versions](#2b-choosing-when-to-save-new-motorefi_versions)
  - [2.c. Choosing Attributes To Monitor](#2c-choosing-attributes-to-monitor)
  - [2.d. Turning MotorefiPaperTrail Off](#2d-turning-papertrail-off)
  - [2.e. Limiting the Number of Versions Created](#2e-limiting-the-number-of-motorefi_versions-created)
- [3. Working With Versions](#3-working-with-motorefi_versions)
  - [3.a. Reverting And Undeleting A Model](#3a-reverting-and-undeleting-a-model)
  - [3.b. Navigating Versions](#3b-navigating-motorefi_versions)
  - [3.c. Diffing Versions](#3c-diffing-motorefi_versions)
  - [3.d. Deleting Old Versions](#3d-deleting-old-motorefi_versions)
  - [3.e. Queries](#3e-queries)
  - [3.f. Defunct `item_id`s](#3f-defunct-item_ids)
- [4. Saving More Information About Versions](#4-saving-more-information-about-motorefi_versions)
  - [4.a. Finding Out Who Was Responsible For A Change](#4a-finding-out-who-was-responsible-for-a-change)
  - [4.b. Associations](#4b-associations)
  - [4.c. Storing Metadata](#4c-storing-metadata)
- [5. ActiveRecord](#5-activerecord)
  - [5.a. Single Table Inheritance (STI)](#5a-single-table-inheritance-sti)
  - [5.b. Configuring the `motorefi_versions` Association](#5b-configuring-the-motorefi_versions-association)
  - [5.c. Generators](#5c-generators)
  - [5.d. Protected Attributes](#5d-protected-attributes)
- [6. Extensibility](#6-extensibility)
  - [6.a. Custom Version Classes](#6a-custom-version-classes)
  - [6.b. Custom Serializer](#6b-custom-serializer)
  - [6.c. Custom Object Changes](#6c-custom-object-changes)
  - [6.d. Excluding the Object Column](#6d-excluding-the-object-column)
- [7. Testing](#7-testing)
  - [7.a. Minitest](#7a-minitest)
  - [7.b. RSpec](#7b-rspec)
  - [7.c. Cucumber](#7c-cucumber)
  - [7.d. Spork](#7d-spork)
  - [7.e. Zeus or Spring](#7e-zeus-or-spring)
- [8. MotorefiPaperTrail Plugins](#8-papertrail-plugins)
- [9. Integration with Other Libraries](#9-integration-with-other-libraries)
- [10. Related Libraries and Ports](#10-related-libraries-and-ports)
- [Articles](#articles)
- [Problems](#problems)
- [Contributors](#contributors)
- [Contributing](#contributing)
- [Inspirations](#inspirations)
- [Intellectual Property](#intellectual-property)

<!-- tocstop -->

## 1. Introduction

### 1.a. Compatibility

| motorefi_paper_trail | branch     | ruby     | activerecord  |
| -------------------- | ---------- | -------- | ------------- |
| unreleased           | master     | >= 2.7.0 | >= 6.0, < 7.1 |
| 14                   | 14-stable  | >= 2.7.0 | >= 6.0, < 7.1 |
| 13                   | 13-stable  | >= 2.6.0 | >= 5.2, < 7.1 |
| 12                   | 12-stable  | >= 2.6.0 | >= 5.2, < 7.1 |
| 11                   | 11-stable  | >= 2.4.0 | >= 5.2, < 6.1 |
| 10                   | 10-stable  | >= 2.3.0 | >= 4.2, < 6.1 |
| 9                    | 9-stable   | >= 2.3.0 | >= 4.2, < 5.3 |
| 8                    | 8-stable   | >= 2.2.0 | >= 4.2, < 5.2 |
| 7                    | 7-stable   | >= 2.1.0 | >= 4.0, < 5.2 |
| 6                    | 6-stable   | >= 1.9.3 | >= 4.0, < 5.2 |
| 5                    | 5-stable   | >= 1.9.3 | >= 3.0, < 5.1 |
| 4                    | 4-stable   | >= 1.8.7 | >= 3.0, < 5.1 |
| 3                    | 3.0-stable | >= 1.8.7 | >= 3.0, < 5   |
| 2                    | 2.7-stable | >= 1.8.7 | >= 3.0, < 4   |
| 1                    | rails2     | >= 1.8.7 | >= 2.3, < 3   |

Experts: to install incompatible motorefi_versions of activerecord, see
`motorefi_paper_trail/compatibility.rb`.

### 1.b. Installation

1.  Add MotorefiPaperTrail to your `Gemfile` and run [`bundle`][57].

    `gem 'motorefi_paper_trail'`

1.  Add a `motorefi_versions` table to your database:

    ```
    bundle exec rails generate motorefi_paper_trail:install [--with-changes]
    ```

    If tables in your project use `uuid` instead of `integers` for `id`, then use:

    ```
    bundle exec rails generate motorefi_paper_trail:install [--uuid]
    ```

    See [section 5.c. Generators](#5c-generators) for details.

    ```
    bundle exec rake db:migrate
    ```

1.  Add `has_motorefi_paper_trail` to the models you want to track.

    ```ruby
    class Widget < ActiveRecord::Base
      has_motorefi_paper_trail
    end
    ```

1.  If your controllers have a `current_user` method, you can easily [track who
    is responsible for changes](#4a-finding-out-who-was-responsible-for-a-change)
    by adding a controller callback.

        ```ruby
        class ApplicationController
          before_action :set_motorefi_paper_trail_whodunnit
        end
        ```

### 1.c. Basic Usage

Your models now have a `motorefi_versions` method which returns the "paper trail" of
changes to your model.

```ruby
widget = Widget.find 42
widget.motorefi_versions
# [<MotorefiPaperTrail::Version>, <MotorefiPaperTrail::Version>, ...]
```

Once you have a version, you can find out what happened:

```ruby
v = widget.motorefi_versions.last
v.event # 'update', 'create', 'destroy'. See also: "The motorefi_versions.event Column"
v.created_at
v.whodunnit # ID of `current_user`. Requires `set_motorefi_paper_trail_whodunnit` callback.
widget = v.reify # The widget as it was before the update (nil for a create event)
```

MotorefiPaperTrail stores the pre-change version of the model, unlike some other
auditing/versioning plugins, so you can retrieve the original version. This is
useful when you start keeping a paper trail for models that already have records
in the database.

```ruby
widget = Widget.find 153
widget.name                                 # 'Doobly'

# Add has_motorefi_paper_trail to Widget model.

widget.motorefi_versions                             # []
widget.update name: 'Wotsit'
widget.motorefi_versions.last.reify.name             # 'Doobly'
widget.motorefi_versions.last.event                  # 'update'
```

This also means that MotorefiPaperTrail does not waste space storing a version of the
object as it currently stands. The `motorefi_versions` method gives you previous
motorefi_versions; to get the current one just call a finder on your `Widget` model as
usual.

Here's a helpful table showing what MotorefiPaperTrail stores:

| _Event_        | _create_ | _update_ | _destroy_ |
| -------------- | -------- | -------- | --------- |
| _Model Before_ | nil      | widget   | widget    |
| _Model After_  | widget   | widget   | nil       |

MotorefiPaperTrail stores the values in the Model Before row. Most other
auditing/versioning plugins store the After row.

### 1.d. API Summary

An introductory sample of common features.

When you declare `has_motorefi_paper_trail` in your model, you get these methods:

```ruby
class Widget < ActiveRecord::Base
  has_motorefi_paper_trail
end

# Returns this widget's motorefi_versions.  You can customise the name of the
# association, but overriding this method is not supported.
widget.motorefi_versions

# Return the version this widget was reified from, or nil if it is live.
# You can customise the name of the method.
widget.version

# Returns true if this widget is the current, live one; or false if it is from
# a previous version.
widget.motorefi_paper_trail.live?

# Returns who put the widget into its current state.
widget.motorefi_paper_trail.originator

# Returns the widget (not a version) as it looked at the given timestamp.
widget.motorefi_paper_trail.version_at(timestamp)

# Returns the widget (not a version) as it was most recently.
widget.motorefi_paper_trail.previous_version

# Returns the widget (not a version) as it became next.
widget.motorefi_paper_trail.next_version
```

And a `MotorefiPaperTrail::Version` instance (which is just an ordinary ActiveRecord
instance, with all the usual methods) has methods such as:

```ruby
# Returns the item restored from this version.
version.reify(options = {})

# Return a new item from this version
version.reify(dup: true)

# Returns who put the item into the state stored in this version.
version.motorefi_paper_trail_originator

# Returns who changed the item from the state it had in this version.
version.terminator
version.whodunnit
version.version_author

# Returns the next version.
version.next

# Returns the previous version.
version.previous

# Returns the index of this version in all the motorefi_versions.
version.index

# Returns the event that caused this version (create|update|destroy).
version.event
```

This is just a sample of common features. Keep reading for more.

### 1.e. Configuration

Many aspects of MotorefiPaperTrail are configurable for individual models; typically
this is achieved by passing options to the `has_motorefi_paper_trail` method within
a given model.

Some aspects of MotorefiPaperTrail are configured globally for all models. These
settings are assigned directly on the `MotorefiPaperTrail.config` object.
A common place to put these settings is in a Rails initializer file
such as `config/initializers/motorefi_paper_trail.rb` or in an environment-specific
configuration file such as `config/environments/test.rb`.

#### 1.e.1 Global

Global configuration options affect all threads.

- association_reify_error_behaviour
- enabled
- has_motorefi_paper_trail_defaults
- object_changes_adapter
- serializer
- version_limit

Syntax example: (options described in detail later)

```ruby
# config/initializers/motorefi_paper_trail.rb
MotorefiPaperTrail.config.enabled = true
MotorefiPaperTrail.config.has_motorefi_paper_trail_defaults = {
  on: %i[create update destroy]
}
MotorefiPaperTrail.config.version_limit = 3
```

These options are intended to be set only once, during app initialization (eg.
in `config/initializers`). It is unsafe to change them while the app is running.
In contrast, `MotorefiPaperTrail.request` has various options that only apply to a
single HTTP request and thus are safe to use while the app is running.

## 2. Limiting What is Versioned, and When

### 2.a. Choosing Lifecycle Events To Monitor

You can choose which events to track with the `on` option. For example, if
you only want to track `update` events:

```ruby
class Article < ActiveRecord::Base
  has_motorefi_paper_trail on: [:update]
end
```

`has_motorefi_paper_trail` installs [callbacks][52] for the specified lifecycle events.

There are four potential callbacks, and the default is to install all four, ie.
`on: [:create, :destroy, :touch, :update]`.

#### The `motorefi_versions.event` Column

Your `motorefi_versions` table has an `event` column with three possible values:

| _event_ | _callback_    |
| ------- | ------------- |
| create  | create        |
| destroy | destroy       |
| update  | touch, update |

You may also have the `MotorefiPaperTrail::Version` model save a custom string in its
`event` field instead of the typical `create`, `update`, `destroy`. MotorefiPaperTrail
adds an `attr_accessor` to your model named `motorefi_paper_trail_event`, and will insert
it, if present, in the `event` column.

```ruby
a = Article.create
a.motorefi_versions.size                           # 1
a.motorefi_versions.last.event                     # 'create'
a.motorefi_paper_trail_event = 'update title'
a.update title: 'My Title'
a.motorefi_versions.size                           # 2
a.motorefi_versions.last.event                     # 'update title'
a.motorefi_paper_trail_event = nil
a.update title: 'Alternate'
a.motorefi_versions.size                           # 3
a.motorefi_versions.last.event                     # 'update'
```

#### Controlling the Order of AR Callbacks

If there are other callbacks in your model, their order relative to those
installed by `has_motorefi_paper_trail` may matter. If you need to control
their order, use the `motorefi_paper_trail_on_*` methods.

```ruby
class Article < ActiveRecord::Base
  # Include MotorefiPaperTrail, but do not install any callbacks. Passing the
  # empty array to `:on` omits callbacks.
  has_motorefi_paper_trail on: []

  # Add callbacks in the order you need.
  motorefi_paper_trail.on_destroy    # add destroy callback
  motorefi_paper_trail.on_update     # etc.
  motorefi_paper_trail.on_create
  motorefi_paper_trail.on_touch
end
```

The `motorefi_paper_trail.on_destroy` method can be further configured to happen
`:before` or `:after` the destroy event. Until MotorefiPaperTrail 4, the default was
`:after`. Starting with MotorefiPaperTrail 5, the default is `:before`, to support
ActiveRecord 5. (see https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/pull/683)

### 2.b. Choosing When To Save New Versions

You can choose the conditions when to add new motorefi_versions with the `if` and
`unless` options. For example, to save motorefi_versions only for US non-draft
translations:

```ruby
class Translation < ActiveRecord::Base
  has_motorefi_paper_trail if:     Proc.new { |t| t.language_code == 'US' },
                  unless: Proc.new { |t| t.type == 'DRAFT'       }
end
```

#### Choosing Based on Changed Attributes

Starting with MotorefiPaperTrail 4.0, motorefi_versions are saved during an after-callback. If
you decide whether to save a new version based on changed attributes,
use attribute_name_was instead of attribute_name.

#### Saving a New Version Manually

You may want to save a new version regardless of options like `:on`, `:if`, or
`:unless`. Or, in rare situations, you may want to save a new version even if
the record has not changed.

```ruby
my_model.motorefi_paper_trail.save_with_version
```

### 2.c. Choosing Attributes To Monitor

#### Ignore

If you don't want a version created when only a certain attribute changes, you can `ignore` that attribute:

```ruby
class Article < ActiveRecord::Base
  has_motorefi_paper_trail ignore: [:title, :rating]
end
```

Changes to just the `title` or `rating` will not create a version record.
Changes to other attributes will create a version record.

```ruby
a = Article.create
a.motorefi_versions.length                         # 1
a.update title: 'My Title', rating: 3
a.motorefi_versions.length                         # 1
a.update title: 'Greeting', content: 'Hello'
a.motorefi_versions.length                         # 2
a.motorefi_paper_trail.previous_version.title      # 'My Title'
```

Note: ignored fields will be stored in the version records. If you want to keep a field out of the motorefi_versions table, use [`:skip`](#skip) instead of `:ignore`; skipped fields are also implicitly ignored.

The `:ignore` option can also accept `Hash` arguments that we are considering deprecating.

```ruby
class Article < ActiveRecord::Base
  has_motorefi_paper_trail ignore: [:title, { color: proc { |obj| obj.color == "Yellow" } }]
end
```

#### Only

Or, you can specify a list of the `only` attributes you care about:

```ruby
class Article < ActiveRecord::Base
  has_motorefi_paper_trail only: [:title]
end
```

Only changes to the `title` will create a version record.

```ruby
a = Article.create
a.motorefi_versions.length                         # 1
a.update title: 'My Title'
a.motorefi_versions.length                         # 2
a.update content: 'Hello'
a.motorefi_versions.length                         # 2
a.motorefi_paper_trail.previous_version.content    # nil
```

The `:only` option can also accept `Hash` arguments that we are considering deprecating.

```ruby
class Article < ActiveRecord::Base
  has_motorefi_paper_trail only: [{ title: Proc.new { |obj| !obj.title.blank? } }]
end
```

If the `title` is not blank, then only changes to the `title`
will create a version record.

```ruby
a = Article.create
a.motorefi_versions.length                         # 1
a.update content: 'Hello'
a.motorefi_versions.length                         # 2
a.update title: 'Title One'
a.motorefi_versions.length                         # 3
a.update content: 'Hai'
a.motorefi_versions.length                         # 3
a.motorefi_paper_trail.previous_version.content    # "Hello"
a.update title: 'Title Two'
a.motorefi_versions.length                         # 4
a.motorefi_paper_trail.previous_version.content    # "Hai"
```

Configuring both `:ignore` and `:only` is not recommended, but it should work as
expected. Passing both `:ignore` and `:only` options will result in the
article being saved if a changed attribute is included in `:only` but not in
`:ignore`.

#### Skip

If you never want a field's values in the motorefi_versions table, you can `:skip` the attribute. As with `:ignore`,
updates to these attributes will not create a version record. In addition, if a
version record is created for some other reason, these attributes will not be
persisted.

```ruby
class Author < ActiveRecord::Base
  has_motorefi_paper_trail skip: [:social_security_number]
end
```

Author's social security numbers will never appear in the motorefi_versions log, and if an author updates only their social security number, it won't create a version record.

#### Comparing `:ignore`, `:only`, and `:skip`

- `:only` is basically the same as `:ignore`, but its inverse.
- `:ignore` controls whether motorefi_paper_trail will create a version record or not.
- `:skip` controls whether motorefi_paper_trail will save that field with the version record.
- Skipped fields are also implicitly ignored. motorefi_paper_trail does this internally.
- Ignored fields are not implicitly skipped.

So:

- Ignore a field if you don't want a version record created when it's the only field to change.
- Skip a field if you don't want it to be saved with any version records.

### 2.d. Turning MotorefiPaperTrail Off

MotorefiPaperTrail is on by default, but sometimes you don't want to record motorefi_versions.

#### Per Process

Turn MotorefiPaperTrail off for **all threads** in a `ruby` process.

```ruby
MotorefiPaperTrail.enabled = false
```

**Do not use this in production** unless you have a good understanding of
threads vs. processes.

A legitimate use case is to speed up tests. See [Testing](#7-testing) below.

#### Per HTTP Request

```ruby
MotorefiPaperTrail.request(enabled: false) do
  # no motorefi_versions created
end
```

or,

```ruby
MotorefiPaperTrail.request.enabled = false
# no motorefi_versions created
MotorefiPaperTrail.request.enabled = true
```

#### Per Class

In the rare case that you need to disable versioning for one model while
keeping versioning enabled for other models, use:

```ruby
MotorefiPaperTrail.request.disable_model(Banana)
# changes to Banana model do not create motorefi_versions,
# but eg. changes to Kiwi model do.
MotorefiPaperTrail.request.enable_model(Banana)
MotorefiPaperTrail.request.enabled_for_model?(Banana) # => true
```

This setting, as with all `MotorefiPaperTrail.request` settings, affects only the
current request, not all threads.

For this rare use case, there is no convenient way to pass a block.

##### In a Rails Controller Callback (Not Recommended)

MotorefiPaperTrail installs a callback in your rails controllers. The installed
callback will call `motorefi_paper_trail_enabled_for_controller`, which you can
override.

```ruby
class ApplicationController < ActionController::Base
  def motorefi_paper_trail_enabled_for_controller
    # Don't omit `super` without a good reason.
    super && request.user_agent != 'Disable User-Agent'
  end
end
```

Because you are unable to control the order of callback execution, this
technique is not recommended, but is preserved for backwards compatibility.

It would be better to install your own callback and use
`MotorefiPaperTrail.request.enabled=` as you see fit.

#### Per Method (Removed)

The `widget.motorefi_paper_trail.without_versioning` method was removed in v10, without
an exact replacement. To disable versioning, use the [Per Class](#per-class) or
[Per HTTP Request](#per-http-request) methods.

### 2.e. Limiting the Number of Versions Created

Configure `version_limit` to cap the number of motorefi_versions saved per record. This
does not apply to `create` events.

```ruby
# Limit: 4 motorefi_versions per record (3 most recent, plus a `create` event)
MotorefiPaperTrail.config.version_limit = 3
# Remove the limit
MotorefiPaperTrail.config.version_limit = nil
```

#### 2.e.1 Per-model limit

Models can override the global `MotorefiPaperTrail.config.version_limit` setting.

Example:

```
# initializer
MotorefiPaperTrail.config.version_limit = 10

# At most 10 motorefi_versions
has_motorefi_paper_trail

# At most 3 motorefi_versions (2 updates, 1 create). Overrides global version_limit.
has_motorefi_paper_trail limit: 2

# Infinite motorefi_versions
has_motorefi_paper_trail limit: nil
```

## 3. Working With Versions

### 3.a. Reverting And Undeleting A Model

MotorefiPaperTrail makes reverting to a previous version easy:

```ruby
widget = Widget.find 42
widget.update name: 'Blah blah'
# Time passes....
widget = widget.motorefi_paper_trail.previous_version  # the widget as it was before the update
widget.save                                   # reverted
```

Alternatively you can find the version at a given time:

```ruby
widget = widget.motorefi_paper_trail.version_at(1.day.ago)  # the widget as it was one day ago
widget.save                                        # reverted
```

Note `version_at` gives you the object, not a version, so you don't need to call
`reify`.

Undeleting is just as simple:

```ruby
widget = Widget.find(42)
widget.destroy
# Time passes....
widget = Widget.new(id:42)    # creating a new object with the same id, re-establishes the link
motorefi_versions = widget.motorefi_versions    # motorefi_versions ordered by motorefi_versions.created_at, ascending
widget = motorefi_versions.last.reify  # the widget as it was before destruction
widget.save                   # the widget lives!
```

You could even use MotorefiPaperTrail to implement an undo system; [Ryan Bates has!][3]

If your model uses [optimistic locking][1] don't forget to [increment your
`lock_version`][2] before saving or you'll get a `StaleObjectError`.

### 3.b. Navigating Versions

You can call `previous_version` and `next_version` on an item to get it as it
was/became. Note that these methods reify the item for you.

```ruby
live_widget = Widget.find 42
live_widget.motorefi_versions.length                       # 4, for example
widget = live_widget.motorefi_paper_trail.previous_version # => widget == live_widget.motorefi_versions.last.reify
widget = widget.motorefi_paper_trail.previous_version      # => widget == live_widget.motorefi_versions[-2].reify
widget = widget.motorefi_paper_trail.next_version          # => widget == live_widget.motorefi_versions.last.reify
widget.motorefi_paper_trail.next_version                   # live_widget
```

If instead you have a particular `version` of an item you can navigate to the
previous and next motorefi_versions.

```ruby
widget = Widget.find 42
version = widget.motorefi_versions[-2]    # assuming widget has several motorefi_versions
previous_version = version.previous
next_version = version.next
```

You can find out which of an item's motorefi_versions yours is:

```ruby
current_version_number = version.index    # 0-based
```

If you got an item by reifying one of its motorefi_versions, you can navigate back to the
version it came from:

```ruby
latest_version = Widget.find(42).motorefi_versions.last
widget = latest_version.reify
widget.version == latest_version    # true
```

You can find out whether a model instance is the current, live one -- or whether
it came instead from a previous version -- with `live?`:

```ruby
widget = Widget.find 42
widget.motorefi_paper_trail.live?            # true
widget = widget.motorefi_paper_trail.previous_version
widget.motorefi_paper_trail.live?            # false
```

See also: Section 3.e. Queries

### 3.c. Diffing Versions

There are two scenarios: diffing adjacent motorefi_versions and diffing non-adjacent
motorefi_versions.

The best way to diff adjacent motorefi_versions is to get MotorefiPaperTrail to do it for you. If
you add an `object_changes` column to your `motorefi_versions` table, MotorefiPaperTrail will
store the `changes` diff in each version. Ignored attributes are omitted.

```ruby
widget = Widget.create name: 'Bob'
widget.motorefi_versions.last.changeset # reads object_changes column
# {
#   "name"=>[nil, "Bob"],
#   "created_at"=>[nil, 2015-08-10 04:10:40 UTC],
#   "updated_at"=>[nil, 2015-08-10 04:10:40 UTC],
#   "id"=>[nil, 1]
# }
widget.update name: 'Robert'
widget.motorefi_versions.last.changeset
# {
#   "name"=>["Bob", "Robert"],
#   "updated_at"=>[2015-08-10 04:13:19 UTC, 2015-08-10 04:13:19 UTC]
# }
widget.destroy
widget.motorefi_versions.last.changeset
# {}
```

Prior to 10.0.0, the `object_changes` were only stored for create and update
events. As of 10.0.0, they are stored for all three events.

MotorefiPaperTrail doesn't use diffs internally.

> When I designed MotorefiPaperTrail I wanted simplicity and robustness so I decided to
> make each version of an object self-contained. A version stores all of its
> object's data, not a diff from the previous version. This means you can
> delete any version without affecting any other. -Andy

To diff non-adjacent motorefi_versions you'll have to write your own code. These
libraries may help:

For diffing two strings:

- [htmldiff][19]: expects but doesn't require HTML input and produces HTML
  output. Works very well but slows down significantly on large (e.g. 5,000
  word) inputs.
- [differ][20]: expects plain text input and produces plain
  text/coloured/HTML/any output. Can do character-wise, word-wise, line-wise,
  or arbitrary-boundary-string-wise diffs. Works very well on non-HTML input.
- [diff-lcs][21]: old-school, line-wise diffs.

Unfortunately, there is no currently widely available and supported library for diffing two ActiveRecord objects.

### 3.d. Deleting Old Versions

Over time your `motorefi_versions` table will grow to an unwieldy size. Because each
version is self-contained (see the Diffing section above for more) you can
simply delete any records you don't want any more. For example:

```sql
sql> delete from motorefi_versions where created_at < '2010-06-01';
```

```ruby
MotorefiPaperTrail::Version.where('created_at < ?', 1.day.ago).delete_all
```

### 3.e. Queries

You can query records in the `motorefi_versions` table based on their `object` or
`object_changes` columns.

```ruby
# Find motorefi_versions that meet these criteria.
MotorefiPaperTrail::Version.where_object(content: 'Hello', title: 'Article')

# Find motorefi_versions before and after attribute `atr` had value `v`:
MotorefiPaperTrail::Version.where_object_changes(atr: 'v')
```

See also:

- `where_object_changes_from`
- `where_object_changes_to`
- `where_attribute_changes`

Only `where_object` supports text columns. Your `object_changes` column should
be a `json` or `jsonb` column if possible. If you must use a `text` column,
you'll have to write a [custom
`object_changes_adapter`](#6c-custom-object-changes).

### 3.f. Defunct `item_id`s

The `item_id`s in your `motorefi_versions` table can become defunct over time,
potentially causing application errors when `id`s in the foreign table are
reused. `id` reuse can be an explicit choice of the application, or implicitly
caused by sequence cycling. The chance of `id` reuse is reduced (but not
eliminated) with `bigint` `id`s or `uuid`s, `no cycle`
[sequences](https://www.postgresql.org/docs/current/sql-createsequence.html),
and/or when `motorefi_versions` are periodically deleted.

Ideally, a Foreign Key Constraint (FKC) would set `item_id` to null when an item
is deleted. However, `items` is a polymorphic relationship. A partial FKC (e.g.
an FKC with a `where` clause) is possible, but only in Postgres, and it is
impractical to maintain FKCs for every versioned table unless the number of
such tables is very small.

If [per-table `Version`
classes](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail#6a-custom-version-classes)
are used, then a partial FKC is no longer needed. So, a normal FKC can be
written in any RDBMS, but it remains impractical to maintain so many FKCs.

Some applications choose to handle this problem by "soft-deleting" versioned
records, i.e. marking them as deleted instead of actually deleting them. This
completely prevents `id` reuse, but adds complexity to the application. In most
applications, this is the only known practical solution to the `id` reuse
problem.

## 4. Saving More Information About Versions

### 4.a. Finding Out Who Was Responsible For A Change

Set `MotorefiPaperTrail.request.whodunnit=`, and that value will be stored in the
version's `whodunnit` column.

```ruby
MotorefiPaperTrail.request.whodunnit = 'Andy Stewart'
widget.update name: 'Wibble'
widget.motorefi_versions.last.whodunnit # Andy Stewart
```

#### Setting `whodunnit` to a `Proc`

`whodunnit=` also accepts a `Proc`, in the rare case that lazy evaluation is
required.

```ruby
MotorefiPaperTrail.request.whodunnit = proc do
  caller.find { |c| c.starts_with? Rails.root.to_s }
end
```

Because lazy evaluation can be hard to troubleshoot, this is not
recommended for common use.

#### Setting `whodunnit` Temporarily

To set whodunnit temporarily, for the duration of a block, use
`MotorefiPaperTrail.request`:

```ruby
MotorefiPaperTrail.request(whodunnit: 'Dorian Marié') do
  widget.update name: 'Wibble'
end
```

#### Setting `whodunnit` with a controller callback

If your controller has a `current_user` method, MotorefiPaperTrail provides a
callback that will assign `current_user.id` to `whodunnit`.

```ruby
class ApplicationController
  before_action :set_motorefi_paper_trail_whodunnit
end
```

You may want `set_motorefi_paper_trail_whodunnit` to call a different method to find out
who is responsible. To do so, override the `user_for_motorefi_paper_trail` method in
your controller like this:

```ruby
class ApplicationController
  def user_for_motorefi_paper_trail
    logged_in? ? current_member.id : 'Public user'  # or whatever
  end
end
```

See also: [Setting whodunnit in the rails console][33]

#### Terminator and Originator

A version's `whodunnit` column tells us who changed the object, causing the
`version` to be stored. Because a version stores the object as it looked before
the change (see the table above), `whodunnit` tells us who _stopped_ the object
looking like this -- not who made it look like this. Hence `whodunnit` is
aliased as `terminator`.

To find out who made a version's object look that way, use
`version.motorefi_paper_trail_originator`. And to find out who made a "live" object look
like it does, call `motorefi_paper_trail_originator` on the object.

```ruby
widget = Widget.find 153                    # assume widget has 0 motorefi_versions
MotorefiPaperTrail.request.whodunnit = 'Alice'
widget.update name: 'Yankee'
widget.motorefi_paper_trail.originator               # 'Alice'
MotorefiPaperTrail.request.whodunnit = 'Bob'
widget.update name: 'Zulu'
widget.motorefi_paper_trail.originator               # 'Bob'
first_version, last_version = widget.motorefi_versions.first, widget.motorefi_versions.last
first_version.whodunnit                     # 'Alice'
first_version.motorefi_paper_trail_originator        # nil
first_version.terminator                    # 'Alice'
last_version.whodunnit                      # 'Bob'
last_version.motorefi_paper_trail_originator         # 'Alice'
last_version.terminator                     # 'Bob'
```

#### Storing an ActiveRecord globalid in whodunnit

If you would like `whodunnit` to return an `ActiveRecord` object instead of a
string, please try the [motorefi_paper_trail-globalid][37] gem.

### 4.b. Associations

To track and reify associations, use [motorefi_paper_trail-association_tracking][6] (PT-AT).

From 2014 to 2018, association tracking was an experimental feature, but many
issues were discovered. To attract new volunteers to address these issues, PT-AT
was extracted (see https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/issues/1070).

Even though it had always been an experimental feature, we didn't want the
extraction of PT-AT to be a breaking change, so great care was taken to remove
it slowly.

- In PT 9, PT-AT was kept as a runtime dependency.
- In PT 10, it became a development dependency (If you use it you must add it to
  your own `Gemfile`) and we kept running all of its tests.
- In PT 11, it will no longer be a development dependency, and it is responsible
  for its own tests.

#### 4.b.1 The optional `item_subtype` column

As of PT 10, users may add an `item_subtype` column to their `motorefi_versions` table.
When storing motorefi_versions for STI models, rails stores the base class in `item_type`
(that's just how polymorphic associations like `item` work) In addition, PT will
now store the subclass in `item_subtype`. If this column is present PT-AT will
use it to fix a rare issue with reification of STI subclasses.

```ruby
add_column :motorefi_versions, :item_subtype, :string, null: true
```

So, if you use PT-AT and STI, the addition of this column is recommended.

- https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/issues/594
- https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/pull/1143
- https://github.com/westonganger/motorefi_paper_trail-association_tracking/pull/5

### 4.c. Storing Metadata

You can add your own custom columns to your `motorefi_versions` table. Values can be
given using **Model Metadata** or **Controller Metadata**.

#### Model Metadata

You can specify metadata in the model using `has_motorefi_paper_trail(meta:)`.

```ruby
class Article < ActiveRecord::Base
  belongs_to :author
  has_motorefi_paper_trail(
    meta: {
      author_id: :author_id, # model attribute
      word_count: :count_words, # arbitrary model method
      answer: 42, # scalar value
      editor: proc { |article| article.editor.full_name } # a Proc
    }
  )
  def count_words
    153
  end
end
```

#### Metadata from Controllers

You can also store any information you like from your controller. Override
the `info_for_motorefi_paper_trail` method in your controller to return a hash whose keys
correspond to columns in your `motorefi_versions` table.

```ruby
class ApplicationController
  def info_for_motorefi_paper_trail
    { ip: request.remote_ip, user_agent: request.user_agent }
  end
end
```

#### Advantages of Metadata

Why would you do this? In this example, `author_id` is an attribute of
`Article` and MotorefiPaperTrail will store it anyway in a serialized form in the
`object` column of the `version` record. But let's say you wanted to pull out
all motorefi_versions for a particular author; without the metadata you would have to
deserialize (reify) each `version` object to see if belonged to the author in
question. Clearly this is inefficient. Using the metadata you can find just
those motorefi_versions you want:

```ruby
MotorefiPaperTrail::Version.where(author_id: author_id)
```

#### Metadata can Override MotorefiPaperTrail Columns

**Experts only**. Metadata will override the normal values that PT would have
inserted into its own columns.

| _PT Column_    | _How bad of an idea?_ | _Alternative_                         |
| -------------- | --------------------- | ------------------------------------- |
| created_at     | forbidden\*           |                                       |
| event          | meh                   | motorefi_paper_trail_event            |
| id             | forbidden             |                                       |
| item_id        | forbidden             |                                       |
| item_subtype   | forbidden             |                                       |
| item_type      | forbidden             |                                       |
| object         | a little dangerous    |                                       |
| object_changes | a little dangerous    |                                       |
| updated_at     | forbidden             |                                       |
| whodunnit      | meh                   | MotorefiPaperTrail.request.whodunnit= |

\* forbidden - raises a `MotorefiPaperTrail::InvalidOption` error as of PT 14

## 5. ActiveRecord

### 5.a. Single Table Inheritance (STI)

MotorefiPaperTrail supports [Single Table Inheritance][39], and even supports an
un-versioned base model, as of `23ffbdc7e1`.

```ruby
class Fruit < ActiveRecord::Base
  # un-versioned base model
end
class Banana < Fruit
  has_motorefi_paper_trail
end
```

However, there is a known issue when reifying [associations](#associations),
see https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/issues/594

### 5.b. Configuring the `motorefi_versions` Association

#### 5.b.1. `motorefi_versions` association

You may configure the name of the `motorefi_versions` association by passing a different
name (default is `:motorefi_versions`) in the `motorefi_versions:` options hash:

```ruby
class Post < ActiveRecord::Base
  has_motorefi_paper_trail motorefi_versions: {
    name: :drafts
  }
end

Post.new.motorefi_versions # => NoMethodError
```

You may pass a
[scope](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many-label-Scopes)
to the `motorefi_versions` association with the `scope:` option:

```ruby
class Post < ActiveRecord::Base
  has_motorefi_paper_trail motorefi_versions: {
    scope: -> { order("id desc") }
  }

  # Equivalent to:
  has_many :motorefi_versions,
    -> { order("id desc") },
    class_name: 'MotorefiPaperTrail::Version',
    as: :item
end
```

Any other [options supported by
`has_many`](https://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-has_many-label-Options)
can be passed along to the `has_many` macro via the `motorefi_versions:` options hash.

```ruby
class Post < ActiveRecord::Base
  has_motorefi_paper_trail motorefi_versions: {
    extend: VersionsExtensions,
    autosave: false
  }
end
```

Overriding (instead of configuring) the `motorefi_versions` method is not supported.
Overriding associations is not recommended in general.

#### 5.b.2. `item` association

A `MotorefiPaperTrail::Version` object `belongs_to` an `item`, the relevant record.

The `item` association is first defined in `MotorefiPaperTrail::VersionConcern`, but
associations can be redefined.

##### Example: adding a `counter_cache` to `item` association

```ruby
# app/models/motorefi_paper_trail/version.rb
module MotorefiPaperTrail
  class Version < ActiveRecord::Base
    belongs_to :item, polymorphic: true, counter_cache: true
  end
end
```

When redefining an association, its options are _replaced_ not _merged_, so
don't forget to specify the options from `MotorefiPaperTrail::VersionConcern`, like
`polymorphic`.

Be advised that redefining an association is an undocumented feature of Rails.

### 5.c. Generators

MotorefiPaperTrail has one generator, `motorefi_paper_trail:install`. It writes, but does not
run, a migration file. The migration creates the `motorefi_versions` table.

#### Reference

The most up-to-date documentation for this generator can be found by running
`rails generate motorefi_paper_trail:install --help`, but a copy is included here for
convenience.

```
Usage:
  rails generate motorefi_paper_trail:install [options]

Options:
  [--with-changes], [--no-with-changes]            # Store changeset (diff) with each version
  [--uuid]                                         # To use motorefi_paper_trail with projects using uuid for id

Runtime options:
  -f, [--force]                    # Overwrite files that already exist
  -p, [--pretend], [--no-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet]      # Suppress status output
  -s, [--skip], [--no-skip]        # Skip files that already exist

Generates (but does not run) a migration to add a motorefi_versions table.
```

### 5.d. Protected Attributes

As of version 6, PT no longer supports rails 3 or the [protected_attributes][17]
gem. If you are still using them, you may use PT 5 or lower. We recommend
upgrading to [strong_parameters][18] as soon as possible.

If you must use [protected_attributes][17] for now, and want to use PT > 5, you
can reopen `MotorefiPaperTrail::Version` and add the following `attr_accessible` fields:

```ruby
# app/models/motorefi_paper_trail/version.rb
module MotorefiPaperTrail
  class Version < ActiveRecord::Base
    include MotorefiPaperTrail::VersionConcern
    attr_accessible :item_type, :item_id, :event, :whodunnit, :object, :object_changes, :created_at
  end
end
```

This _unsupported workaround_ has been tested with protected_attributes 1.0.9 /
rails 4.2.8 / motorefi_paper_trail 7.0.3.

## 6. Extensibility

### 6.a. Custom Version Classes

You can specify custom version subclasses with the `:class_name` option:

```ruby
class PostVersion < MotorefiPaperTrail::Version
  # custom behaviour, e.g:
  self.table_name = :post_versions
end

class Post < ActiveRecord::Base
  has_motorefi_paper_trail motorefi_versions: {
    class_name: 'PostVersion'
  }
end
```

Unlike ActiveRecord's `class_name`, you'll have to supply the complete module
path to the class (e.g. `Foo::BarVersion` if your class is inside the module
`Foo`).

#### Advantages

1. For models which have a lot of motorefi_versions, storing each model's motorefi_versions in a
   separate table can improve the performance of certain database queries.
1. Store different version [metadata](#4c-storing-metadata) for different models.

#### Configuration

If you are using Postgres, you should also define the sequence that your custom
version class will use:

```ruby
class PostVersion < MotorefiPaperTrail::Version
  self.table_name = :post_versions
  self.sequence_name = :post_versions_id_seq
end
```

If you only use custom version classes and don't have a `motorefi_versions` table, you must
let ActiveRecord know that your base version class (eg. `ApplicationVersion` below)
class is an `abstract_class`.

```ruby
# app/models/application_version.rb
class ApplicationVersion < ActiveRecord::Base
  include MotorefiPaperTrail::VersionConcern
  self.abstract_class = true
end

class PostVersion < ApplicationVersion
  self.table_name = :post_versions
  self.sequence_name = :post_versions_id_seq
end
```

You can also specify custom names for the motorefi_versions and version associations.
This is useful if you already have `motorefi_versions` or/and `version` methods on your
model. For example:

```ruby
class Post < ActiveRecord::Base
  has_motorefi_paper_trail motorefi_versions: { name: :motorefi_paper_trail_versions },
                  version:          :motorefi_paper_trail_version

  # Existing motorefi_versions method.  We don't want to clash.
  def motorefi_versions
    # ...
  end

  # Existing version method.  We don't want to clash.
  def version
    # ...
  end
end
```

### 6.b. Custom Serializer

By default, MotorefiPaperTrail stores your changes as a `YAML` dump. You can override
this with the serializer config option:

```ruby
MotorefiPaperTrail.serializer = MyCustomSerializer
```

A valid serializer is a `module` (or `class`) that defines a `load` and `dump`
method. These serializers are included in the gem for your convenience:

- [MotorefiPaperTrail::Serializers::YAML][24] - Default
- [MotorefiPaperTrail::Serializers::JSON][25]

#### PostgreSQL JSON column type support

If you use PostgreSQL, and would like to store your `object` (and/or
`object_changes`) data in a column of [type `json` or type `jsonb`][26], specify
`json` instead of `text` for these columns in your migration:

```ruby
create_table :motorefi_versions do |t|
  # ...
  t.json :object          # Full object changes
  t.json :object_changes  # Optional column-level changes
  # ...
end
```

If you use the PostgreSQL `json` or `jsonb` column type, you do not need
to specify a `MotorefiPaperTrail.serializer`.

##### Convert existing YAML data to JSON

If you've been using MotorefiPaperTrail for a while with the default YAML serializer
and you want to switch to JSON or JSONB, you're in a bit of a bind because
there's no automatic way to migrate your data. The first (slow) option is to
loop over every record and parse it in Ruby, then write to a temporary column:

```ruby
add_column :motorefi_versions, :new_object, :jsonb # or :json
# add_column :motorefi_versions, :new_object_changes, :jsonb # or :json

# MotorefiPaperTrail::Version.reset_column_information # needed for rails < 6

MotorefiPaperTrail::Version.where.not(object: nil).find_each do |version|
  version.update_column(:new_object, YAML.load(version.object))

  # if version.object_changes
  #   version.update_column(
  #     :new_object_changes,
  #     YAML.load(version.object_changes)
  #   )
  # end
end

remove_column :motorefi_versions, :object
# remove_column :motorefi_versions, :object_changes
rename_column :motorefi_versions, :new_object, :object
# rename_column :motorefi_versions, :new_object_changes, :object_changes
```

This technique can be very slow if you have a lot of data. Though slow, it is
safe in databases where transactions are protected against DDL, such as
Postgres. In databases without such protection, such as MySQL, a table lock may
be necessary.

If the above technique is too slow for your needs, and you're okay doing without
MotorefiPaperTrail data temporarily, you can create the new column without converting
the data.

```ruby
rename_column :motorefi_versions, :object, :old_object
add_column :motorefi_versions, :object, :jsonb # or :json
```

After that migration, your historical data still exists as YAML, and new data
will be stored as JSON. Next, convert records from YAML to JSON using a
background script.

```ruby
MotorefiPaperTrail::Version.where.not(old_object: nil).find_each do |version|
  version.update_columns old_object: nil, object: YAML.load(version.old_object)
end
```

Finally, in another migration, remove the old column.

```ruby
remove_column :motorefi_versions, :old_object
```

If you use the optional `object_changes` column, don't forget to convert it
also, using the same technique.

##### Convert a Column from Text to JSON

If your `object` column already contains JSON data, and you want to change its
data type to `json` or `jsonb`, you can use the following [DDL][36]. Of course,
if your `object` column contains YAML, you must first convert the data to JSON
(see above) before you can change the column type.

Using SQL:

```sql
alter table motorefi_versions
alter column object type jsonb
using object::jsonb;
```

Using ActiveRecord:

```ruby
class ConvertVersionsObjectToJson < ActiveRecord::Migration
  def up
    change_column :motorefi_versions, :object, 'jsonb USING object::jsonb'
  end

  def down
    change_column :motorefi_versions, :object, 'text USING object::text'
  end
end
```

### 6.c. Custom Object Changes

To fully control the contents of their `object_changes` column, expert users
can write an adapter.

```ruby
MotorefiPaperTrail.config.object_changes_adapter = MyObjectChangesAdapter.new

class MyObjectChangesAdapter
  # @param changes Hash
  # @return Hash
  def diff(changes)
    # ...
  end
end
```

You should only use this feature if you are comfortable reading PT's source to
see exactly how the adapter is used. For example, see how `diff` is used by
reading `::MotorefiPaperTrail::Events::Base#recordable_object_changes`.

An adapter can implement any or all of the following methods:

1. diff: Returns the changeset in the desired format given the changeset in the
   original format
2. load_changeset: Returns the changeset for a given version object
3. where_object_changes: Returns the records resulting from the given hash of
   attributes.
4. where*object_changes_from: Returns the records resulting from the given hash
   of attributes where the attributes changed \_from* the provided value(s).
5. where*object_changes_to: Returns the records resulting from the given hash of
   attributes where the attributes changed \_to* the provided value(s).
6. where_attribute_changes: Returns the records where the attribute changed to
   or from any value.

Depending on your needs, you may choose to implement only a subset of these
methods.

#### Known Adapters

- [motorefi_paper_trail-hashdiff](https://github.com/hashwin/motorefi_paper_trail-hashdiff)

### 6.d. Excluding the Object Column

The `object` column ends up storing a lot of duplicate data if you have models that have many columns,
and that are updated many times. You can save ~50% of storage space by removing the column from the
motorefi_versions table. It's important to note that this will disable `reify` and `where_object`.

## 7. Testing

You may want to turn MotorefiPaperTrail off to speed up your tests. See [Turning
MotorefiPaperTrail Off](#2d-turning-papertrail-off) above.

### 7.a. Minitest

First, disable PT for the entire `ruby` process.

```ruby
# in config/environments/test.rb
config.after_initialize do
  MotorefiPaperTrail.enabled = false
end
```

Then, to enable PT for specific tests, you can add a `with_versioning` test
helper method.

```ruby
# in test/test_helper.rb
def with_versioning
  was_enabled = MotorefiPaperTrail.enabled?
  was_enabled_for_request = MotorefiPaperTrail.request.enabled?
  MotorefiPaperTrail.enabled = true
  MotorefiPaperTrail.request.enabled = true
  begin
    yield
  ensure
    MotorefiPaperTrail.enabled = was_enabled
    MotorefiPaperTrail.request.enabled = was_enabled_for_request
  end
end
```

Then, use the helper in your tests.

```ruby
test 'something that needs versioning' do
  with_versioning do
    # your test
  end
end
```

### 7.b. RSpec

MotorefiPaperTrail provides a helper, `motorefi_paper_trail/frameworks/rspec.rb`, that works with
[RSpec][27] to make it easier to control when `MotorefiPaperTrail` is enabled during
testing.

```ruby
# spec/rails_helper.rb
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# ...
require 'motorefi_paper_trail/frameworks/rspec'
```

With the helper loaded, MotorefiPaperTrail will be turned off for all tests by
default. To enable MotorefiPaperTrail for a test you can either wrap the
test in a `with_versioning` block, or pass in `versioning: true` option to a
spec block.

```ruby
describe 'RSpec test group' do
  it 'by default, MotorefiPaperTrail will be turned off' do
    expect(MotorefiPaperTrail).to_not be_enabled
  end

  with_versioning do
    it 'within a `with_versioning` block it will be turned on' do
      expect(MotorefiPaperTrail).to be_enabled
    end
  end

  it 'can be turned on at the `it` or `describe` level', versioning: true do
    expect(MotorefiPaperTrail).to be_enabled
  end
end
```

The helper will also reset `whodunnit` to `nil` before each
test to help prevent data spillover between tests. If you are using MotorefiPaperTrail
with Rails, the helper will automatically set the
`MotorefiPaperTrail.request.controller_info` value to `{}` as well, again, to help
prevent data spillover between tests.

There is also a `be_versioned` matcher provided by MotorefiPaperTrail's RSpec helper
which can be leveraged like so:

```ruby
class Widget < ActiveRecord::Base
end

describe Widget do
  it 'is not versioned by default' do
    is_expected.to_not be_versioned
  end

  describe 'add versioning to the `Widget` class' do
    before(:all) do
      class Widget < ActiveRecord::Base
        has_motorefi_paper_trail
      end
    end

    it 'enables paper trail' do
      is_expected.to be_versioned
    end
  end
end
```

#### Matchers

The `have_a_version_with` matcher makes assertions about motorefi_versions using
`where_object`, based on the `object` column.

```ruby
describe '`have_a_version_with` matcher' do
  it 'is possible to do assertions on version attributes' do
    widget.update!(name: 'Leonard', an_integer: 1)
    widget.update!(name: 'Tom')
    widget.update!(name: 'Bob')
    expect(widget).to have_a_version_with name: 'Leonard', an_integer: 1
    expect(widget).to have_a_version_with an_integer: 1
    expect(widget).to have_a_version_with name: 'Tom'
  end
end
```

The `have_a_version_with_changes` matcher makes assertions about motorefi_versions using
`where_object_changes`, based on the optional
[`object_changes` column](#3c-diffing-motorefi_versions).

```ruby
describe '`have_a_version_with_changes` matcher' do
  it 'is possible to do assertions on version changes' do
    widget.update!(name: 'Leonard', an_integer: 1)
    widget.update!(name: 'Tom')
    widget.update!(name: 'Bob')
    expect(widget).to have_a_version_with_changes name: 'Leonard', an_integer: 2
    expect(widget).to have_a_version_with_changes an_integer: 2
    expect(widget).to have_a_version_with_changes name: 'Bob'
  end
end
```

For more examples of the RSpec matchers, see the
[Widget spec](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/master/spec/models/widget_spec.rb)

### 7.c. Cucumber

MotorefiPaperTrail provides a helper for [Cucumber][28] that works similar to the RSpec
helper. If you want to use the helper, you will need to require in your cucumber
helper like so:

```ruby
# features/support/env.rb

ENV["RAILS_ENV"] ||= 'cucumber'
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
# ...
require 'motorefi_paper_trail/frameworks/cucumber'
```

When the helper is loaded, MotorefiPaperTrail will be turned off for all scenarios by a
`before` hook added by the helper by default. When you want to enable MotorefiPaperTrail
for a scenario, you can wrap code in a `with_versioning` block in a step, like
so:

```ruby
Given /I want versioning on my model/ do
  with_versioning do
    # MotorefiPaperTrail will be turned on for all code inside of this block
  end
end
```

The helper will also reset the `whodunnit` value to `nil` before each
test to help prevent data spillover between tests. If you are using MotorefiPaperTrail
with Rails, the helper will automatically set the
`MotorefiPaperTrail.request.controller_info` value to `{}` as well, again, to help
prevent data spillover between tests.

### 7.d. Spork

If you want to use the `RSpec` or `Cucumber` helpers with [Spork][29], you will
need to manually require the helper(s) in your `prefork` block on your test
helper, like so:

```ruby
# spec/rails_helper.rb

require 'spork'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require 'spec_helper'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'motorefi_paper_trail/frameworks/rspec'
  require 'motorefi_paper_trail/frameworks/cucumber'
  # ...
end
```

### 7.e. Zeus or Spring

If you want to use the `RSpec` or `Cucumber` helpers with [Zeus][30] or
[Spring][31], you will need to manually require the helper(s) in your test
helper, like so:

```ruby
# spec/rails_helper.rb

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'motorefi_paper_trail/frameworks/rspec'
```

## 8. MotorefiPaperTrail Plugins

- motorefi_paper_trail-active_record
- [motorefi_paper_trail-association_tracking][6] - track and reify associations
- motorefi_paper_trail-audit
- motorefi_paper_trail-background
- [motorefi_paper_trail-globalid][49] - enhances whodunnit by adding an `actor`
- motorefi_paper_trail-hashdiff
- motorefi_paper_trail-rails
- motorefi_paper_trail-related_changes
- motorefi_paper_trail-sinatra
- motorefi_paper_trail_actor
- motorefi_paper_trail_changes
- motorefi_paper_trail_manager
- motorefi_paper_trail_scrapbook
- motorefi_paper_trail_ui
- revertible_motorefi_paper_trail
- rspec-motorefi_paper_trail
- sequel_motorefi_paper_trail

## 9. Integration with Other Libraries

- [ActiveAdmin][42]
- [motorefi_paper_trail_manager][46] - Browse, subscribe, view and revert changes to
  records with rails and motorefi_paper_trail
- [rails_admin_history_rollback][51] - History rollback for rails_admin with PT
- Sinatra - [motorefi_paper_trail-sinatra][41]
- [globalize][45] - [globalize-versioning][44]
- [solidus_papertrail][47] - PT integration for Solidus
  method to instances of MotorefiPaperTrail::Version that returns the ActiveRecord
  object who was responsible for change

## 10. Related Libraries and Ports

- [izelnakri/motorefi_paper_trail][50] - An Ecto library, inspired by PT.
- [sequelize-motorefi-paper-trail][48] - A JS library, inspired by PT. A sequelize
  plugin for tracking revision history of model instances.

## Articles

- [MotorefiPaperTrail Gem Tutorial](https://stevepolito.design/blog/motorefi-paper-trail-gem-tutorial/), 20th April 2020.
- [Jutsu #8 - Version your RoR models with MotorefiPaperTrail](http://samurails.com/gems/papertrail/),
  [Thibault](http://samurails.com/about-me/), 29th September 2014
- [Versioning with MotorefiPaperTrail](http://www.sitepoint.com/versioning-papertrail),
  [Ilya Bodrov](http://www.sitepoint.com/author/ibodrov), 10th April 2014
- [Using MotorefiPaperTrail to track stack traces](http://web.archive.org/web/20141120233916/http://rubyrailsexpert.com/?p=36),
  T James Corcoran's blog, 1st October 2013.
- [RailsCast #255 - Undo with MotorefiPaperTrail](http://railscasts.com/episodes/255-undo-with-motorefi-paper-trail),
  28th February 2011.
- [Keep a Paper Trail with MotorefiPaperTrail](http://www.linux-mag.com/id/7528),
  Linux Magazine, 16th September 2009.

## Problems

Please use GitHub's [issue tracker](https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/issues).

## Contributors

Created by Andy Stewart in 2010, maintained since 2012 by Ben Atkins, since 2015
by Jared Beck, with contributions by over 150 people.

https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/graphs/contributors

## Contributing

See our [contribution guidelines][43]

## Inspirations

- [Simply Versioned](https://github.com/jerome/simply_versioned)
- [Acts As Audited](https://github.com/collectiveidea/audited)

## Intellectual Property

Copyright (c) 2011 Andy Stewart (boss@airbladesoftware.com).
Released under the MIT licence.

[1]: http://api.rubyonrails.org/classes/ActiveRecord/Locking/Optimistic.html
[2]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/issues/163
[3]: http://railscasts.com/episodes/255-undo-with-motorefi-paper-trail
[4]: https://api.travis-ci.org/motorefi-paper-trail-gem/motorefi_paper_trail.svg?branch=master
[5]: https://travis-ci.org/motorefi-paper-trail-gem/motorefi_paper_trail
[6]: https://github.com/westonganger/motorefi_paper_trail-association_tracking
[9]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/tree/3.0-stable
[10]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/tree/2.7-stable
[11]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/tree/rails2
[14]: https://raw.github.com/motorefi-paper-trail-gem/motorefi_paper_trail/master/lib/generators/motorefi_paper_trail/templates/create_versions.rb
[16]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/issues/113
[17]: https://github.com/rails/protected_attributes
[18]: https://github.com/rails/strong_parameters
[19]: http://github.com/myobie/htmldiff
[20]: http://github.com/pvande/differ
[21]: https://github.com/halostatue/diff-lcs
[24]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/master/lib/motorefi_paper_trail/serializers/yaml.rb
[25]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/master/lib/motorefi_paper_trail/serializers/json.rb
[26]: http://www.postgresql.org/docs/9.4/static/datatype-json.html
[27]: https://github.com/rspec/rspec
[28]: http://cukes.info
[29]: https://github.com/sporkrb/spork
[30]: https://github.com/burke/zeus
[31]: https://github.com/rails/spring
[32]: http://api.rubyonrails.org/classes/ActiveRecord/AutosaveAssociation.html#method-i-mark_for_destruction
[33]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/wiki/Setting-whodunnit-in-the-rails-console
[34]: https://github.com/rails/rails/blob/591a0bb87fff7583e01156696fbbf929d48d3e54/activerecord/lib/active_record/fixtures.rb#L142
[35]: https://dev.mysql.com/doc/refman/5.6/en/fractional-seconds.html
[36]: http://www.postgresql.org/docs/9.4/interactive/ddl.html
[37]: https://github.com/ankit1910/motorefi_paper_trail-globalid
[38]: https://github.com/sferik/rails_admin
[39]: http://api.rubyonrails.org/classes/ActiveRecord/Base.html#class-ActiveRecord::Base-label-Single+table+inheritance
[40]: http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#module-ActiveRecord::Associations::ClassMethods-label-Polymorphic+Associations
[41]: https://github.com/jaredbeck/motorefi_paper_trail-sinatra
[42]: https://github.com/activeadmin/activeadmin/wiki/Auditing-via-motorefi_paper_trail-%28change-history%29
[43]: https://github.com/motorefi-paper-trail-gem/motorefi_paper_trail/blob/master/.github/CONTRIBUTING.md
[44]: https://github.com/globalize/globalize-versioning
[45]: https://github.com/globalize/globalize
[46]: https://github.com/fusion94/motorefi_paper_trail_manager
[47]: https://github.com/solidusio-contrib/solidus_papertrail
[48]: https://github.com/nielsgl/sequelize-motorefi-paper-trail
[49]: https://github.com/ankit1910/motorefi_paper_trail-globalid
[50]: https://github.com/izelnakri/motorefi_paper_trail
[51]: https://github.com/rikkipitt/rails_admin_history_rollback
[52]: http://guides.rubyonrails.org/active_record_callbacks.html
[53]: https://badge.fury.io/rb/motorefi_paper_trail.svg
[54]: https://rubygems.org/gems/motorefi_paper_trail
[55]: https://api.dependabot.com/badges/compatibility_score?dependency-name=motorefi_paper_trail&package-manager=bundler&version-scheme=semver
[56]: https://dependabot.com/compatibility-score.html?dependency-name=motorefi_paper_trail&package-manager=bundler&version-scheme=semver
[57]: https://bundler.io/v2.3/man/bundle-install.1.html
